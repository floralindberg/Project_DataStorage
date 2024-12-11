
CREATE TABLE historical_lessons (
    attended_lessons_id INTEGER PRIMARY KEY,
    lesson_type VARCHAR(100),
    genre VARCHAR(50),
    instrument VARCHAR(100),
    lesson_price VARCHAR(6),
    student_name VARCHAR(100),
    student_email VARCHAR(100),
    lesson_date DATE
);