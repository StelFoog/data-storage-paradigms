const [_node, _name, unparsedYearWeek] = process.argv;
const yearWeek =
	unparsedYearWeek && /^\d{4}-([0-4]\d|5[0-3])$/.exec(unparsedYearWeek)
		? unparsedYearWeek
		: '2021-11';

console.log(`
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
	HAVING to_char(booking.time, 'YYYY-IW') = '${yearWeek}'
	ORDER BY
		ensemble_lesson.genre ASC,
		booking.time ASC -- sorts by time instead of weekday alias so that days aren't sorted as strings
	;
`);
