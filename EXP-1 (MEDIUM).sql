-- Step 1: Create Department table
CREATE TABLE Department (
  dept_id INT PRIMARY KEY,
  dept_name VARCHAR(100)
);
-- Step 2: Create Course table with foreign key to Department
CREATE TABLE Course (
  course_id INT PRIMARY KEY,
  course_name VARCHAR(100),
  dept_id INT,
  FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

-- Step 3: Insert data into Department
INSERT INTO Department (dept_id, dept_name) VALUES
(1, 'Computer Science'),
(2, 'Mechanical Engineering'),
(3, 'Electrical Engineering'),
(4, 'Mathematics'),
(5, 'Physics');

-- Step 4: Insert data into Course
INSERT INTO Course (course_id, course_name, dept_id) VALUES
(101, 'Data Structures', 1),
(102, 'Algorithms', 1),
(103, 'Operating Systems', 1),
(104, 'Thermodynamics', 2),
(105, 'Fluid Mechanics', 2);

-- Step 5: Query departments with more than 2 courses
SELECT dept_name
FROM Department
WHERE dept_id IN (
  SELECT dept_id
  FROM Course
  GROUP BY dept_id
  HAVING COUNT(course_id) > 2
);

-- Step 6: Create login for readonly_user (server-level)
CREATE LOGIN readonly_user WITH PASSWORD = 'StrongPassword123!';

-- Step 7: Create user in the current database
CREATE USER readonly_user FOR LOGIN readonly_user;

-- Step 8: Grant SELECT permission on Course table
GRANT SELECT ON Course TO readonly_user;
