-- Display all the details of students available in the dataset.
SELECT *
FROM CS_STUDENTS;

-- Show the name, major and GPA of all students.
SELECT NAME , MAJOR , GPA
FROM CS_STUDENTS;

-- Display the students whose age is more than 22.
SELECT *
FROM CS_STUDENTS
WHERE AGE >22;

-- Count the total number of students in the dataset.
SELECT COUNT(*) AS TOTAL_STUDENTS
FROM CS_STUDENTS;

-- Find the average GPA of all students.
SELECT AVG(GPA) AS AVG_GPA
FROM CS_STUDENTS;

-- Display the highest GPA achieved by any student.
SELECT MAX(GPA) AS HIGH_GPA
FROM CS_STUDENTS;

-- Find the number of students in each major.
SELECT MAJOR , COUNT(*) AS NO_OF_STUDENT
FROM CS_STUDENTS
GROUP BY MAJOR;

-- Find the average GPA of students based on gender.
SELECT GENDER , AVG(GPA) AS AVG_GPA
FROM CS_STUDENTS
GROUP BY GENDER;

-- Display the top 5 students with the highest GPA.
SELECT NAME , GPA
FROM CS_STUDENTS
ORDER BY GPA DESC
LIMIT 5;

-- Show the students ordered by the number of projects completed 
SELECT NAME , PROJECTS
FROM CS_STUDENTS
ORDER BY PROJECTS DESC;

-- Assign a row number to each student based on their GPA.
SELECT NAME , GPA,
ROW_NUMBER() OVER(ORDER BY GPA DESC) AS ROW_NUM
FROM CS_STUDENTS;

-- Rank the students according to their GPA.
SELECT NAME , GPA ,
RANK() OVER(ORDER BY GPA DESC) AS RNK
FROM CS_STUDENTS;

-- Assign a dense rank to students based on their GPA.
SELECT NAME , GPA,
DENSE_RANK() OVER(ORDER BY GPA DESC) AS D_R
FROM CS_STUDENTS;

-- Rank students within each major based on GPA.
SELECT NAME , MAJOR , GPA ,
RANK() OVER(PARTITION BY MAJOR ORDER BY GPA DESC) AS RNK
FROM CS_STUDENTS;

-- Find the students who have maximum number of projects.
SELECT NAME , MAJOR , PROJECTS
FROM CS_STUDENTS
WHERE PROJECTS = (SELECT MAX(PROJECTS) FROM CS_STUDENTS);

-- Find the top-performing student in each major.
SELECT NAME , MAJOR , GPA
FROM (
	SELECT NAME , MAJOR , GPA ,
           ROW_NUMBER() OVER(PARTITION BY MAJOR ORDER BY GPA DESC) AS RNK
     FROM CS_STUDENTS
	) AS T
    WHERE RNK =1;
    
-- Find the students whose GPA is equal to the lowest GPA
SELECT NAME , MAJOR , GPA
FROM CS_STUDENTS
WHERE GPA = (SELECT MIN(GPA) FROM CS_STUDENTS);

-- Display the previous student's GPA .
SELECT NAME , MAJOR , GPA,
LAG(GPA) OVER(ORDER BY GPA DESC) AS S_GPA
FROM CS_STUDENTS;

-- Display the students whose GPA is greater than the average GPA of their major.
SELECT NAME, MAJOR, GPA
FROM CS_STUDENTS S1
WHERE GPA > (
    SELECT AVG(GPA)
    FROM CS_STUDENTS S2
    WHERE S1.MAJOR = S2.MAJOR
);

-- Display the next student's GPA 
SELECT NAME , MAJOR , GPA,
LEAD(GPA) OVER(ORDER BY GPA DESC) AS S_GPA
FROM CS_STUDENTS;

-- Find students whose GPA is higher than the GPA of student named 'Rahul'.
SELECT NAME , MAJOR , GPA
FROM CS_STUDENTS
WHERE GPA > (SELECT GPA FROM CS_STUDENTS WHERE NAME = 'RAHUL');

-- Find the students whose GPA is higher than the average GPA of all students.
SELECT NAME , MAJOR , GPA
FROM CS_STUDENTS
WHERE GPA > (SELECT AVG(GPA) FROM CS_STUDENTS);