-- 데이터베이스 사용
USE employees;


-- 일반적으로 대소문자를 섞어서 사용해요!
-- 키워드는 대문자, 식별자는 소문자(관용적으로 이렇게 사용해요!)

-- workbench의 경우에는 select된 record의 수를 제한할 수 있어요! (위쪽에서 설정 -> limit 제한을 하기 싫으면 don't limit 선택)

SELECT *
FROM titles;

-- SELECT에서 '*'는 모든 column(열)을 의미한다.
-- FROM 뒤에는 테이블을 명시해야 해요! 원칙적으로는 
-- '데이터베이스 이름. 테이블 이름'

SELECT *
FROM employees.titles;

-- 특정 column의 값을 알아올때는 컬럼명을 , 를 기준으로
-- 나열alter
SELECT first_name, last_name, hire_date 
FROM employees.employees;
-- 현재 사용가능한 데이터베이스(스키마)를 조회.
SHOW DATABASES;

-- employees schema(database)를 선택
USE employees;

-- 현재 schema의 모든 테이블들에 대한 세부정보를 출력
SHOW TABLE STATUS ; 

-- 특정 table의 상세(명세)를 알고 싶은 경우
DESC titles;
-- 여기서 3개의 primary key가 존재 -> 이것은 여러개의 column을 묶어서 하나의 primary key로 설정한 것 

-- alias(별칭)를 부여할 수 있어요!
-- 쿼리가 실행되면 결과집합(result set, result grid)r가
-- 생성이 되요!(이 결과 집합도 결국 테이블구조로 되어있어요!) -> 테이블은 아님(임시용)
SELECT memberName AS '이름'  -- 여기에 ,가 있으면 안됨 
From shopdb.membertbl;
-- alias는 단지 보기 편하기 위해서 사용하는건 아니에요!
-- 실제로는 SQL 구문사용을 편하게 끌고 가기 위해 사용. 
-- AS keyword는 생략이 가능 


-- 조건절 WHERE에 대해서 알아보아요!
-- 먼저 샘플 schema를 하나 생성할 꺼에요!
-- 그리고 테이블 2개를 생성해보아요!

-- DROP은 지우라는 의미
-- 만약 sqldb라는 schema(database)가 존재하면 삭제
DROP DATABASE IF EXISTS sqldb;
-- IF EXISTS가 없을 경우 에러가 뜸 !!!

-- sqldb schema를 생성합니다.
CREATE DATABASE sqldb;

-- sqldb를 사용할게요
USE sqldb;


-- 테이블을 생성할 꺼에요!
CREATE TABLE userTBL(
	userID		Char(8)	NOT NULL PRIMARY KEY, -- 사용자 ID(PK)
    name 		VARCHAR(10) NOT NULL, -- 사용자 이름
    birthYear  INT NOT NULL,-- 출생연도(ex. 1991)
    addr Char(2) NOT NULL,
    mobile CHAR(3), -- 휴대폰 국번
    mobile2 CHAR(8), -- 휴대폰 나머지 번호 
    height SMALLINT, -- '180 이상' 과 같은 수치 연산을 진행하기에 int로 설정할 필요 O + SMALLINT : 작은 범위를 사용하기에 메모리 차지 비중이 적음 -> 사람키가 300cm안넘기에
    mdate DATE -- DATETIME은 해당 날짜와 시간까지 기입함
);

-- ※숫자에 대해 INT CHAR 설정에 관한 팁
-- -> 숫자로 수치연산이 없는 경우 CHAR(문자)로 설정하는 것이 좋음 -> 문자열 자체가 LIST로 형성되어 있기에, 검색하는 것은 문자가 좋음

-- 구매테이블(buyTBL)을 생성해보아요!
CREATE TABLE buyTBL(
	num  INT AUTO_INCREMENT NOT NULL PRIMARY KEY,--  column안에 들어가는 값이 자동으로 1씩증가함 
    userID 	CHAR(8) NOT NULL,  -- userID의 이름은 위의 테이블의 이름과는 다른 이름으로도 변경해도 상관이 없으나, 데이터 형식은 똑같아야 함.
    prodName CHAR(6) NOT NULL,
    groupName CHAR(4) ,
    price INT NOT NULL,
    amount SMALLINT NOT NULL, -- 1억개 정도 사는 것은 아니기에 
    FOREIGN KEY(userID) REFERENCES userTBL(userID)-- foreign key는 primay key와는 다르게 끝에서 설정하기 / FOREIGN KEY가 userTBL에서 userID를 가리킨다.
    );
    
    
    
INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울', NULL, NULL, 186, '2013-12-12');
INSERT INTO usertbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
INSERT INTO usertbl VALUES('YJS', '윤종신', 1969, '경남', NULL, NULL, 170, '2005-5-5');
INSERT INTO usertbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3');
INSERT INTO usertbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO usertbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');

-- 첫 번째부터 null로 설정을 해도 autou_increasement가 실행되면서 첫 번째 부터 1이 기입됨.
INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화', NULL , 30, 2);  
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자', 200, 1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '모니터', '전자', 200, 5);
INSERT INTO buytbl VALUES(NULL, 'KBS', '청바지', '의류', 50, 3);
INSERT INTO buytbl VALUES(NULL, 'BBK', '메모리', '전자', 80, 10);
INSERT INTO buytbl VALUES(NULL, 'SSK', '책', '서적', 15, 5);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책', '서적', 15, 2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '청바지', '의류', 50, 1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL , 30, 2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책', '서적', 15, 1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL, 30, 2);

SELECT *
FROM userTBL;

SELECT *
FROM buyTBL;

-- SELECT 한 결과가 입력한 순서와 달라요!
-- 그 이유는 .. userID를 Primary Key로 설정했기 때문.
-- Primary Key로 설정하면 자동으로 클러스터형 인덱스가 설정 -> cluster형 인덱스로 설정되면 오름차순으로 해당 컬럼을 정렬함
-- 클러스터형 인덱스가 설정되어서 userID 칼럼으로 오름차순 정렬.


-- 이제 WHERE절을 알아보아요!

-- name이 '김경호'인 사람의 정보를 조회하세요!

SELECT *
FROM userTBL
Where name = '김경호' ; -- 싱글컨텐션으로 쓰기 / 더블케텐션은 아님


-- 1970년 이후에 출생하고 신장이 182인 사람의 아이디와
-- 이름을 조회하세요

SELECT  userID as '아이디', name as '이름'
FROM userTBL
WHERE birthyear >= 1970 AND height >= 182;

-- OR도 있음

-- 키가 180~183 인 사람을  조회하세요!
SELECT *
FROM userTBL
WHERE height >=180 AND height <= 183;

SELECT *
FROM userTBL
WHERE height BETWEEN 180 AND 183 ; -- 일반적으로 범위를 표현할 때는  BETWEEN을 사용함 


-- 지역이 '경남', '전남', '경북'인 사람을 조회하세요!
SELECT *
FROM userTBL
WHERE addr = '경남' OR addr ='전남' OR addr = '경북';

SELECT *
FROM userTBL
WHERE addr IN ('경남', '전남', '경북');

-- WHERE절을 통해 비교연산자 조건연산자를 사용


-- 와일드 카드를 이용해요!(%, _)
-- %는 0개 이상의 글자를 의미해요!
-- 홍길%   => 홍길로 시작하는 모든 문자열을 일컬음 
-- 신%당 => 신으로 시작하고 당으로 끝나는 모든 문자열을 일컬음 신과 당 사아이ㅔ 뭐든지 들거아면 됨!
-- _ : 1개의 글자를 의미 
-- 신_당 => 신과 당 사이에 한 글자가 들어가면 됨.
-- 성이 김씨인 사람들의 이름 => '김%' 


-- 패턴매칭(문자열 검색)
-- 성이 김씨인 사람들의 이름과 나이를 조사하세요!
SELECT name 이름 , birthyear 나이
FROM userTBL
WHERE name LIKE '김%'; -- '='이 아니라 LIKE사용
-- 앗.. 패턴매칭은 문자열검색할 때 상당히 좋은 기능을
-- 우리에게 제공해요!
-- MySQL에 부하를 많이 줘서 성능에는 좋지 않은 영향을 미쳐요!
-- 꼭 필요치 않은 경우에는 남용해서는 안됨.. 

-- --------------------------------------------------------------------------------------------------------------------------


-- 이번에는 SubQuery!!!에 대해서 살펴보아요!

-- 김경호보다 키가 크거나 같은 사람의 이름과 키를 출력하세요!
-- 1. 일단 김경호의 키를 알아내야 하겠구나
SELECT height
FROM userTBL
WHERE name = '김경호';

-- 2. 김경호의 키가 177 이거나 이거보다 큰 사람의 이름과 키를
-- 출력하면 되겠구나.
SELECT name, height
FROM userTBL
WHERE height >= 177; -- 4명 

-- => 어떤 데이터를 알아내서 찾아내는 것 -> sub-query를 통해 한 방에 해결 가능

-- Subquery를 이용해서 표현해 보아요!
SELECT name, height
FROM userTBL
-- WHERE height >= (김경호 나이)
WHERE HEIGHT >= (
	SELECT height
    FROM userTBL
    WHERE name = '김경호'); -- 4명
    -- query 안에 query를 sub-query라고 함
    

-- 지역이 '경남'인 사람의 키보다 
-- 키가 같거나 큰 사람을 모두 조회하세요!
--



SELECT *
FROM userTBL
WHERE HEIGHT >= ANY (
	SELECT height
	FROM userTBL
	where addr = '경남');

SELECT *
FROM userTBL
WHERE HEIGHT >= ALL (
	SELECT height
	FROM userTBL
	where addr = '경남');
    
-- ANY 와 ALL은 반대 개념 
-- 그 중에 하나라도 크거나 같은 것 : ANY
-- 싹다 큰 것이나 캍은 것 : 미ㅣ



SELECT *
FROM userTBL
WHERE HEIGHT >= (
	SELECT min(height)
	FROM userTBL
	where addr = '경남');
    
-- 정렬은 어떻게 하나요?
-- 먼저 가입한 순서대로 정렬해서 회원의 이름과 가입일을 출력하세요!! 
-- ASC(오름차순 정렬 - default), DESC(내림차순 정렬)
-- ORDER BY절은 무조건 SQL 문자의 맨 마지막에 나와요!
SELECT name, mdate 
FROM userTBL
ORDER BY mdate ASC
-- ORDER BY : 정렬해 
-- ORDER BY는 맨 끝에 나옴 -> 위에 나온 것들을 정려해야 하기에
-- ASC : ascending : 컴퓨터에서는 아무런 언급 없으면 오름차순 : 작은 것이 올라감
-- DESC : descending : 내림차순 -> 작은 것이 내려감

-- 2차정렬 회원가입일에 동률이 있을 경우. 다시 말새서 1차 정렬에 동률이
-- 있는 경우 두 번째 정렬기준으로 정렬하는 것을 의미.

SELECT name, mdate
From userTBL
ORDER BY mdate ASC, name DESC;
-- 첫 번째 날짜로 구별하고, 날짜가 동률일 경우 이름으로 내림차순하기ALTER

-- userTBL에서 회원들의 거주지역이 어디인지를 출력하세요!
SELECT DISTINCT addr '거주지역'
FROM userTBL;
-- 어머 중복된 행이 존재해요! 이런 필요없는 중복된 행을 제거하려면
-- 하나의 키워드를 이용해요!
-- DISTINCT
    
-- ---------------------------------------------------------------------------------------------------------------


-- employees Database에 있는 employees tabledmf
-- 잠깐 이용해보아요!
SELECT first_name, hire_date
FROM employees.employees
ORDER BY hire_date; -- 30만개가 출력

-- 입사일을 기준으로 가장 오래전에 입사한 사람 10명만
-- 이름을 내림차순 정렬해서 알고 싶어요!
SELECT first_name, hire_date
FROM employees.employees
ORDER BY hire_date, first_name DESC
LIMIT 10; -- 위에서 부터 10개만 들고 와
-- LIMIT 10 = LIMIT 1, 10;  -> 시작은 1이에요. 그 다움에 개수를 입력
-- DBMS는 첨자가 0부터 시작 x , 1부터 시작함  -> 이것은  SQL마다 다름  0부터 시작하는 경우도 존재/ 본래 표준은 1부터 시작 
-- LIMIT 2, 2 -> 2번째 부터 시작 2개 = 2, 3 이 출력됨 


-- 테이블 복사하는 방법
-- buyTBL을 복사해 보아요!

-- 테이블을 생성해요 : CREATE TABLE ~~
-- INSERT를 이용해서 하나하나 입력하세요 

USE sqlDB;

CREATE TABLE buyTBL2(
	SELECT * FROM buyTBL
);

DESC buyTBL2 ;
-- 키가 복사가 안됨! 데이터만 가지고 와서 데이터만 복사함
-- key 가 복사가 안된다는 것을 알고 있기!!!


-- -------------------------------------------------------------------------

-- SELECT, FROM, WHERE, ORDER BY(ASC, DESC)
-- DISTINCT, ANY, ALL, AS(alias)
-- IN, 일반 비교연산자(>=, <), AND, OR, 
-- LIKE(pattern matching - whildcard문자(%, _))
-- DROP, SHOW, LIMIT, Subquery
-- FOREIGN KEY ~ REFERENCES ~
-- NOT NULL, AUTO_INCREMENT
-- BETWEEN A AND B


-- userTBL에서 나이순으로 이름과 나이를 5명만 출력하세요

SELECT name '이름', 2021- birthYear+1 '나이' -- 연산으로 사용 가능 
FROM userTBL
ORDER BY birthYear ASC
LIMIT 5;

-- ---------------------------------------------------------------------------

-- buyTBL에서 사용자가 구매한 물푸의 개수를 출력하세요!.
-- 물건의 종류와 단가와 상관없이 개수를 구하고 싶을 때 
-- 같은 놈들 끼리 더해야함 -- 이를 Grouping이라고 함 
SELECT userID, amount
From buyTBL;
-- 결과가 이상해요. 이 문제를 해결하려면 2가지를 알아야 하는데
-- 하나는 Grouping 개념이고 또 하나는 집계함수예요. => 사용자 별로 그룹을 나눠서 합계를 내면 된다.ALTER

SELECT userID, SUM(amount)
FROM buyTBL
-- 조건이 있을 경우 여기에 WHERE가 옴
GROUP BY userID;


-- 전체 SQL절의 순서는...
-- SELECT
-- FROM
-- WHERE
-- GROUP BY
-- HAVING 
-- ORDER BY

-- 조건은 2가지 : 
-- WHERE 은 SELECT의 조건
-- HAVING은 GROUP BY의 조건임 : GROUP BY가 선행해야 HAVING이 나옴

-- RDBMS(MYSQL) 


-- 각 사용자별 구매액의 총합을 구하세요!
SELECT userID, SUM(price * amount )
FROM buyTBL
GROUP BY userID
ORDER BY userID;
-- as는 엘리아싱이라고 일컬음
-- 사용자별 구입한 금액 X 수량


-- 우리가 많이 사용하는 집계함수는 어떤게 있을까요?
-- SUM(), AVG(), MAX(), MIN(), COUNT(), STDEV()
-- COUNT(DISTINCT) : 중복을 배제하고 셀 것인가를 의미함 
 -- COUNT= 몇 개가 있느냐?
 -- STEDEV() - 표준편차 

-- 가장 큰 키와 가장 작은 키의 회원이름과 키를 출력하세요 

SELECT name 이름, MAX(height), MIN(height)
From userTBL
GROUP BY name;

-- 그럼 어떻게 해야 하나요?

-- Subquery를 적극적으로 활용해보세요

SELECT name, height
FROM userTBL
WHERE height = (SELECT MAX(height) From userTBL) OR 
	  height = (SELECT MIN(height) From userTBL);



-- WHERE height = (가장 키 큰 사람의 height) OR 
-- 	  height = (가장 키 작은 사람의 height)
