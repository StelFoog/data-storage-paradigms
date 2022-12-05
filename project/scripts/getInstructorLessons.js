const [_node, _name, unparsedYearMonth] = process.argv;
const yearMonth =
	unparsedYearMonth &&
	/^\d{4}-(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)$/.exec(unparsedYearMonth)
		? unparsedYearMonth
		: '2021-OCT';

console.log(`
	SELECT
		instructor,
		COUNT(*) as lessons_this_month
	FROM (
		SELECT lesson, time
		FROM booking
		WHERE to_char(time, 'YYYY-MON') = '${yearMonth}'
		GROUP BY lesson, time
	) as booked_lessons
	INNER JOIN lesson
	ON lesson.id = booked_lessons.lesson
	GROUP BY lesson.instructor
	HAVING COUNT(*) > 1
	ORDER BY COUNT(*) DESC
;
`);
