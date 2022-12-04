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

TODO

## Get amount of students with zero siblings

```SQL
SELECT (
	SELECT COUNT(*)
	FROM (
		SELECT COUNT(student.parent_contact) - 1 as num_siblings
		FROM student
		WHERE student.parent_contact IS NOT null
		GROUP BY student.parent_contact
	) as sibing_count
	WHERE num_siblings = 0
)
+
(
	SELECT COUNT(*)
	FROM student
	WHERE student.parent_contact IS null
) as num_with_zero_siblings
;
```

**Note:** Although the task doesn't differentiate between zero and any other amount of siblings, the
schema we used for our database made this a requirement.

### Explanation

TODO

## Get amount of students with X siblings (x > `2`)

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

TODO

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

TODO

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

TODO
