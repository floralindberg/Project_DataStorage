--Number of lessons
SELECT
    TO_CHAR(al.date, 'Month') AS Month,
    COUNT(*) AS Total,
    SUM(CASE WHEN lt.type_name = 'individual' THEN 1 ELSE 0 END) AS Individual,
    SUM(CASE WHEN lt.type_name = 'group' THEN 1 ELSE 0 END) AS Group,
    SUM(CASE WHEN lt.type_name = 'ensemble' THEN 1 ELSE 0 END) AS Ensemble
FROM attended_lessons al
JOIN lesson l ON al.lesson_id = l.lesson_id
JOIN lesson_type lt ON l.type_id = lt.type_id
WHERE EXTRACT(YEAR FROM al.date) = 2024
GROUP BY EXTRACT(MONTH FROM al.date), TO_CHAR(al.date, 'Month')
ORDER BY EXTRACT(MONTH FROM al.date);

--Siblings
CREATE MATERIALIZED VIEW siblings_view AS
SELECT
    number_of_siblings,
    COUNT(*) AS number_of_students
FROM (
    SELECT
        s.student_id,
        COUNT(sib.student_id) AS number_of_siblings
    FROM student s
    LEFT JOIN sibling sib
        ON s.student_id = sib.student_id
        OR s.student_id = sib.student_id_sibling
    GROUP BY s.student_id
) AS sibling_counts
GROUP BY number_of_siblings
ORDER BY number_of_siblings;

CREATE OR REPLACE FUNCTION refresh_siblings_view()
RETURNS TRIGGER AS
$$
BEGIN
    REFRESH MATERIALIZED VIEW siblings_view;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_refresh_siblings_view
AFTER INSERT OR UPDATE OR DELETE ON sibling
FOR EACH ROW
EXECUTE FUNCTION refresh_siblings_view();


--Instructors
SELECT
al.instructor_id AS Instructor_Id,
p.first_name AS First_name,
p.last_name AS Last_name,
COUNT(DISTINCT al.lesson_id) AS No_of_lessons
FROM attended_lessons al
JOIN instructor i ON al.instructor_id = i.instructor_id
JOIN person p ON i.person_id = p.person_id
WHERE EXTRACT(MONTH FROM al.date) = EXTRACT(MONTH FROM CURRENT_DATE)
    AND EXTRACT(YEAR FROM al.date) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY al.instructor_id, p.first_name, p.last_name
HAVING COUNT(DISTINCT al.lesson_id) > 2
ORDER BY No_of_Lessons DESC;

--Ensemble
CREATE VIEW ensemble_availability_view AS
SELECT
TO_CHAR(s.start_time, 'Day') AS Day,
l.genre AS genre,
CASE
WHEN CAST(s.available_places AS INTEGER) = 0 THEN 'No seats'
WHEN CAST(s.available_places AS INTEGER) < 3 THEN '1 or 2 seats'
WHEN CAST(s.available_places AS INTEGER) > 2 THEN 'Many seats'
END AS Number_of_free_seats
FROM schedule s
JOIN ensemble_lesson l ON s.lesson_id = l.lesson_id
JOIN lesson le ON l.lesson_id = le.lesson_id
JOIN lesson_type lt ON le.type_id = lt.type_id
WHERE
    EXTRACT(WEEK FROM s.start_time) =
    CASE
        WHEN EXTRACT(WEEK FROM CURRENT_DATE) = 52 THEN 1
        ELSE EXTRACT(WEEK FROM CURRENT_DATE) + 1
    END
    AND EXTRACT(YEAR FROM s.start_time) =
    CASE
        WHEN EXTRACT(WEEK FROM CURRENT_DATE) = 52 THEN EXTRACT(YEAR FROM CURRENT_DATE) + 1
        ELSE EXTRACT(YEAR FROM CURRENT_DATE)
    END

--Historical
SELECT 
    al.attended_lessons_id AS attended_lessons_id,  
    lt.type_name AS lesson_type,  
	el.genre AS genre,  
	COALESCE(ig.instrument_name, ii.instrument_name) AS instrument, 
    al.price AS lesson_price, 
    CONCAT(p.first_name, ' ', p.last_name) AS student_name,
    e.email AS student_email,
    al.date AS lesson_date
FROM attended_lessons al  
LEFT JOIN lesson l ON al.lesson_id = l.lesson_id  
LEFT JOIN lesson_type lt ON l.type_id = lt.type_id  
LEFT JOIN ensemble_lesson el ON al.lesson_id = el.lesson_id  
LEFT JOIN group_lesson gl ON al.lesson_id = gl.lesson_id  
LEFT JOIN instrument ig ON gl.instrument_id = ig.instrument_id  
LEFT JOIN individual_lesson il ON al.lesson_id = il.lesson_id  
LEFT JOIN instrument ii ON il.instrument_id = ii.instrument_id  
LEFT JOIN person p ON al.student_id = p.person_id  
LEFT JOIN person_email pe ON p.person_id = pe.person_id AND pe.is_primary = TRUE
LEFT JOIN email e ON pe.email_id = e.email_id

-- from csv to historical
\COPY historical_lessons (attended_lessons_id, lesson_type,genre,instrument,lesson_price,student_name,student_email,lesson_date) FROM '/path/to/the/file.csv' WITH CSV HEADER NULL AS 'NULL' ; 