# SQL Commands

This document contains the SQL commands we have created to perform the queries specified in the
project requirements.

## Get total lessons per month in a year

```SQL
SELECT
	total.mon as mon,
	total.sum as total,
	COALESCE(individual_lessons.sum_per_month, 0) as individual_sum,
	COALESCE(group_lessons.sum_per_month, 0) as group_sum,
	COALESCE(ensemble_lessons.sum_per_month, 0) as ensemble_sum

FROM (
	SELECT
		to_char(booking.time, 'MON') as mon,
		COUNT(id) as sum
	FROM booking
	WHERE to_char(booking.time, 'YYYY') = '2021'
	GROUP BY to_char(booking.time, 'MON')
) as total
-- individual lessons
FULL OUTER JOIN (
	SELECT
		to_char(booking.time, 'MON') as mon,
		COUNT(id) as sum_per_month
	FROM booking
	INNER JOIN
	(
		SELECT id as lesson_id
		FROM lesson
		RIGHT JOIN individual_lesson
		ON lesson.id=individual_lesson.lesson_id
	) as individual_lessons
	ON booking.lesson=individual_lessons.lesson_id
	WHERE to_char(booking.time, 'YYYY') = '2021'
	GROUP BY to_char(booking.time, 'MON')
) as individual_lessons
ON total.mon = individual_lessons.mon
-- group lessons
FULL OUTER JOIN (
	SELECT
		to_char(booking.time, 'MON') as mon,
		COUNT(id) as sum_per_month
	FROM booking
	INNER JOIN
	(
		SELECT id as lesson_id
		FROM lesson
		RIGHT JOIN group_lesson
		ON lesson.id=group_lesson.lesson_id
	) as group_lessons
	ON booking.lesson=group_lessons.lesson_id
	WHERE to_char(booking.time, 'YYYY') = '2021'
	GROUP BY to_char(booking.time, 'MON')
) as group_lessons
on total.mon = group_lessons.mon
-- ensemble lessons
FULL OUTER JOIN (
	SELECT
		to_char(booking.time, 'MON') as mon,
		COUNT(id) as sum_per_month
	FROM booking
	INNER JOIN
	(
		SELECT id as lesson_id
		FROM lesson
		RIGHT JOIN ensemble_lesson
		ON lesson.id=ensemble_lesson.lesson_id
	) as ensemble_lessons
	ON booking.lesson=ensemble_lessons.lesson_id
	WHERE to_char(booking.time, 'YYYY') = '2021'
	GROUP BY to_char(booking.time, 'MON')
) as ensemble_lessons
on total.mon = ensemble_lessons.mon
-- sort based on months
ORDER BY TO_DATE(total.mon, 'MON') ASC
;
```

`2021` is used as an example here, when actually running the query it should be replaced with
whatever year the user wants data for.

### Explanation

COALESCE means if there are no lessons of a type in a month, then it will be displayed as `0`
instead of `NULL`. Every type of lesson has it's own table, so we need to count number of lessons
on each table and then do a `FULL OUTER JOIN` between them. Since we only keep track of time using
our bookings table we do an `INNER JOIN` with booking and the lesson type table thats been
`RIGHT JOIN`ed with the generic lesson. On our `INNER JOIN`s and `RIGHT JOIN`s we join based on
lesson id which is unique. On our `FULL OUTER JOIN`s we used the months of the year to connect the
different queries to each other.

## Get amount of students with zero siblings

```SQL
SELECT (
	SELECT COUNT(*) AS num_with_2_siblings
	FROM (
		SELECT COUNT(student.parent_contact) - 1 as num_siblings
		FROM student
		WHERE student.parent_contact IS NOT null
		GROUP BY student.parent_contact
	) as sibing_count
	WHERE num_siblings = 0
) + (
	SELECT COUNT(*)
	FROM student
	WHERE student.parent_contact IS null
) as num_with_no_siblings
;
```

**Note:** Although the task doesn't differentiate between zero and any other amount of siblings, the
schema we used for our database made this a requirement.

### Explanation

We decided early on to determine siblings by a shared parent. Since not all students have a parent
assigned we need to combine those who have a parent with no other students in the system with those
who have no parent in the system. When counting how many students share a parent, we need to
subtract `1` since it also counts itself.

## Get amount of students with X siblings (x > `0`)

```SQL
SELECT COUNT(*)
FROM student
WHERE parent_contact = ANY(
	SELECT parent
	FROM (
		SELECT
			COUNT(student.parent_contact) - 1 as num_siblings,
			student.parent_contact as parent
		FROM student
		WHERE student.parent_contact IS NOT null
		GROUP BY student.parent_contact
	) as sibing_count
	WHERE num_siblings = 2
)
;
```

`2` is used as an example here, when actually running the query it should be replaced with whatever
amount of students the user wants data for.

**Note:** Although the task doesn't differentiate between zero and any other amount of siblings, the
schema we used for our database made this a requirement.

### Explanation

We group by `parent_contact` on the `student` table and count how many children each parent has
(subtracted by 1, since we want the `WHERE num_siblings = ...` clause to be explicity based on user
input). If we want to find how many students have 2 siblings, we need to find all students whose
parent has 3 children. Finally we count all students who has a parent who is part of the selected
list.

## Get lessons given by instructors for a given month (next month)

```SQL
SELECT
	instructor,
	COUNT(*) as lessons_this_month
FROM (
	SELECT lesson, time
	FROM booking
	WHERE to_char(time, 'YYYY-MON') = '2021-OCT'
	GROUP BY lesson, time
) as booked_lessons
INNER JOIN lesson
ON lesson.id = booked_lessons.lesson
GROUP BY lesson.instructor
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC
;
```

`'2021-OCT'` and `1` are used as examples here, when actually running the query they should be
replaced with whatever year and month and minimum amount of lessons respectivly the user wants data
for.

### Explanation

The instructor which teaches a lesson is defined in the `lesson` table and the time of the lesson is
defined in the `booking` table, so we need to do an `INNER JOIN` to combine the two. In the `FROM`
clause, we find the `booked_lessons` which are the unique lessons booked within the specied month.
Since there will be several bookings for the same timeslot by multiple students when it's a group-
or ensemble-lesson. Then we filter based on the user-given required lessons to appear in the list
and sort in descending order.

## Get ensemble lessons for a given week (current week)

```SQL
SELECT
	booking.lesson,
	ensemble_lesson.genre,
	to_char(booking.time, 'DY') AS weekday,
	CASE
		WHEN COUNT(*) = ensemble_lesson.max_students THEN 'None'
		WHEN COUNT(*) + 2 >= ensemble_lesson.max_students THEN 'Few' -- 1-2 seats left
		ELSE 'Many'
	END AS seats_left
FROM ensemble_lesson
INNER JOIN booking
ON ensemble_lesson.lesson_id = booking.lesson
GROUP BY
	booking.lesson,
	booking.time,
	ensemble_lesson.max_students,
	ensemble_lesson.genre
HAVING to_char(booking.time, 'YYYY-IW') = '2021-11'
ORDER BY
	ensemble_lesson.genre ASC,
	booking.time ASC -- sorts by time instead of weekday alias so that days aren't sorted as strings
;
```

`2021-11` is used an example, when actually running the query it should be replaced with whatever
year and week the user wants data for.

**Note:** Since `ensemble_lesson.max_students` and `ensemble_lesson.genre` are entierly based on
`booking.lesson` they should not affect grouping or performance.

### Explanation

`DY` is the shorthand name for a weekday (`MON`, `TUE`, etc). To display the available seats for a
lesson we used `CASE` with specified cases, 0 seats -> `'None'`, 1-2 -> `'FEW'` otherwise (i.e. more
than 2 seats) `'MANY'`. We use the `booking` table to count all available lessons for the given week
and match it with the `ensemble_lesson` table. So we do a `INNER JOIN` on the tables based on the
lesson ids. Then we do a `GROUP BY` to find the unique ensemble lessons and filter based on the week
using `HAVING` to filter on the given week.
