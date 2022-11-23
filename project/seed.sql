INSERT INTO instrument_type (instrument_type)
VALUES
	('Piano'),
	('Guitar'),
	('Trumpet'),
	('Violin'),
	('Triangle');

INSERT INTO instrument_brand (instrument_brand)
VALUES
	('Yamaha'),
	('Gibson'),
	('Steinway'),
	('Harman');

INSERT INTO lesson_level (level)
VALUES
	('Beginner'),
	('Intermediate'),
	('Advanced');

INSERT INTO contact_details (id, name, phone_number, email)
VALUES
	(1, 'Anders Andersson', '0701231234', 'albert@namn.se'),
	(2, 'Bert Bertsson', '0734567890', 'bert@namn.se'),
	(3, 'Carl Carlsson', '0734567890', 'carl@namn.se'),
	(4, 'David Davidsson', '0734567890', 'david@namn.se'),
	(5, 'Erik Eriksson', '0734567890', 'erik@namn.se'),
	(6, 'Fredrik Fredriksson', '0734567890', 'fredrik@namn.se'),
	(7, 'Gustaf Gustafsson', '0734567890', 'gustaf@namn.se'),
	(8, 'Henrik Henriksson', '0734567890', 'henrik@namn.se'),
	(9, 'Isak Isaksson', '0734567890', 'isak@namn.se'),
	(10, 'Johan Johansson', '0734567890', 'johan@namn.se'),
	(11, 'Knut Knutsson', '0734567890', 'knut@namn.se'),
	(12, 'Lars Larsson', '0734567890', 'lars@namn.se'),
	(13, 'Magnus Magnusson', '0734567890', 'magnus@namn.se'),
	(14, 'Nils Nilsson', '0734567890', 'nils@namn.se'),
	(15, 'Oskar Oskarsson', '0734567890', 'oskar@namn.se'),
	(16, 'Per Persson', '0734567890', 'per@namn.se');

INSERT INTO person (personal_id, name, address, contact_details)
VALUES
	('200102032426', 'Anders Andersson', 'Odengatan 1', 1),
	('201203045670', 'Bert Bertsson', 'Hamngatan 2', 2),
	('199812303215', 'Carl Carlsson', 'Vasagatan 3', 3),
	('199804122124', 'David Davidsson', 'Hagagatan 4', 4),
	('198705048533', 'Erik Eriksson', 'Sergelsgatan 5', 5),
	('199506217059', 'Fredrik Fredriksson', 'Torsgatan 6', 6),
	('195909215328', 'Gustaf Gustafsson', 'Rådmansgatan 7', 7),
	('196701316686', 'Henrik Henriksson', 'Kungsgatan 8', 8),
	('199002190610', 'Isak Isaksson', 'Drottninggatan 9', 9),
	('197406037288', 'Johan Johansson', 'Hornsgatan 10', 10),
	('199706045144', 'Knut Knutsson', 'Götgatan 11', 11),
	('196903125190', 'Lars Larsson', 'Atlasgatan 12', 12);

INSERT INTO instructor (personal_id, ensemble_teacher)
VALUES
	('198705048533', FALSE),
	('195909215328', FALSE),
	('196701316686', TRUE),
	('196903125190', TRUE);

INSERT INTO student (personal_id, parent_contact)
VALUES
	('200102032426', 13),
	('201203045670', 13),
	('199812303215', 14),
	('199804122124', 15),
	('199506217059', 16),
	('199002190610', NULL),
	('197406037288', NULL),
	('199706045144', NULL);

INSERT INTO instrument (id, instrument_type, instrumet_brand)
VALUES
	(1, 'Piano', 'Yamaha'),
	(2, 'Piano', 'Yamaha'),
	(3, 'Piano', 'Steinway'),
	(4, 'Piano', 'Steinway'),
	(5, 'Piano', 'Steinway'),
	(6, 'Triangle', 'Yamaha'),
	(7, 'Trumpet', 'Gibson'),
	(8, 'Trumpet', 'Gibson'),
	(9, 'Trumpet', 'Gibson'),
	(10, 'Trumpet', 'Harman'),
	(11, 'Violin', 'Harman'),
	(12, 'Violin', 'Harman'),
	(13, 'Guitar', 'Yamaha'),
	(14, 'Guitar', 'Yamaha'),
	(15, 'Guitar', 'Gibson'),
	(16, 'Guitar', 'Gibson'),
	(17, 'Guitar', 'Gibson'),
	(18, 'Guitar', 'Steinway');

INSERT INTO rental (rented_at, returned_at, rented_by, instrument, price)
VALUES
	('2021-02-04', '2022-02-03', '200102032426', 3, 460),
	('2021-04-12', '2021-10-11', '201203045670', 6, 90),
	('2021-05-12', '2021-12-15', '197406037288', 11, 180),
	('2021-05-12', '2021-09-30', '199002190610', 7, 120),
	('2021-09-30', '2022-09-30', '199002190610', 13, 160),
	('2022-01-22', NULL, '199002190610', 18, 310),
	('2022-02-04', NULL, '200102032426', 3, 460),
	('2022-03-01', '2022-08-26', '199804122124', 1, 280),
	('2022-05-17', NULL, '199812303215', 7, 460);

INSERT INTO teachable_instruments (instrument_type, personal_id)
VALUES
	('Piano', '195909215328'),
	('Triangle', '198705048533'),
	('Trumpet', '198705048533'),
	('Guitar', '198705048533'),
	('Piano', '196701316686'),
	('Guitar', '196701316686'),
	('Violin', '196701316686'),
	('Triangle', '196701316686'),
	('Trumpet', '196903125190'),
	('Triangle', '196903125190');

INSERT INTO lesson (id, level, price, sibling_price, instructor)
VALUES
	(1, 'Beginner', 200, 160, '198705048533'),
	(2, 'Beginner', 240, 180, '198705048533'),
	(3, 'Beginner', 200, 160, '196701316686'),
	(4, 'Beginner', 160, 120, '196701316686'),
	(5, 'Beginner', 140, 110, '196903125190'),
	(6, 'Beginner', 150, 130, '196903125190'),
	(7, 'Intermediate', 340, 300, '195909215328'),
	(8, 'Intermediate', 100, 80, '198705048533'),
	(9, 'Intermediate', 260, 220, '196701316686'),
	(10, 'Intermediate', 240, 220, '196701316686'),
	(11, 'Intermediate', 200, 160, '196701316686'),
	(12, 'Intermediate', 200, 180, '196903125190'),
	(13, 'Advanced', 500, 420, '195909215328'),
	(14, 'Advanced', 340, 290, '195909215328'),
	(15, 'Advanced', 250, 230, '198705048533'),
	(16, 'Advanced', 300, 240, '196903125190');

INSERT INTO individual_lesson (lesson_id, instrument_type)
VALUES
	(1, 'Trumpet'),
	(2, 'Guitar'),
	(3, 'Piano'),
	(6, 'Triangle'),
	(7, 'Piano'),
	(9, 'Guitar'),
	(10, 'Violin'),
	(13, 'Piano'),
	(16, 'Trumpet');

INSERT INTO group_lesson (lesson_id, instrument_type, min_students, max_students)
VALUES
	(4, 'Violin', 3, 6),
	(5, 'Guitar', 4, 7),
	(8, 'Triangle', 3, 10),
	(14, 'Piano', 2, 4),
	(15, 'Guitar', 3, 6);

INSERT INTO ensemble_lesson (lesson_id, genre, min_students, max_students)
VALUES
	(11, 'Classical', 4, 7),
	(12, 'Rock', 3, 7);

INSERT INTO booking (lesson, student, time)
VALUES
	(1, '199002190610', '2021-05-30 17:00:00'),
	(1, '199002190610', '2021-06-15 17:00:00'),
	(1, '199002190610', '2021-06-30 17:00:00'),
	(1, '199002190610', '2021-07-15 17:00:00'),
	(5, '199002190610', '2021-10-15 17:00:00'),
	(5, '199002190610', '2021-10-30 17:00:00'),
	(5, '200102032426', '2021-10-15 17:00:00'),
	(5, '200102032426', '2021-10-30 17:00:00'),
	(5, '197406037288', '2021-10-15 17:00:00'),
	(5, '197406037288', '2021-10-30 17:00:00'),
	(5, '199812303215', '2021-10-15 17:00:00'),
	(5, '199812303215', '2021-10-30 17:00:00'),
	(11, '200102032426', '2022-01-20 15:00:00'),
	(11, '199706045144', '2022-01-20 15:00:00'),
	(11, '201203045670', '2022-01-20 15:00:00'),
	(11, '199506217059', '2022-01-20 15:00:00');
