#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=students --no-align --tuples-only -c"


echo -e "\nList of unique courses, in reverse alphabetical order, that no student or 'Obie Hilpert' is taking:"
echo "$($PSQL "SELECT * FROM students FULL JOIN majors USING(major_id) FULL JOIN majors_courses USING(major_id) FULL JOIN courses USING(course_id) GROUP BY majors_courses.course_id, courses.course_id HAVING count(students.student_id)=0 OR students.first_name like 'Obie' ORDER BY course DESC")"


 # distinct(course), students.first_name
