--person
insert into person (first_name, last_name, personal_number, street, zip, city) values ('Ailina', 'O''Dulchonta', '564-62-9389', '0 Moulton Lane', '11889', 'Raofeng');
insert into person (first_name, last_name, personal_number, street, zip, city) values ('Hoyt', 'Leynton', '694-69-6644', '23804 Oxford Circle', '68401', 'Kawambwa');
insert into person (first_name, last_name, personal_number, street, zip, city) values ('Stefania', 'Garrard', '862-15-3318', '08 Sommers Circle', '39362', 'Chugur');
insert into person (first_name, last_name, personal_number, street, zip, city) values ('Bradley', 'Dallicott', '184-99-0985', '1 Cardinal Point', '14176', 'Évry');
insert into person (first_name, last_name, personal_number, street, zip, city) values ('Krystal', 'Bufton', '649-83-4717', '19618 Parkside Alley', '19321', 'Namioka');
insert into person (first_name, last_name, personal_number, street, zip, city) values ('Clarette', 'Charters', '645-79-7058', '7 Fisk Avenue', '42953', 'Santa Rosa');
insert into person (first_name, last_name, personal_number, street, zip, city) values ('Evangelia', 'Mariot', '605-07-8900', '75067 Transport Alley', '60734', 'Ushumun');
insert into person (first_name, last_name, personal_number, street, zip, city) values ('Eilis', 'Imos', '319-21-1995', '9 Cardinal Trail', '18665', 'Kolape');
insert into person (first_name, last_name, personal_number, street, zip, city) values ('Dolley', 'Masdon', '142-37-4372', '52137 Randy Point', '66042', 'Prokhladnyy');
insert into person (first_name, last_name, personal_number, street, zip, city) values ('Tabby', 'Bernaldo', '690-26-0937', '46759 Hermina Alley', '51088', 'Zhencheng');

--instrument
insert into instrument (instrument_name, instrument_type) values ('trumpet', 'brass');
insert into instrument (instrument_name, instrument_type) values ('violin', 'string');
insert into instrument (instrument_name, instrument_type) values ('drums', 'percussion');
insert into instrument (instrument_name, instrument_type) values ('clarinet', 'woodwind');
insert into instrument (instrument_name, instrument_type) values ('flute', 'woodwind');
insert into instrument (instrument_name, instrument_type) values ('guitar', 'string');
insert into instrument (instrument_name, instrument_type) values ('cello', 'string');
insert into instrument (instrument_name, instrument_type) values ('piano', 'keyboard');
insert into instrument (instrument_name, instrument_type) values ('saxophone', 'woodwind');
insert into instrument (instrument_name, instrument_type) values ('harp', 'string');

--skill_level
insert into skill_level (skill_id, skill_name) values ('1', 'beginner');
insert into skill_level (skill_id, skill_name) values ('2', 'advanced');
insert into skill_level (skill_id, skill_name) values ('3', 'advanced');

--lesson_type
insert into lesson_type (type_id, type_name) values ('4', 'individual');
insert into lesson_type (type_id, type_name) values ('8', 'group');
insert into lesson_type (type_id, type_name) values ('12', 'ensemble');

--lesson_pricing
insert into lesson_pricing (valid_from, pricing_lesson_type_skill_id, price, skill_id, type_id) values ('2022-12-01','5','450','1','4');
insert into lesson_pricing (valid_from, pricing_lesson_type_skill_id, price, skill_id, type_id) values ('2022-12-01','6','550','2','4');
insert into lesson_pricing (valid_from, pricing_lesson_type_skill_id, price, skill_id, type_id) values ('2022-12-01','7','650','3','4');
insert into lesson_pricing (valid_from, pricing_lesson_type_skill_id, price, skill_id, type_id) values ('2022-12-01','9','560','1','8');
insert into lesson_pricing (valid_from, pricing_lesson_type_skill_id, price, skill_id, type_id) values ('2022-12-01','10','660','2','8');
insert into lesson_pricing (valid_from, pricing_lesson_type_skill_id, price, skill_id, type_id) values ('2022-12-01','11','750','3','8');
insert into lesson_pricing (valid_from, pricing_lesson_type_skill_id, price, skill_id, type_id) values ('2022-12-01','13','620','1','12');
insert into lesson_pricing (valid_from, pricing_lesson_type_skill_id, price, skill_id, type_id) values ('2022-12-01','14','700','2','12');
insert into lesson_pricing (valid_from, pricing_lesson_type_skill_id, price, skill_id, type_id) values ('2022-12-01','15','850','3','12');

--lesson
insert into lesson (location, maximum_number_of_places, skill_id, type_id) values ('Room 303', '1', '1', '4');
insert into lesson (location, maximum_number_of_places, skill_id, type_id) values ('Room A', '1','2', '4');
insert into lesson (location, maximum_number_of_places, skill_id, type_id) values ('Room A', '1','3', '4');
insert into lesson (location, maximum_number_of_places, skill_id, type_id) values ('Room 202', '84','1', '8');
insert into lesson (location, maximum_number_of_places, skill_id, type_id) values ('Room 101', '71','2', '8');
insert into lesson (location, maximum_number_of_places, skill_id, type_id) values ('Room B', '36','3', '8');
insert into lesson (location, maximum_number_of_places, skill_id, type_id) values ('Room C', '80','1', '12');
insert into lesson (location, maximum_number_of_places, skill_id, type_id) values ('Room C', '8','2', '12');
insert into lesson (location, maximum_number_of_places, skill_id, type_id) values ('Room 202', '27','3', '12');
insert into lesson (location, maximum_number_of_places, skill_id, type_id) values ('Room C', '1','1', '4');
insert into lesson (location, maximum_number_of_places, skill_id, type_id) values ('Room 202', '73','2', '8');
insert into lesson (location, maximum_number_of_places, skill_id, type_id) values ('Room 303', '17','3', '12');
insert into lesson (location, maximum_number_of_places, skill_id, type_id) values ('Room 303', '1','1', '4');
insert into lesson (location, maximum_number_of_places, skill_id, type_id) values ('Room B', '47','2', '8');
insert into lesson (location, maximum_number_of_places, skill_id, type_id) values ('Room C', '31','3', '12');
insert into lesson (location, maximum_number_of_places, skill_id, type_id) values ('Room A', '1','1', '4');
insert into lesson (location, maximum_number_of_places, skill_id, type_id) values ('Room 303', '43','2', '8');
insert into lesson (location, maximum_number_of_places, skill_id, type_id) values ('Room B', '15','3', '12');
insert into lesson (location, maximum_number_of_places, skill_id, type_id) values ('Room A','1','1', '4');
insert into lesson (location, maximum_number_of_places, skill_id, type_id) values ('Room A', '46','1', '8');

--phone
insert into phone (phone_nr) values ('1507110088');
insert into phone (phone_nr) values ('1595276466');
insert into phone (phone_nr) values ('6371507690');
insert into phone (phone_nr) values ('9006434728');
insert into phone (phone_nr) values ('8468307954');
insert into phone (phone_nr) values ('7573495575');
insert into phone (phone_nr) values ('8629847080');
insert into phone (phone_nr) values ('5575557153');
insert into phone (phone_nr) values ('5189171938');
insert into phone (phone_nr) values ('9044448642');

--email
insert into email (email) values ('fburmingham0@dailymail.co.uk');
insert into email (email) values ('gking1@boston.com');
insert into email (email) values ('dshurrocks2@arizona.edu');
insert into email (email) values ('gpeagrim3@amazonaws.com');
insert into email (email) values ('gpierson4@joomla.org');
insert into email (email) values ('bpowrie5@goo.ne.jp');
insert into email (email) values ('kwinslett6@loc.gov');
insert into email (email) values ('sfidgett7@fc2.com');
insert into email (email) values ('smacness8@globo.com');
insert into email (email) values ('hpolendine9@ihg.com');

--person email

insert into person_email (person_id, email_id) values ('1','1');
insert into person_email (person_id, email_id) values ('2','2');
insert into person_email (person_id, email_id) values ('3','3');
insert into person_email (person_id, email_id) values ('5','5');
insert into person_email (person_id, email_id) values ('6','6');
insert into person_email (person_id, email_id) values ('8','8');
insert into person_email (person_id, email_id) values ('9','9');
insert into person_email (person_id, email_id) values ('10','10');
insert into person_email (person_id, email_id) values ('9','4');
insert into person_email (person_id, email_id) values ('10','7');

--person phone
insert into person_phone (person_id, phone_id) values ('1','1');
insert into person_phone (person_id, phone_id) values ('2','2');
insert into person_phone (person_id, phone_id) values ('3','3');
insert into person_phone (person_id, phone_id) values ('5','5');
insert into person_phone (person_id, phone_id) values ('6','6');
insert into person_phone (person_id, phone_id) values ('8','8');
insert into person_phone (person_id, phone_id) values ('9','9');
insert into person_phone (person_id, phone_id) values ('10','10');
insert into person_phone (person_id, phone_id) values ('9','4');
insert into person_phone (person_id, phone_id) values ('10','7');

--student
insert into student (number_of_rented_instruments, present_skill_level, age, parent_phone_number, parent_email, person_id) values ('0', 'beginner', '15', '8013137379', 'pgraves0@tripod.com','1');
insert into student (number_of_rented_instruments, present_skill_level, age, person_id) values ('0', 'intermediate', '25','2');
insert into student (number_of_rented_instruments, present_skill_level, age, parent_phone_number, parent_email, person_id) values ('0', 'intermediate', '15', '2804698140', 'gdennes2@kickstarter.com','3');
insert into student (number_of_rented_instruments, present_skill_level, age, parent_phone_number, parent_email, person_id) values ('0', 'beginner', '11', '4367044772', 'ccanby3@de.vu','4');
insert into student (number_of_rented_instruments, present_skill_level, age, person_id) values ('0', 'advanced', '20','5');
insert into student (number_of_rented_instruments, present_skill_level, age, parent_phone_number, parent_email, person_id) values ('0', 'advanced', '17', '3451757860', 'jtungay5@wikipedia.org','6');
insert into student (number_of_rented_instruments, present_skill_level, age, parent_phone_number, parent_email, person_id) values ('0', 'intermediate', '10', '5264311664', 'zmccawley6@rediff.com','7');

--sibling
insert into sibling (student_id_sibling, student_id) values ('1','2');
insert into sibling (student_id_sibling, student_id) values ('2','5');

--instructor
insert into instructor (person_id) values ('8');
insert into instructor (person_id) values ('9');
insert into instructor (person_id) values ('10');

--instructor availability
insert into instructor_availability (start_time, instructor_id, end_time) values ('2024-05-09 23:00:00', '1', '2024-05-09 14:36:00');
insert into instructor_availability (start_time, instructor_id, end_time) values ('2024-10-09 16:28:00', '1',' 2024-10-09 05:25:00');
insert into instructor_availability (start_time, instructor_id, end_time) values ('2024-08-09 16:21:00', '2', '2024-08-09 00:37:00');
insert into instructor_availability (start_time, instructor_id, end_time) values ('2023-12-18 06:10:00','2','2023-12-18 02:57:00');
insert into instructor_availability (start_time, instructor_id, end_time) values ('2024-02-15 23:30:00','1', '2024-02-15 11:46:00');
insert into instructor_availability (start_time, instructor_id, end_time) values ('2024-08-31 07:08:00', '3','2024-08-31 20:24:00');
insert into instructor_availability (start_time, instructor_id, end_time) values ('2024-11-10 11:40:00', '1', '2024-11-10 10:51:00');
insert into instructor_availability (start_time, instructor_id, end_time) values ('2024-11-12 07:47:00', '3','2024-11-12 17:51:00');
insert into instructor_availability (start_time, instructor_id, end_time) values ('2024-06-12 10:02:00', '2', '2024-06-12 08:40:00');
insert into instructor_availability (start_time, instructor_id, end_time) values ('2024-05-04 03:14:00', '1','2024-05-04 19:26:00');

--instructor instrument
insert into instructor_instrument (instructor_id, instrument_id) values ('1','1');
insert into instructor_instrument (instructor_id, instrument_id) values ('1','2');
insert into instructor_instrument (instructor_id, instrument_id) values ('1','3');
insert into instructor_instrument (instructor_id, instrument_id) values ('1','4');
insert into instructor_instrument (instructor_id, instrument_id) values ('1','5');
insert into instructor_instrument (instructor_id, instrument_id) values ('2','6');
insert into instructor_instrument (instructor_id, instrument_id) values ('2','7');
insert into instructor_instrument (instructor_id, instrument_id) values ('2','8');
insert into instructor_instrument (instructor_id, instrument_id) values ('2','9');
insert into instructor_instrument (instructor_id, instrument_id) values ('2','10');
insert into instructor_instrument (instructor_id, instrument_id) values ('3','5');
insert into instructor_instrument (instructor_id, instrument_id) values ('3','6');
insert into instructor_instrument (instructor_id, instrument_id) values ('3','8');
insert into instructor_instrument (instructor_id, instrument_id) values ('3','1');

--available instrument
insert into available_instrument (brand, quantity, instrument_id) values ('Yamaha', '20', '1');
insert into available_instrument (brand, quantity, instrument_id) values ('Yamaha', '3', '2');
insert into available_instrument (brand, quantity, instrument_id) values ('Epiphone', '50', '3');
insert into available_instrument (brand, quantity, instrument_id) values ('Gibson', '8', '4');
insert into available_instrument (brand, quantity, instrument_id) values ('Ibanez', '15', '5');
insert into available_instrument (brand, quantity, instrument_id) values ('Martin', '1', '6');
insert into available_instrument (brand, quantity, instrument_id) values ('Fender Custom Shop', '100', '7');
insert into available_instrument (brand, quantity, instrument_id) values ('Gretsch', '80', '8');
insert into available_instrument (brand, quantity, instrument_id) values ('Martin', '65', '9');
insert into available_instrument (brand, quantity, instrument_id) values ('Epiphone', '5', '10');
insert into available_instrument (brand, quantity, instrument_id) values ('Yamaha', '20', '10');
insert into available_instrument (brand, quantity, instrument_id) values ('Yamaha', '3', '9');
insert into available_instrument (brand, quantity, instrument_id) values ('Epiphone', '50', '8');
insert into available_instrument (brand, quantity, instrument_id) values ('Gibson', '8', '7');
insert into available_instrument (brand, quantity, instrument_id) values ('Ibanez', '15', '6');
insert into available_instrument (brand, quantity, instrument_id) values ('Martin', '1', '5');
insert into available_instrument (brand, quantity, instrument_id) values ('Fender Custom Shop', '100', '4');
insert into available_instrument (brand, quantity, instrument_id) values ('Gretsch', '80', '3');
insert into available_instrument (brand, quantity, instrument_id) values ('Martin', '65', '2');
insert into available_instrument (brand, quantity, instrument_id) values ('Epiphone', '5', '1');

--renting pricing
insert into renting_pricing (price, available_instrument_id) values ('90', '1');
insert into renting_pricing (price, available_instrument_id) values ('180', '2');
insert into renting_pricing (price, available_instrument_id) values ('130', '3');
insert into renting_pricing (price, available_instrument_id) values ('130', '4');
insert into renting_pricing (price, available_instrument_id) values ('50', '5');
insert into renting_pricing (price, available_instrument_id) values ('100', '6');
insert into renting_pricing (price, available_instrument_id) values ('100', '7');
insert into renting_pricing (price, available_instrument_id) values ('150', '8');
insert into renting_pricing (price, available_instrument_id) values ('130', '9');
insert into renting_pricing (price, available_instrument_id) values ('100', '10');
insert into renting_pricing (price, available_instrument_id) values ('90', '11');
insert into renting_pricing (price, available_instrument_id) values ('180', '12');
insert into renting_pricing (price, available_instrument_id) values ('130', '13');
insert into renting_pricing (price, available_instrument_id) values ('130', '14');
insert into renting_pricing (price, available_instrument_id) values ('50', '15');
insert into renting_pricing (price, available_instrument_id) values ('100', '16');
insert into renting_pricing (price, available_instrument_id) values ('100', '17');
insert into renting_pricing (price, available_instrument_id) values ('150', '18');
insert into renting_pricing (price, available_instrument_id) values ('130', '19');
insert into renting_pricing (price, available_instrument_id) values ('100', '20');

--rental
insert into rental (available_instrument_id, student_id, maximum_renting_period, start_date, end_date, status) values ('8','1','365', '2024-10-30', '2025-07-30', 'Active');
insert into rental (available_instrument_id, student_id, maximum_renting_period, start_date, end_date, status) values ('9', '1', '365', '2024-10-25', '2025-07-25', 'Active');
insert into rental (available_instrument_id, student_id, maximum_renting_period, start_date, end_date, status) values ('19', '2', '365', '2024-01-25', '2025-01-25', 'Active');
insert into rental (available_instrument_id, student_id, maximum_renting_period, start_date, end_date, status) values ('14', '2', '365', '2024-09-05', '2024-12-05', 'Active');
insert into rental (available_instrument_id, student_id, maximum_renting_period, start_date, end_date, status) values ('8', '4', '365', '2024-05-24', '2025-05-24', 'Active');
insert into rental (available_instrument_id, student_id, maximum_renting_period, start_date, end_date, status) values ('7', '4', '365', '2024-03-14', '2025-03-14', 'Active');
insert into rental (available_instrument_id, student_id, maximum_renting_period, start_date, end_date, status) values ('2', '6', '365', '2024-05-23', '2025-01-23', 'Active');
insert into rental (available_instrument_id, student_id, maximum_renting_period, start_date, end_date, status) values ('11', '6', '365', '2024-04-10', '2025-04-10', 'Active');
insert into rental (available_instrument_id, student_id, maximum_renting_period, start_date, end_date, status) values ('18', '7', '365', '2024-03-18', '2024-11-18', 'Active');
insert into rental (available_instrument_id, student_id, maximum_renting_period, start_date, end_date, status) values ('2', '5', '365', '2023-02-26', '2024-02-26', 'Ended');

--ensemble lessons
insert into ensemble_lesson (lesson_id, genre, minimum_number_of_places) values ('7', 'Country', '4');
insert into ensemble_lesson (lesson_id, genre, minimum_number_of_places) values ('8', 'Reggae', '5');
insert into ensemble_lesson (lesson_id, genre, minimum_number_of_places) values ('9', 'Hip Hop', '4');
insert into ensemble_lesson (lesson_id, genre, minimum_number_of_places) values ('12', 'Pop', '3');
insert into ensemble_lesson (lesson_id, genre, minimum_number_of_places) values ('15', 'Classical', '5');
insert into ensemble_lesson (lesson_id, genre, minimum_number_of_places) values ('18', 'Classical', '1');

--ensemble instrument
insert into ensemble_lesson_instrument (lesson_id, instrument_id) values ('7','1');
insert into ensemble_lesson_instrument (lesson_id, instrument_id) values ('8','2');
insert into ensemble_lesson_instrument (lesson_id, instrument_id) values ('9','3');
insert into ensemble_lesson_instrument (lesson_id, instrument_id) values ('12','4');
insert into ensemble_lesson_instrument (lesson_id, instrument_id) values ('15','5');
insert into ensemble_lesson_instrument (lesson_id, instrument_id) values ('18','6');


--individual lesson

insert into individual_lesson (student_id, instructor_id, instrument_id, lesson_id ,start_time, end_time, location, status) values ('1', '3', '8', '1', '2025-01-18 14:00', '2025-01-18 15:30', 'Room 303', 'active');
insert into individual_lesson (student_id, instructor_id, instrument_id, lesson_id ,start_time, end_time, location, status) values ('2', '3', '9', '2', '2025-07-09 10:00', '2025-07-09 14:20', 'Room A', 'ended');
insert into individual_lesson (student_id, instructor_id, instrument_id, lesson_id ,start_time, end_time, location, status) values ('6', '3', '9', '3', '2024-12-06 12:30', '2024-12-06 14:30', 'Room A', 'active');
insert into individual_lesson (student_id, instructor_id, instrument_id, lesson_id ,start_time, end_time, location, status) values ('1', '2', '18', '10',' 2025-03-26 11:00', '2025-03-26 15:30', 'Room C', 'ended');
insert into individual_lesson (student_id, instructor_id, instrument_id, lesson_id ,start_time, end_time, location, status) values ('4', '1', '18', '13',' 2025-01-29 13:30', '2025-01-29 15:30', 'Room 303', 'ended');
insert into individual_lesson (student_id, instructor_id, instrument_id, lesson_id ,start_time, end_time, location, status) values ('4', '1', '7', '16', '2025-01-12 12:30', '2025-01-12 15:30', 'Room A', 'active');
insert into individual_lesson (student_id, instructor_id, instrument_id, lesson_id ,start_time, end_time, location, status) values ('1', '1', '8', '19', '2025-01-01 10:00', '2025-01-01 14:20', 'Room A', 'ended');


--group lesson
insert into group_lesson (lesson_id, minimum_number_of_places, instrument_id) values ('4','3', '10');
insert into group_lesson (lesson_id, minimum_number_of_places, instrument_id) values ('5','3', '2');
insert into group_lesson (lesson_id, minimum_number_of_places, instrument_id) values ('6','2', '7');
insert into group_lesson (lesson_id, minimum_number_of_places, instrument_id) values ('11','5', '5');
insert into group_lesson (lesson_id, minimum_number_of_places, instrument_id) values ('14','3', '3');
insert into group_lesson (lesson_id, minimum_number_of_places, instrument_id) values ('17','4', '4');
insert into group_lesson (lesson_id, minimum_number_of_places, instrument_id) values ('20','2', '7');


--schedule
insert into schedule (instructor_id, lesson_id, start_time, end_time, location) values ('1','4','2024-09-10 10:40', '2024-09-10 19:28','Room C');
insert into schedule (instructor_id, lesson_id, start_time, end_time, location) values ('1','5','2023-11-26 16:57', '2023-11-26 18:15','Room 303');
insert into schedule (instructor_id, lesson_id, start_time, end_time, location) values ('1','6','2024-04-20 12:55', '2024-04-20 18:07','Room A');
insert into schedule (instructor_id, lesson_id, start_time, end_time, location) values ('2','7','2024-03-30 10:31', '2024-03-30 21:23','Room 202');
insert into schedule (instructor_id, lesson_id, start_time, end_time, location) values ('2','8','2024-09-28 13:18', '2024-09-28 14:33','Room 101');
insert into schedule (instructor_id, lesson_id, start_time, end_time, location) values ('2','9','2024-08-27 12:08', '2024-08-27 13:40','Room 101');
insert into schedule (instructor_id, lesson_id, start_time, end_time, location) values ('3','11','2024-05-04 19:02', '2024-05-04 21:05','Room A');
insert into schedule (instructor_id, lesson_id, start_time, end_time, location) values ('3','12','2024-08-08 11:18', '2024-08-08 20:39','Room 101');
insert into schedule (instructor_id, lesson_id, start_time, end_time, location) values ('3','14','2024-01-17 07:00', '2024-01-17 8:07','Room 101');
insert into schedule (instructor_id, lesson_id, start_time, end_time, location) values ('1','15','2023-12-28 11:29', '2023-12-28 14:52','Room 101');
insert into schedule (instructor_id, lesson_id, start_time, end_time, location) values ('2','17','2024-08-08 11:18', '2024-08-08 20:39','Room 101');
insert into schedule (instructor_id, lesson_id, start_time, end_time, location) values ('3','18','2024-01-17 08:56', '2024-01-17 20:07','Room 101');
insert into schedule (instructor_id, lesson_id, start_time, end_time, location) values ('1','20','2023-12-28 11:29', '2023-12-28 14:52','Room 101');

--schedule booking
insert into schedule_booking (student_id, instructor_id, lesson_id, start_time, status) values ('1','1','4','2024-09-10 19:28','active');
insert into schedule_booking (student_id, instructor_id, lesson_id, start_time, status) values ('2','2','7','2024-03-30 10:31','active');
insert into schedule_booking (student_id, instructor_id, lesson_id, start_time, status) values ('3','3','11','2024-05-04 19:02','active');
insert into schedule_booking (student_id, instructor_id, lesson_id, start_time, status) values ('4','1','4','2024-09-10 19:28','active');
insert into schedule_booking (student_id, instructor_id, lesson_id, start_time, status) values ('5','2','8','2024-09-28 20:18','active');
insert into schedule_booking (student_id, instructor_id, lesson_id, start_time, status) values ('6','3','11','2024-05-04 19:02','active');
insert into schedule_booking (student_id, instructor_id, lesson_id, start_time, status) values ('7','1','15','2023-12-28 11:29','active');
insert into schedule_booking (student_id, instructor_id, lesson_id, start_time, status) values ('3','2','20','2023-12-28 11:29','ended');
insert into schedule_booking (student_id, instructor_id, lesson_id, start_time, status) values ('7','3','18','2024-01-17 20:56','active');
insert into schedule_booking (student_id, instructor_id, lesson_id, start_time, status) values ('5','3','12','2024-08-08 11:18','ended');

--attended lessons
insert into attended_lessons (student_id, instructor_id, lesson_id, date) values ('2', '3', '2', '2025-07-09');
insert into attended_lessons (student_id, instructor_id, lesson_id, date) values ('1', '2', '10', '2025-03-26');
insert into attended_lessons (student_id, instructor_id, lesson_id, date) values ('4', '1', '13', '2025-01-29');
insert into attended_lessons (student_id, instructor_id, lesson_id, date) values ('1', '1', '19', '2025-01-01');
insert into attended_lessons (student_id, instructor_id, lesson_id, date) values ('3', '2', '20', '2023-12-28');
insert into attended_lessons (student_id, instructor_id, lesson_id, date) values ('5', '3', '12', '2024-08-08');