CREATE TABLE contact_details (
 id SERIAL NOT NULL,
 name VARCHAR(64) NOT NULL,
 phone_number VARCHAR(16) NOT NULL,
 email VARCHAR(64) NOT NULL
);

ALTER TABLE contact_details ADD CONSTRAINT PK_contact_details PRIMARY KEY (id);


CREATE TABLE instrument_brand (
 instrument_brand VARCHAR(64) NOT NULL
);

ALTER TABLE instrument_brand ADD CONSTRAINT PK_instrument_brand PRIMARY KEY (instrument_brand);


CREATE TABLE instrument_type (
 instrument_type VARCHAR(64) NOT NULL
);

ALTER TABLE instrument_type ADD CONSTRAINT PK_instrument_type PRIMARY KEY (instrument_type);


CREATE TABLE lesson_level (
 level VARCHAR(12) NOT NULL
);

ALTER TABLE lesson_level ADD CONSTRAINT PK_lesson_level PRIMARY KEY (level);


CREATE TABLE person (
 personal_id CHAR(12) NOT NULL,
 name VARCHAR(64) NOT NULL,
 address VARCHAR(64) NOT NULL,
 contact_details INT NOT NULL
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (personal_id);


CREATE TABLE student (
 personal_id CHAR(12) NOT NULL,
 parent_contact INT
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (personal_id);


CREATE TABLE instructor (
 personal_id CHAR(12) NOT NULL,
 ensemble_teacher BOOLEAN NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (personal_id);


CREATE TABLE instrument (
 id SERIAL NOT NULL,
 instrument_type VARCHAR(64) NOT NULL,
 instrument_brand VARCHAR(64) NOT NULL
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (id);


CREATE TABLE lesson (
 id SERIAL NOT NULL,
 level VARCHAR(12) NOT NULL,
 sibling_price INT NOT NULL,
 price INT NOT NULL,
 instructor CHAR(12) NOT NULL
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (id);


CREATE TABLE rental (
 id SERIAL NOT NULL,
 rented_at DATE NOT NULL,
 returned_at DATE,
 rented_by CHAR(12) NOT NULL,
 instrument INT NOT NULL,
 price INT NOT NULL
);

ALTER TABLE rental ADD CONSTRAINT PK_rental PRIMARY KEY (id);


CREATE TABLE teachable_instruments (
 instrument_type VARCHAR(64) NOT NULL,
 personal_id CHAR(12) NOT NULL
);

ALTER TABLE teachable_instruments ADD CONSTRAINT PK_teachable_instruments PRIMARY KEY (instrument_type,personal_id);


CREATE TABLE ensemble_lesson (
 lesson_id INT NOT NULL,
 genre VARCHAR(64) NOT NULL,
 min_students INT NOT NULL,
 max_students INT NOT NULL
);

ALTER TABLE ensemble_lesson ADD CONSTRAINT PK_ensemble_lesson PRIMARY KEY (lesson_id);


CREATE TABLE group_lesson (
 lesson_id INT NOT NULL,
 min_students INT NOT NULL,
 max_students CHAR(10) NOT NULL,
 instrument_type VARCHAR(64) NOT NULL
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (lesson_id);


CREATE TABLE individual_lesson (
 lesson_id INT NOT NULL,
 instrument_type VARCHAR(64) NOT NULL
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (lesson_id);


CREATE TABLE booking (
 id SERIAL NOT NULL,
 lesson INT NOT NULL,
 student CHAR(12) NOT NULL,
 time TIMESTAMP NOT NULL
);

ALTER TABLE booking ADD CONSTRAINT PK_booking PRIMARY KEY (id);


ALTER TABLE person ADD CONSTRAINT FK_person_0 FOREIGN KEY (contact_details) REFERENCES contact_details (id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (personal_id) REFERENCES person (personal_id);
ALTER TABLE student ADD CONSTRAINT FK_student_1 FOREIGN KEY (parent_contact) REFERENCES contact_details (id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (personal_id) REFERENCES person (personal_id);


ALTER TABLE instrument ADD CONSTRAINT FK_instrument_0 FOREIGN KEY (instrument_type) REFERENCES instrument_type (instrument_type);
ALTER TABLE instrument ADD CONSTRAINT FK_instrument_1 FOREIGN KEY (instrument_brand) REFERENCES instrument_brand (instrument_brand);


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (level) REFERENCES lesson_level (level);
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_1 FOREIGN KEY (instructor) REFERENCES instructor (personal_id);


ALTER TABLE rental ADD CONSTRAINT FK_rental_0 FOREIGN KEY (rented_by) REFERENCES student (personal_id);
ALTER TABLE rental ADD CONSTRAINT FK_rental_1 FOREIGN KEY (instrument) REFERENCES instrument (id);


ALTER TABLE teachable_instruments ADD CONSTRAINT FK_teachable_instruments_0 FOREIGN KEY (instrument_type) REFERENCES instrument_type (instrument_type);
ALTER TABLE teachable_instruments ADD CONSTRAINT FK_teachable_instruments_1 FOREIGN KEY (personal_id) REFERENCES instructor (personal_id);


ALTER TABLE ensemble_lesson ADD CONSTRAINT FK_ensemble_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);
ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_1 FOREIGN KEY (instrument_type) REFERENCES instrument_type (instrument_type);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_1 FOREIGN KEY (instrument_type) REFERENCES instrument_type (instrument_type);


ALTER TABLE booking ADD CONSTRAINT FK_booking_1 FOREIGN KEY (student) REFERENCES student (personal_id);
ALTER TABLE booking ADD CONSTRAINT FK_booking_3 FOREIGN KEY (lesson) REFERENCES lesson (id);
-- ALTER TABLE booking ADD CONSTRAINT FK_booking_0 FOREIGN KEY (lesson) REFERENCES ensemble_lesson (lesson_id);
-- ALTER TABLE booking ADD CONSTRAINT FK_booking_2 FOREIGN KEY (lesson) REFERENCES group_lesson (lesson_id);
-- ALTER TABLE booking ADD CONSTRAINT FK_booking_3 FOREIGN KEY (lesson) REFERENCES individual_lesson (lesson_id);


