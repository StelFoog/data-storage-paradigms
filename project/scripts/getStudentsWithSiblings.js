const [_node, _name, unparsedSiblings] = process.argv;
const numberOfSiblings =
	unparsedSiblings && /^\d+$/.exec(unparsedSiblings) ? Number(unparsedSiblings) : 2;

if (numberOfSiblings === 0) {
	console.log(`
		SELECT (
			SELECT COUNT(*)
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
	`);
} else {
	console.log(`
		SELECT COUNT(*) as num_with_2_siblings
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
			WHERE num_siblings = ${numberOfSiblings}
		)
		;
	`);
}
