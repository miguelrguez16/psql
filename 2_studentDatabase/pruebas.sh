#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=students --no-align --tuples-only -c"

echo -e "\nList of majors, in alphabetical order, that either no student is taking or has a student whose first name contains a case insensitive 'ma':"
echo "$($PSQL "SELECT majors.major_id, majors.major, students.first_name FROM majors RIGHT JOIN students on students.major_id=majors.major_id GROUP BY majors.major_id, students.first_name HAVING count(majors.major_id)=0 OR students.first_name ILIKE '%ma%'")"


echo "SELECT major FROM students RIGHT JOIN majors ON majors.major_id=students.major_id WHERE student_id is null;"