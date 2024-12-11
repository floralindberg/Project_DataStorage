CREATE TABLE email (
 email_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 email VARCHAR(100)
);

ALTER TABLE email ADD CONSTRAINT PK_email PRIMARY KEY (email_id);

CREATE TABLE instrument (
 instrument_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instrument_name VARCHAR(100) NOT NULL,
 instrument_type VARCHAR(100)
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (instrument_id);

CREATE TABLE lesson_type (
 type_id INT NOT NULL,
 type_name VARCHAR(100) NOT NULL
);

ALTER TABLE lesson_type ADD CONSTRAINT PK_lesson_type PRIMARY KEY (type_id);

CREATE TABLE person (
 person_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 first_name VARCHAR(100),
 last_name VARCHAR(100),
 personal_number VARCHAR(20) NOT NULL,
 street VARCHAR(100),
 zip VARCHAR(10),
 city VARCHAR(100)
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (person_id);

CREATE TABLE person_email (
 person_id INT NOT NULL,
 email_id INT NOT NULL
);

ALTER TABLE person_email ADD CONSTRAINT PK_person_email PRIMARY KEY (person_id,email_id);

CREATE TABLE phone (
 phone_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 phone_nr VARCHAR(100)
);

ALTER TABLE phone ADD CONSTRAINT PK_phone PRIMARY KEY (phone_id);

CREATE TABLE skill_level (
 skill_id INT NOT NULL,
 skill_name VARCHAR(100) NOT NULL
);

ALTER TABLE skill_level ADD CONSTRAINT PK_skill_level PRIMARY KEY (skill_id);

CREATE TABLE student (
 student_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 number_of_rented_instruments VARCHAR(1),
 present_skill_level VARCHAR(100) NOT NULL,
 age VARCHAR(3) NOT NULL,
 parent_phone_number VARCHAR(50),
 parent_email VARCHAR(50),
 person_id INT NOT NULL
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);


ALTER TABLE student ADD CONSTRAINT CHK_max_rented_instruments CHECK (CAST(number_of_rented_instruments AS INT) <= 2);


CREATE OR REPLACE FUNCTION check_student_parent_info()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.age::INT < 18 THEN
        IF NEW.parent_phone_number IS NULL OR NEW.parent_email IS NULL THEN
            RAISE EXCEPTION 'Parent phone and email are required for students under 18';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_student_parent_info
BEFORE INSERT OR UPDATE ON student
FOR EACH ROW
EXECUTE FUNCTION check_student_parent_info();

CREATE TABLE available_instrument (
 available_instrument_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 brand VARCHAR(100),
 quantity VARCHAR(6),
 instrument_id INT NOT NULL
);

ALTER TABLE available_instrument ADD CONSTRAINT PK_available_instrument PRIMARY KEY (available_instrument_id);

CREATE TABLE instructor (
 instructor_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (instructor_id);

CREATE TABLE instructor_availability (
 start_time TIMESTAMP(10) NOT NULL,
 instructor_id INT NOT NULL,
 end_time TIMESTAMP(10) NOT NULL
);

ALTER TABLE instructor_availability ADD CONSTRAINT PK_instructor_availability PRIMARY KEY (start_time,instructor_id);

CREATE TABLE instructor_instrument (
 instructor_id INT NOT NULL,
 instrument_id INT NOT NULL
);

ALTER TABLE instructor_instrument ADD CONSTRAINT PK_instructor_instrument PRIMARY KEY (instructor_id,instrument_id);

CREATE TABLE lesson (
 lesson_id  INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 location VARCHAR(100),
 maximum_number_of_places VARCHAR(100) NOT NULL,
 skill_id INT NOT NULL,
 type_id INT NOT NULL,
 lesson_type_skill_id INT
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (lesson_id);


ALTER TABLE lesson
ADD CONSTRAINT CHK_minimum_number_of_places
CHECK (
    (type_id = 4 AND CAST(maximum_number_of_places AS INT) >= 1)
    OR (type_id != 4 AND CAST(maximum_number_of_places AS INT) > 1)
);

CREATE TABLE lesson_pricing (
 pricing_lesson_type_skill_id INT NOT NULL,
 valid_from TIMESTAMP(10),
 price VARCHAR(6) NOT NULL,
 type_id INT NOT NULL,
 skill_id INT NOT NULL
);

ALTER TABLE lesson_pricing ADD CONSTRAINT PK_lesson_pricing PRIMARY KEY (pricing_lesson_type_skill_id, valid_from);

CREATE TABLE person_phone (
 person_id INT NOT NULL,
 phone_id INT NOT NULL
);

ALTER TABLE person_phone ADD CONSTRAINT PK_person_phone PRIMARY KEY (person_id,phone_id);

CREATE TABLE rental (
 rental_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 maximum_renting_period VARCHAR(10) NOT NULL,
 student_id INT NOT NULL,
 available_instrument_id INT NOT NULL,
 start_date TIMESTAMP(10),
 end_date TIMESTAMP(10),
 status VARCHAR(100)
);

ALTER TABLE rental ADD CONSTRAINT PK_rental PRIMARY KEY (rental_id);


ALTER TABLE rental ADD CONSTRAINT CHK_rental_dates CHECK (end_date > start_date);

CREATE OR REPLACE FUNCTION validate_rental_creation()
RETURNS TRIGGER AS $$
BEGIN

    IF (SELECT CAST(number_of_rented_instruments AS INT) FROM student WHERE student_id = NEW.student_id) >= 2 THEN
        RAISE EXCEPTION 'Student already has the maximum number of rentals.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validate_rental_creation
BEFORE INSERT ON rental
FOR EACH ROW
EXECUTE FUNCTION validate_rental_creation();



CREATE OR REPLACE FUNCTION increase_rented_instruments()
RETURNS TRIGGER AS $$

BEGIN
    IF NEW.status = 'Active' THEN
      
        UPDATE student
        SET number_of_rented_instruments = CAST (number_of_rented_instruments AS INT) + 1
        WHERE student_id = NEW.student_id;

        UPDATE available_instrument
        SET quantity = CAST (quantity AS INT) - 1
        WHERE available_instrument_id = NEW.available_instrument_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_increase_rented_instruments
AFTER INSERT ON rental
FOR EACH ROW
WHEN (NEW.status = 'Active')
EXECUTE FUNCTION increase_rented_instruments();


CREATE OR REPLACE FUNCTION decrease_rented_instruments()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'Ended' THEN
        UPDATE student
        SET number_of_rented_instruments = CAST (number_of_rented_instruments AS INT) - 1
        WHERE student_id = NEW.student_id;

        UPDATE available_instrument
        SET quantity = CAST (quantity AS INT) + 1
        WHERE available_instrument_id = NEW.available_instrument_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_decrease_rented_instruments
AFTER UPDATE OF status ON rental
FOR EACH ROW
WHEN (NEW.status = 'Ended')
EXECUTE FUNCTION decrease_rented_instruments();

CREATE TABLE renting_pricing (
 available_instrument_id INT NOT NULL,
 price VARCHAR(6) NOT NULL
);

ALTER TABLE renting_pricing ADD CONSTRAINT PK_renting_pricing PRIMARY KEY (available_instrument_id);

CREATE TABLE sibling (
 student_id_sibling INT NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE sibling ADD CONSTRAINT PK_sibling PRIMARY KEY (student_id_sibling,student_id);

CREATE TABLE attended_lessons (
 attended_lessons_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 student_id INT NOT NULL,
 instructor_id INT NOT NULL,
 lesson_id  INT NOT NULL,
 date TIMESTAMP(10) NOT NULL
);

ALTER TABLE attended_lessons ADD CONSTRAINT PK_attended_lessons PRIMARY KEY (attended_lessons_id);


CREATE OR REPLACE FUNCTION calculate_lesson_type_skill_id()
RETURNS TRIGGER AS $$
BEGIN

    UPDATE lesson
    SET lesson_type_skill_id = (lesson.type_id + lesson.skill_id)
    WHERE lesson.lesson_id = NEW.lesson_id;
    

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_calculate_lesson_type_skill_id
AFTER INSERT ON attended_lessons
FOR EACH ROW
EXECUTE FUNCTION calculate_lesson_type_skill_id();

CREATE TABLE ensemble_lesson (
 lesson_id  INT NOT NULL,
 genre VARCHAR(50),
 minimum_number_of_places VARCHAR(100) NOT NULL
);

ALTER TABLE ensemble_lesson ADD CONSTRAINT PK_ensemble_lesson PRIMARY KEY (lesson_id);

CREATE TABLE ensemble_lesson_instrument (
 instrument_id INT NOT NULL,
 lesson_id  INT NOT NULL
);

ALTER TABLE ensemble_lesson_instrument ADD CONSTRAINT PK_ensemble_lesson_instrument PRIMARY KEY (instrument_id,lesson_id);

CREATE TABLE group_lesson (
 lesson_id  INT NOT NULL,
 minimum_number_of_places VARCHAR(6) NOT NULL,
 instrument_id INT NOT NULL
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (lesson_id);

CREATE TABLE individual_lesson (
 student_id INT NOT NULL,
 instructor_id INT NOT NULL,
 start_time TIMESTAMP(10) NOT NULL,
 instrument_id INT NOT NULL,
 lesson_id  INT NOT NULL,
 end_time TIMESTAMP(10),
 location VARCHAR(100),
 status VARCHAR(100)
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (student_id,instructor_id,start_time);


ALTER TABLE individual_lesson ADD CONSTRAINT CHK_individual_lesson_times CHECK (end_time > start_time);

CREATE TABLE schedule (
 start_time TIMESTAMP(10) NOT NULL,
 instructor_id INT NOT NULL,
 lesson_id  INT NOT NULL,
 end_time TIMESTAMP(10) NOT NULL,
 location VARCHAR(10) NOT NULL,
 available_places VARCHAR(10)
);

ALTER TABLE schedule ADD CONSTRAINT PK_schedule PRIMARY KEY (start_time,instructor_id,lesson_id);


ALTER TABLE schedule ADD CONSTRAINT CHK_available_places CHECK (CAST(available_places AS INT) >= 0);

ALTER TABLE schedule ADD CONSTRAINT CHK_schedule_times CHECK (end_time > start_time);

CREATE OR REPLACE FUNCTION set_available_places()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE schedule
    SET available_places = (SELECT maximum_number_of_places FROM lesson WHERE lesson_id = NEW.lesson_id)
    WHERE start_time = NEW.start_time AND instructor_id = NEW.instructor_id AND lesson_id = NEW.lesson_id;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_set_available_places
AFTER INSERT ON schedule
FOR EACH ROW
EXECUTE FUNCTION set_available_places();


CREATE TABLE schedule_booking (
    schedule_booking_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    student_id INT NOT NULL,
    status VARCHAR(100),
    start_time TIMESTAMP(10) NOT NULL,
    instructor_id INT NOT NULL,
    lesson_id INT NOT NULL
);

ALTER TABLE schedule_booking ADD CONSTRAINT PK_schedule_booking PRIMARY KEY (schedule_booking_id);

CREATE OR REPLACE FUNCTION decrease_available_places()
RETURNS TRIGGER AS $$
BEGIN

    UPDATE schedule
    SET available_places = CAST(available_places AS INT) - 1
    WHERE lesson_id = NEW.lesson_id;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to call the function after insert on schedule_booking
CREATE TRIGGER trg_decrease_available_places
AFTER INSERT ON schedule_booking
FOR EACH ROW
EXECUTE FUNCTION decrease_available_places();


ALTER TABLE person_email ADD CONSTRAINT FK_person_email_0 FOREIGN KEY (person_id) REFERENCES person (person_id);
ALTER TABLE person_email ADD CONSTRAINT FK_person_email_1 FOREIGN KEY (email_id) REFERENCES email (email_id);

ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (person_id);

ALTER TABLE available_instrument ADD CONSTRAINT FK_available_instrument_0 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);

ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (person_id);

ALTER TABLE instructor_availability ADD CONSTRAINT FK_instructor_availability_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);

ALTER TABLE instructor_instrument ADD CONSTRAINT FK_instructor_instrument_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE instructor_instrument ADD CONSTRAINT FK_instructor_instrument_1 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);

ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (skill_id) REFERENCES skill_level (skill_id);
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_1 FOREIGN KEY (type_id) REFERENCES lesson_type (type_id);

ALTER TABLE lesson_pricing ADD CONSTRAINT FK_lesson_pricing_0 FOREIGN KEY (type_id) REFERENCES lesson_type (type_id);
ALTER TABLE lesson_pricing ADD CONSTRAINT FK_lesson_pricing_1 FOREIGN KEY (skill_id) REFERENCES skill_level (skill_id);

ALTER TABLE person_phone ADD CONSTRAINT FK_person_phone_0 FOREIGN KEY (person_id) REFERENCES person (person_id);
ALTER TABLE person_phone ADD CONSTRAINT FK_person_phone_1 FOREIGN KEY (phone_id) REFERENCES phone (phone_id);

ALTER TABLE rental ADD CONSTRAINT FK_rental_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE rental ADD CONSTRAINT FK_rental_1 FOREIGN KEY (available_instrument_id) REFERENCES available_instrument (available_instrument_id);

ALTER TABLE renting_pricing ADD CONSTRAINT FK_renting_pricing_0 FOREIGN KEY (available_instrument_id) REFERENCES available_instrument (available_instrument_id);

ALTER TABLE sibling ADD CONSTRAINT FK_sibling_0 FOREIGN KEY (student_id) REFERENCES student (student_id);

ALTER TABLE attended_lessons ADD CONSTRAINT FK_attended_lessons_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE attended_lessons ADD CONSTRAINT FK_attended_lessons_1 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE attended_lessons ADD CONSTRAINT FK_attended_lessons_2 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);

ALTER TABLE ensemble_lesson ADD CONSTRAINT FK_ensemble_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);

ALTER TABLE ensemble_lesson_instrument ADD CONSTRAINT FK_ensemble_lesson_instrument_0 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);
ALTER TABLE ensemble_lesson_instrument ADD CONSTRAINT FK_ensemble_lesson_instrument_1 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);

ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);
ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_1 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);

ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_1 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_2 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);

ALTER TABLE schedule ADD CONSTRAINT FK_schedule_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);
ALTER TABLE schedule ADD CONSTRAINT FK_schedule_1 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);

ALTER TABLE schedule_booking ADD CONSTRAINT FK_schedule_booking_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE schedule_booking ADD CONSTRAINT FK_schedule_booking_1 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);
ALTER TABLE schedule_booking ADD CONSTRAINT FK_schedule_booking_2 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);


