USE DB;
GO 

GO

INSERT INTO ABC.Companies (CRNNO, CompanyName) VALUES (101, N'Company A');

INSERT INTO ABC.Companies (CompanyName, CRNNO) VALUES (N'Company B', 102);

INSERT INTO ABC.Companies  VALUES (103, N'Company C');

INSERT INTO ABC.Companies  VALUES 
           (104, N'Company D'),
           (105, N'Company E'),
           (106, N'Company F'),
           (107, N'Company G');
GO


INSERT INTO ABC.Managers (Id ,Email) VALUES (201, 'peter@fake.com');
INSERT INTO ABC.Managers (Id ,Email) VALUES (202, 'mike@fake.com');
INSERT INTO ABC.Managers (Id ,Email) VALUES (203, 'reem@fake.com');
INSERT INTO ABC.Managers (Id ,Email) VALUES (204, 'salah@fake.com'); 

GO
INSERT INTO ABC.Technology(Id , Name) VALUES (301, 'SQL SERVER');
INSERT INTO ABC.Technology(Id , Name) VALUES (302, 'ASP NET CORE');
INSERT INTO ABC.Technology(Id , Name) VALUES (303, 'ANGULAR');
INSERT INTO ABC.Technology(Id , Name) VALUES (304, 'REACT');
INSERT INTO ABC.Technology(Id , Name) VALUES (305, 'WPF');
INSERT INTO ABC.Technology(Id , Name) VALUES (306, 'ANDROID');
INSERT INTO ABC.Technology(Id , Name) VALUES (307, 'ORACLE');
INSERT INTO ABC.Technology(Id , Name) VALUES (308, 'PHP'); 

GO

INSERT INTO ABC.Projects ( PRJNO, Title, ManagerId, StartDate, InitialCost, Parked, CRNNO)
     VALUES ( 401, 'CMS', 201, '2022-01-01', 15000000, 0, 101),
            ( 402, 'ERP', 202, '2022-02-01', 20000000, 0, 102),
            ( 403, 'CMS', 203, '2022-03-01', 15000000, 0, 105),
            ( 404, 'Authenticator', 204, '2022-04-01', 150000, 0, 101),
            ( 405, 'CRM-DESKTOP', 203, '2022-05-01', 20000000, 0, 104),
            ( 406, 'ERP', 204, '2022-06-01', 20000000, 0, 105),
            ( 407, 'HUB', 204, '2022-06-01', 20000000, 1, 104);

GO

INSERT INTO ABC.ProjectTechnology(PRJNO, TechnologyId) VALUES 
        ( 401, 301), 
        ( 401, 302),
		( 401, 303),
		( 402, 301), 
        ( 402, 302),
		( 402, 304),
		( 403, 301), 
        ( 403, 302),
		( 403, 308),
		( 404, 306),
		( 405, 307),
		( 405, 305),
		( 406, 307),
		( 406, 308);
GO

-- SELECT

SELECT PRJNO, Title, ManagerId, StartDate, InitialCost, Parked, CRNNO
FROM ABC.Projects;

SELECT *
FROM ABC.Projects;

SELECT PRJNO, Title
FROM ABC.Projects;

-- WHERE 
SELECT * FROM ABC.Projects WHERE InitialCost >= 1000000;
SELECT * FROM ABC.Projects WHERE NOT InitialCost >= 1000000;
SELECT * FROM ABC.Projects WHERE InitialCost >= 1000000 AND StartDate >= '2022-03-01';
SELECT * FROM ABC.Projects WHERE InitialCost >= 1000000 OR StartDate >= '2022-03-01';

-- LIKE (%, _)
 -- LIKE xx% starts with
 SELECT * FROM ABC.Projects WHERE Title like 'C%'
  -- LIKE %xx ends with
 SELECT * FROM ABC.Projects WHERE Title like '%P'
   -- LIKE %xx% contains 
 SELECT * FROM ABC.Projects WHERE Title like '%DESK%'
   -- LIKE _R%
    SELECT * FROM ABC.Projects WHERE Title like '_R_';
    SELECT * FROM ABC.Projects WHERE InitialCost like '_5%';

-- TOP
   SELECT TOP 3 * From ABC.Projects
   SELECT TOP 2 PERCENT *  From ABC.Projects

-- ORDER BY
SELECT * FROM ABC.Projects ORDER BY StartDate;
SELECT * FROM ABC.Projects ORDER BY StartDate DESC;
SELECT * FROM ABC.Projects ORDER BY InitialCost, StartDate DESC;

-- GROUP BY

SELECT Title, COUNT(*)  FROM ABC.Projects GROUP BY Title;
SELECT ManagerId , COUNT(*) FROM ABC.Projects
WHERE Parked = 0 
GROUP BY ManagerId
HAVING COUNT(*)>=2

-- DISTINT 
 SELECT DISTINCT Title  FROM ABC.Projects
  SELECT DISTINCT InitialCost  FROM ABC.Projects

-- Tables JOIN

SELECT * FROM ABC.Projects;
SELECT * FROM ABC.Managers;

-- PRJNO,  TITLE, Manager_Email
SELECT * FROM ABC.Projects, ABC.Managers;
SELECT PRJNO, Title, Email FROM ABC.Projects, ABC.Managers; -- Cartisian Product
SELECT PRJNO, Title, Email, ABC.Managers.Id, ABC.Projects.ManagerId FROM ABC.Projects, ABC.Managers 
WHERE ABC.Projects.ManagerId = ABC.Managers.Id;
 
 
-- INNET JOIN Match in two tables

SELECT P.PRJNO , P.Title , M.Email 
FROM ABC.Projects AS P INNER JOIN ABC.Managers AS M
ON P.ManagerId = M.Id

-- or

SELECT 
  (P.PRJNO) AS N'رقم المشروع'
, (P.Title) AS N'عنوان المشروع'
, (M.Email) AS N'البريد الالكتروني لمدير المشروع' FROM 
ABC.Projects AS P INNER JOIN ABC.Managers AS M 
ON P.ManagerId = M.Id;


-- LEFT JOIN ( ALL ROWS FROM LEFT TABLE EVEN NO MATCH

SELECT * FROM ABC.COMPANIES;
SELECT * FROM ABC.Projects;

SELECT 
  (P.PRJNO)
, (P.Title)
, (C.CompanyName) FROM 
ABC.Projects AS P LEFT JOIN ABC.Companies AS C 
ON P.CRNNO = C.CRNNO;

SELECT 
  (P.PRJNO)
, (P.Title)
, (C.CRNNO)
, (C.CompanyName) FROM 
 ABC.Companies AS C LEFT JOIN  ABC.Projects AS P
ON P.CRNNO = C.CRNNO;

-- LEFT JOIN ( ALL ROWS FROM RIGHT TABLE EVEN NO MATCH
SELECT 
  (P.PRJNO)
, (P.Title)
, (C.CompanyName) FROM 
ABC.Projects AS P RIGHT JOIN ABC.Companies AS C 
ON P.CRNNO = C.CRNNO;

-- LEFT JOIN ( ALL ROWS FROM RIGHT TABLE EVEN NO MATCH
SELECT 
  (P.PRJNO)
, (P.Title)
, (C.CompanyName) FROM 
ABC.Projects AS P FULL JOIN ABC.Companies AS C 
ON P.CRNNO = C.CRNNO;


-- UPDATE
UPDATE ABC.Projects 
SET StartDate = '2022-07-10'
WHERE PRJNO = 407;


--DELETE 


DELETE FROM ABC.Projects WHERE PRJNO = 406;

DROP TABLE ABC.PROJECTS;
TRUNCATE TABLE ABC.PROJECTS;

--SUBQUERY

SELECT * FROM ABC.Projects;
SELECT * FROM ABC.ProjectTechnology;
SELECT * FROM ABC.Technology;

UPDATE ABC.Projects SET InitialCost = InitialCost * 1.05
WHERE 
PRJNO IN (SELECT PRJNO FROM ABC.ProjectTechnology 
WHERE TechnologyId =(SELECT Id FROM ABC.Technology
WHERE Name ='ORACLE'));