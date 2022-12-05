const [_node, _name, unparsedYear] = process.argv;
const year = unparsedYear && /^\d{4}$/.exec(unparsedYear) ? unparsedYear : '2021';

console.log(`
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
		WHERE to_char(booking.time, 'YYYY') = '${year}'
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
		WHERE to_char(booking.time, 'YYYY') = '${year}'
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
		WHERE to_char(booking.time, 'YYYY') = '${year}'
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
		WHERE to_char(booking.time, 'YYYY') = '${year}'
		GROUP BY to_char(booking.time, 'MON')
	) as ensemble_lessons
	on total.mon = ensemble_lessons.mon
	-- sort based on months
	ORDER BY TO_DATE(total.mon, 'MON') ASC
	;
`);
