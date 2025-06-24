Create database Course_systemDB

Use Course_systemDB

--- Table creation ---
Create table Instructors ( 
    InstructorID int Primary key, 
    FullName varchar(100), 
    Email varchar(100), 
    JoinDate date 
)

Create table Categories ( 
    CategoryID int Primary key, 
    CategoryName varchar(50) 
)

Create table Courses ( 
    CourseID int Primary key, 
    Title varchar(100), 
    InstructorID int, 
    CategoryID int, 
    Price decimal(6,2), 
    PublishDate date, 
    foreign key (InstructorID) references Instructors(InstructorID), 
    foreign key (CategoryID) references Categories(CategoryID) 
)

Create table Students ( 
    StudentID int Primary key, 
    FullName varchar(100), 
    Email varchar(100), 
    JoinDate date 
)

Create table Enrollments ( 
    EnrollmentID int Primary key, 
    StudentID int, 
    CourseID int, 
    EnrollDate date, 
    CompletionPercent int, 
    Rating int check (Rating BETWEEN 1 AND 5), 
    foreign key (StudentID) references Students(StudentID), 
    foreign key (CourseID) references Courses(CourseID) 
)


---Data insert ---

-- Instructors 
Insert into Instructors values 
(1, 'Sarah Ahmed', 'sarah@learnhub.com', '2023-01-10'), 
(2, 'Mohammed Al-Busaidi', 'mo@learnhub.com', '2023-05-21')

-- Categories 
Insert into Categories values 
(1, 'Web Development'), 
(2, 'Data Science'), 
(3, 'Business')

-- Courses 
Insert into Courses values 
(101, 'HTML & CSS Basics', 1, 1, 29.99, '2023-02-01'), 
(102, 'Python for Data Analysis', 2, 2, 49.99, '2023-03-15'), 
(103, 'Excel for Business', 2, 3, 19.99, '2023-04-10'), 
(104, 'JavaScript Advanced', 1, 1, 39.99, '2023-05-01')

-- Students 
Insert into Students values 
(201, 'Ali Salim', 'ali@student.com', '2023-04-01'), 
(202, 'Layla Nasser', 'layla@student.com', '2023-04-05'), 
(203, 'Ahmed Said', 'ahmed@student.com', '2023-04-10')


-- Enrollments 
Insert into Enrollments values 
(1, 201, 101, '2023-04-10', 100, 5), 
(2, 202, 102, '2023-04-15', 80, 4), 
(3, 203, 101, '2023-04-20', 90, 4), 
(4, 201, 102, '2023-04-22', 50, 3), 
(5, 202, 103, '2023-04-25', 70, 4), 
(6, 203, 104, '2023-04-28', 30, 2), 
(7, 201, 104, '2023-05-01', 60, 3)


-- Step 4: Practice Tasks – Write SQL Queries 
---------------------------------------------

-- 1. Count total number of students. --
Select count(*)
from Students
-- Output 3

-----------------------------------------

-- 2. Count total number of enrollments.
Select count(*)
from Enrollments
-- Output 7

------------------------------------------

--3. Find average rating of each course. 
Select avg(Rating) as Avg_rating, CourseID
From Enrollments
Group by CourseID
--Avg_rating : is the name of the output column
--Output:
Avg_rating  CourseID
4	        101
3	        102
4	        103
2	        104

--------------------------------------------

--4. Total number of courses per instructor. 
Select count(*) as Total_Courses, InstructorID
From Courses
Group by InstructorID
--Output:
Total_Courses  InstructorID
2	           1
2	           2

---------------------------------------------------

--5. Number of courses in each category. 
Select count(*) as Courses_num, CategoryID
From Courses
Group by CategoryID
--Output:
Courses_num  CategoryID
2	         1
1	         2
1	         3

--------------------------------------------------------

--6. Number of students enrolled in each course. 
Select count(*) as Student_num , CourseID
from Enrollments
Group by CourseID
-- Output:
Student_num  CourseID
2	         101
2	         102
1	         103
2	         104

---------------------------------------------------------

--7. Average course price per category. 
Select avg(Price) as Courseprice, CategoryID
From Courses
Group by CategoryID
-- Output:
Courseprice  CategoryID
34.990000	 1
49.990000	 2
19.990000	 3

-----------------------------------------------------------

--8. Maximum course price. 
Select max(Price)
From Courses
--Output: 49.99

--------------------------------------------------------

--9. Min, Max, and Avg rating per course. 


Select min(Rating) as Min_rating, 
       max(Rating) as Max_rating, 
       Avg(Rating) as Avg_rating, CourseID
From Enrollments
Group by CourseID
--Output:
Min_rating   Max_rating   Avg_rating   CourseID
4	         5	          4	           101
3	         4	          3	           102
4	         4	          4            103
2	         3	          2	           104

------------------------------------------------------

--10. Count how many students gave rating = 5. 

Select count(StudentID)as Num_student, Rating 
From Enrollments
Where Rating=5
Group by Rating
--Output:
Num_student   Rating
1             5

--------------------------------------------------------

--1. Average completion percent per course. 
Select avg(CompletionPercent) as Comp_Percent, CourseID
From Enrollments
Group by CourseID
-- Output:
Comp_Percent   CourseID
95	           101
65	           102
70	           103
45	           104

---------------------------------------------------------

--2. Find students enrolled in more than 1 course.
Select count(*) as std_num, StudentID
From Enrollments
Group by StudentID
Having count(*) > 1
-- Output:
std_num   StudentID
3	      201
2	      202
2	      203

--------------------------------------------------------------

--3. Calculate revenue per course (price * enrollments). 
Select count(*) as Total,
     (Select price
	  From Courses
	  Where Courses.CourseID = Enrollments.CourseID ) as T_Price, CourseID,

       count(*) *
	 (Select Price
	  From Courses
	  Where Courses.CourseID = Enrollments.CourseID ) as Revenue

From Enrollments
Group by CourseID
-- Output:
Total    T_Price    CourseID    Revenue
2        29.99      101         59.98
2        49.99      102         99.98
1        19.99      103         19.99
2        39.99      104         79.98

---------------------------------------------------------

