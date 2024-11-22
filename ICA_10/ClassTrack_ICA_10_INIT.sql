USE hlawson5_ClassTrak
GO

BEGIN TRANSACTION

DECLARE @InstructorId int;

insert into Instructors (last_name, first_name) values ( 'Hunterson' , 'Adrian' )

SET @InstructorId = @@IDENTITY;

insert into Courses (course_abbrev, course_desc) values ( 'CMPE1010' , 'Aero-Computing' )

DECLARE @CourseId int = @@IDENTITY;

insert into Classes (class_desc, instructor_id, course_id, start_date) values ('Computing in Airplanes', @InstructorId, @CourseId, '2024-Sep-01')

DECLARE @ClassId int = @@IDENTITY;

insert into Class_To_Student (class_id, student_id, active) select @ClassId, s.student_id, 1 from students s where s.last_name like '[aeiou]%'

/*
-- 1.

SELECT
    *

FROM
    Instructors

WHERE
    last_name = 'Hunterson'



-- 2.

SELECT
    *

FROM
    Courses 

WHERE
    course_abbrev LIKE 'CMPE10%'



--3.

SELECT
    c.class_id,
    c.class_desc,
    c.instructor_id,
    c.course_id,
    c.start_date,
    c.days

FROM
    Classes c INNER JOIN
    Instructors i ON i.instructor_id = c.instructor_id

WHERE
    i.last_name = 'Hunterson'



-- 4.

SELECT
    s.student_id,
    s.last_name,
    s.first_name,
    s.school_id,
	c.class_desc

FROM
    Students s INNER JOIN
    class_to_student cts ON cts.student_id = s.student_id INNER JOIN
    Classes c ON c.class_id = cts.class_id INNER JOIN
    Instructors i ON i.instructor_id = c.instructor_id

WHERE
    i.last_name = 'Hunterson'

ORDER BY
    s.last_name,
    s.first_name
*/

DELETE
FROM
	class_to_student
WHERE
	class_id IN (SELECT class_id FROM Classes c WHERE class_desc = 'Computing in Airplanes')

SELECT
	*

FROM
	Classes c FULL JOIN
	class_to_student cts ON cts.class_id = c.class_id

WHERE
	c.class_desc = 'Computing in Airplanes'

DECLARE @_ClassID int;
DECLARE @_CourseID int;
DECLARE @_InstructorID int;

SELECT
	@_ClassId = c.class_id,
	@_CourseId = c.course_id,
	@_InstructorID = c.instructor_id


FROM
	Classes c

WHERE
	c.class_desc = 'Computing in Airplanes'

SELECT
	@_ClassID 'ClassID',
	@_CourseID 'CourseID',
	@_InstructorID 'InstructorID'

DELETE
FROM
	Classes

WHERE
	class_id = @_ClassId

SELECT
	*

FROM
	Classes

WHERE
	class_desc = 'Computing in Airplanes'

DELETE
FROM
	Courses

WHERE
	course_id = @_CourseId

SELECT
	*

FROM
	Courses

WHERE
	course_abbrev = 'CMPE1010'

DELETE
FROM
	Instructors

WHERE
	instructor_id = @InstructorId

SELECT
	*

FROM
	Instructors

WHERE
	last_name = 'Hunterson'
	
/*
SELECT
    s.student_id,
    s.last_name,
    s.first_name,
    s.school_id,
	c.class_desc

FROM
    Students s INNER JOIN
    class_to_student cts ON cts.student_id = s.student_id INNER JOIN
    Classes c ON c.class_id = cts.class_id INNER JOIN
    Instructors i ON i.instructor_id = c.instructor_id
*/

ROLLBACK

begin transaction
update students set last_name = last_name + 'x'

--SELECT * FROM Students

rollback


