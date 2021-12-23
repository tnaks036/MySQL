USE sqldb;

SELECT *
FROM userTBL;

-- 모든 회원의 수를 알아보아요! 
SELECT COUNT(*)
FROM usertbl;

-- 핸드폰을 가지고 있는 회원의 수를 알아보아요!
SELECT COUNT(mobile)
FROM userTBL;


-- 현재 SQL구문
-- SELECT 컬럼들
-- FROM 테이블
-- WHERE 조건   : 조건을 가지고 SELECT함
-- GROUP BY~    : 그룹을 지은 다음에 해당 그룹에 조건을 지을 수 있음 -> WHERE로 걸지 못함 
-- HAVING ~ : GROUP BY의 조건임 
-- ODER BY !

-- 사용자별 총 구매 금액이 1000원 이상인 사용자만 출력하세요.

SELECT *
FROM buyTBL;

SELECT userID, SUM(price*amount)
FROM buyTBL
GROUP BY userID  -- id로 그룹화함
-- WHERE SUM(price*amount) >= 1000 : 오류가 뜸 -> 직계함수는 WHERE절에 오는 것이 부담스러움
HAVING SUM(price*amount) >= 1000;

-- -----------------------------------------------------------------------------------------------------------------
-- INSERT에 대해서 알아보아요!

USE sqldb;

CREATE TABLE testTBL1(
	 id 		INT,
     userName 	CHAR(3),
     age		INT
);

SELECT *
FROM testTBL1;

-- 일반적인 Insert

INSERT INTO testTBL1 VALUES(1, '아이유', 20);
-- not null 기입 안되어 있어 데이터 생략 가능

-- 필요한 값만 insert
INSERT INTO testTBL1(id, userName) Values(2, '홍길동');
-- 부분적으로 집어넣을 경우 column명을 설정해서 집어넣기
INSERT INTO testTBL1(age, id, userName) Values(40, 3, '홍길동');
-- 집어넣을 순서를 바꾸기 위해서는 어느 곳에 어떤 값을 집어넣을지 기입해야 함.

-- 데이블안의 데이터를 싹 지워요!
DELETE
FROM testTBL1;

SELECT *
FROM testTBL1;

CREATE TABLE testTBL2(
	id		INT AUTO_INCREMENT PRIMARY KEY,
	userName 	CHAR(3),
    age		INT
);

SELECT *
FROM testTBL2;

INSERT into testTBL2 VALUES(NULL, '홍길동' , 20 );
-- 값을 안 넣으면 자동으로 숫자가 들어감

SELECT *
FROM testTBL2;

INSERT into testTBL2 VALUES(NULL, '아이유' , 40 );
-- AUTO_INCREMENT는 1부터 1씩 증가해서 값이 채워져요!

-- 이런 기본 설정값들은 모두 변수에 저장되어 있어요! 해당 변수를 수정하면
-- 되요!


-- AUTO_INCREMENT를 100부터 다시 시작할꺼에요!
-- 테이블의 설정을 바꿔야해요!
ALTER TABLE testTBL2 AUTO_INCREMENT = 100;
-- AUTO_INCREMENT가 원래 1부터 시작하는데 100부터 시작함.

INSERT into testTBL2 VALUES(NULL, '강감찬' , 10 );
SELECT *
FROM testTBL2;


INSERT into testTBL2 VALUES(NULL, '조용필' , 60 );
SELECT *
FROM testTBL2;

-- 그럼 1씩 증가가 아니라 5씩 증가하려면 어떻게 하나요?
-- MySQL 변수에 저장되어 있어요! 

-- ADMINSTRATION -> Status and System Variables -> System variable -> auto 검색 -> auto_increment_increment

-- 변수값을 변경할 땐느 Set을 사용
SET @@AUTO_INCREMENT_INCREMENT = 5; -- 시스템 변수는 변경시 앞에 @@를 붙여야함.

INSERT into testTBL2 VALUES(NULL, '성시경' , 30 );

SELECT *
FROM testTBL2;


SET @@AUTO_INCREMENT_INCREMENT = 1;
-- 여기까지가 INSERT 구문이에요 !

-- ----------------------------------------------------------------------------------------------------------------------------------------------
-- 이번에는 수정(UPDATE)에 대해서 알아보아요!
-- testTBL2를 수정할 것인데, 순번은 primary key 와 auto_increment가 설정되어 있기에 안바꾸는 것이 좋음

-- UPDATE testTBL2
-- 	SET userName = '김연아';
    -- 이렇게 실행할 경우 testTBL2에 모든 userName 이 김연아로 바뀜
UPDATE testTBL2
	SET userName = '김연아'
    WHERE id = 1;
    
SELECT *
FROM testTBL2;

-- 삭제(DELETE)에 대해서 알아보아요!
-- 테이블 안에 모든 데이터를 삭제함.
-- DELETE
-- FROM testTBL2;

-- 일반적으로 조건에 맞는 데이터만 삭제!
DELETE
FROM testTBL2
WHERE ID = 2;

SELECT *
FROM testTBL2;

-- 삭제를 할 때는 크게 3가지 방법이 있어요!
-- 1. DELETE(삭제 속도가 느려요. Transaction Log를 기록하기 때문에 -- 한 줄 지우면 기록하는 것이 반복됨)  -> 얘는 복구 가능
-- 2. 테이블안의 데이터를 싹 다 지울려고 해요! => DROP 
-- 3. TRUNCATE => 얘는 DELETE와 똑같음 하지만 (삭제 속도가 빨라요. Transaction Log를 기록하지 않기 때문에)  -> 얘는 복구 불가능

-- -------------------------------------여기까지가 SQL의 기본이예요! ---------------------------------------------------

-- 명시적 형변환의 예
-- CAST : 형변환
USE sqldb;

-- 평균 구매 개수

SELECT CAST(AVG(amount)AS SIGNED INT )AS '평균 구매 개수' -- 여기서 ()안의 AS는 Aliaising이 아님
-- SIGNED가 붙으면 '부호가 있는 ' 의 의미
FROM buyTBL;
-- cast를 사용하여 int로 변환시 반올림이 됨.


SELECT AVG(amount) AS '평균 구매 개수'
FROM buyTBL;


SELECT price
FROM buyTBL;

SELECT CONCAT(CAST(price AS CHAR(10)), ' 개 입니다.')
FROM buyTBL;
-- SQL에서 문자와 문자를 연결할 때에는 CONCAT을 사용함. 
-- JAVA와는 다르게 문자를 +로 연결하지 못함. 
-- 이 쪽에서는 그냥 형 변환으로 이해하기 

-- 약간 묘한... 형변환에 대한 예제를 살펴보아요!

SELECT '100' + '200';
-- 100200 이 아니라 300이 나옴 : 연산자 overloading? 
-- sql에서 +는 원래 숫자를 더하는 거에요(MySQL) -> 제품마다 다름
-- char인 100과 200은 숫자로 변환이 가능하기에 변환해서 +를 함
-- java는 overloading : 이름은 똑같지만 다른 용도로 사용한 것 - method에서 이루어 지기에 method overloading이라고 부름


SELECT 100 + '200'; -- 문자와 숫자를 더하는 경우 문자를 숫자로 변환해서
					-- 더해요
                    
SELECT 'Hellow' + 'World';	-- 문자로 시작하는 경우 0을 반환
-- +기호가 Hellow 와 World를 숫자로 변경해야 함.
-- 문자를 합치는 것은 CONCAT()임

SELECT 100 +'35Hello' ;  -- 문자가 숫자로 시작할 때는 시작하는 숫자부분을 남겨요.
-- ex) '35Hello11 '  = 35
-- 앞에가 숫자인 부분만 숫자로 남기고, 뒤에 문자인 부분은 날림

SELECT CONCAT('Hello', 'World');

SELECT concat(100, 200);

SELECT 1 > '2haha'; -- '2haha'는 2로 변환 됨. - False는 숫자 0으로 표현
-- False 는 0 , true는 1 

SELECT 3 > '2haha';  -- True는 숫자 1로 표현

SELECT 0 = 'Hello';  -- 문자는 0으로 변환하기에 해당 결과는 True, 그래서 1이됨. 



-- MySQL 내장함수
-- 무지막지하게 많아요!
-- CONCAT() 이런게 내장함수에요!

-- 제어관련된 내장함수 
SELECT IF();
SELECT IF(100 > 200, '참', '거짓' ) ;
-- ※ Ifm는 원래 제어문인데 여기서는 함수의 역할로 사용

SELECT IFNULL(100, '홍홍홍') ;
-- NULL이면 '홍홍홍'을 선택하고, 그렇지 않으면 첫 번째 인자를 선택함
SELECT IFNULL(NULL, '홍홍홍') ;
-- 문자열 내장함수
SELECT LENGTH('abcde'); -- 5
SELECT LENGTH('홍길동');  -- 9
-- mysql에서 LEGHTH는 Byte임 
-- 영어에서 글자 1개는 1byte,  한국은 글자 1개에 3byte

SELECT CHAR_LENGTH('abcde');  -- 5
SELECT CHAR_LENGTH('홍길동');	-- 3

SELECT CONCAT('홍', '길동'); -- 홍길동

-- WS도 연결하는 것임
SELECT CONCAT_WS('-', '1990','02','25');
-- 1990-02-25
-- 첫 번째 '-'자리에 '777'이 나오면 777로 연결함

SELECT TRIM('  하하하  호호호 캬캬캬   ');
-- TRIM은 문자열이 시작하기 전 공백과 문자열이 끝난 후 나오는 공백을 자름

-- SELECT SUBSTRING() ;
SELECT SUBSTRING('이것은 소리없는 아우성', 3, 5) ;
-- SUBSTRING은 부분 문자열임 
-- MySQL은 첨자가 1부터 시작
-- 3부터 시작 5글자
-- 이런 내장함수들이 상당히 많이 있어요!

-- -------------------------------------------------------------------------------------------------------
-- 큰 용량을 테이블 안에 집어 넣는 법
-- LONGTEXT, LONGBLOB data type
-- 많은 글자들과 동영상을 테이블에 저장하려면 어떻게 해야 하나요?
-- 1. 영화대본(txt파일), 영화동영상(mp4파일)을 준비해요! => 내가 저장하고픈 데이터를 준비하세요

USE sqldb;
-- create table은 DDM에 속함
CREATE TABLE movieTBL(
	movie_id 		INT AUTO_INCREMENT PRIMARY KEY,
    movie_title 	VARCHAR(30) NOT NULL ,
    movie_director 	VARCHAR(30) NOT NULL,
    movie_script	LONGTEXT, -- VARCHAR은 65000을 넘지 못함
    movie_flim		LONGBLOB
)	DEFAULT CHARSET =utf8mb4;  -- 다국어 지원할 수 있도록 유니코드 설정

INSERT INTO movieTBL VALUES(NULL, 
		'쉰들러 리스트', 
        '스티븐 스필버그',
        LOAD_FILE('C:/sql/movies/movie.txt'), -- 경로를 문자열로 불러오기
        LOAD_FILE('C:/sql/movies/movie.mp4')
        );
        -- 안에 데이터가 안들어감 


DELETE 
FROM movieTBL ;

SELECT *
FROM movieTBL;

-- 확인해보면 .. 파일의 내용이 입력 되지 않았어요 
-- 2가지 이유가 있어요. 하나는 최대 패킷의 크기때문이고...
-- 다른 하나는 보안상의 이유

-- 최대 패킷의 크기는 저장할 수 있는 파일의 크기라고 생각하면 되요!
-- 디폴트로 4m로 설정되어 있어요! (초기에)
-- 이걸 늘려야 해요!

-- 아무 폴더에서나 데이터를 LOAD_FILE()로 불러들일 수 없어요
-- LOAD FILE을 안전하다고 인지 시켜야함
-- 해당 폴더가 설정으로 잡혀 있어야 해요!

-- 이제 해당 설정을 찾아서 변경해야 해요!
-- 그럼 이 설정은 도대체 어디에 있나요?
-- my,ini에 있어요.. 잘 찾아서 두 개의 설정을 변경해야 해요!


-- 이렇게 데이터가 잘 저장되었습니다!
-- 확인해보아요!

SELECT movie_script
FROM movieTBL
WHERE movie_id = 1
INTO OUTFILE 'C:/sql/movies/text_out.txt'
LINES TERMINATED BY '\\n';
-- Line의 끝에 줄바꿈이 있으면 실행해 라는 의미임.

SELECT movie_flim
FROM movieTBL
WHERE movie_id = 1
INTO DUMPFILE 'C:/sql/movies/video_out.mp4';
-- 이미지와 비디오 같은, binary file은 무조건 DUMPFILE로 변환

-- ----------------------------------여기까지가 Data Type, 형변환, 내장함수, 특이한 데이터타입 사용 .-------------------------------------------------------



-- SQL의 가장 중요한 성질, 기능... JOIN ----------------------------------
-- 지금까지는 하나의 테이블을 대상으로 얘기하고 있었어요!

-- JOIN은 여러 개의 테이블을 결합시켜서 원하는 데이터를 추출하는
-- 방법을 제공해줘요! (여러 개의 테이블에서 필요한 데이터를 뽑는 것)
-- 그래서 거의 필수적인 작업이에예요!! 


-- 기본적으로 RDBMS는 중복을 허용하지 않아요!
-- 각 테이블마다 중복되지 않은 고유한 데이터들이 있다 -> 데이터들이 분산되어 있다.
-- 관련있는 데이터들이 여러 테이블에 나누어져 저장되어 있어요!
-- 그래서 JOIN이 필요한데.. 문제는 이 JOIN이라는 작업이 무거운 작업이예요!
-- MYSQL에 부하가 가중되요! -> Response time이 느려짐 
-- 최소한으로 JOIN을 사용해야 함. 가능하면 안사용하는 것이 BEST
-- 잘 써야 한다. 


-- JOIN은 여러 종류가 있습니다. (테이블이 어떻게 붙느냐에 따라서 종류가 달라짐)
-- 그런데 대부분의 경우 우리가 사용하는 JOIN은 'INNER JOIN' 이예요!
-- 그래서 그냥 JOIN이라고 할 경우는 대부분 이 'INNER JOIN'을 지칭해요!

-- 테이블이 2개가 생길 경우 왼쪽에 있는 것이 첫 번째 테이블임

-- SELECT <컬럼의 목록>
-- FROM (첫 번째 테이블 이름>
-- 		INNER JOIN<두 번째 테이블 이름>
-- 		ON <조인 조건>
-- WHERE <조건>
-- ~~~


USE sqldb;

SELECT *
from userTBL;


SELECT *
FROM buyTBL;


-- 구매테이블에서 'EJW'가 청바지를 구매했어요!.
-- 이 청바지를 배송해야해요. EJW라는 사람의 주소를 알아야해요!

-- 여기에 뭐 들어갈껄? 강의노트 보고 기입.
-- SELECT *
-- FROM buyTBL
-- 	INNER JOIN userTBL
--     ON buyTBL.userID= userTBL.userID
-- buyTBL을 기준으로 userTBL의 조건에 맞는 데이터 값들을 buyTBL에 붙여야함 




SELECT userTBL.addr -- *아스트로데카
FROM buyTBL
	INNER JOIN userTBL
    ON buyTBL.userID = userTBL.userID
WHERE buyTBL.userID = 'EJW' AND 
	  buyTBL.prodName = '청바지';
    
-- buyTBL을 기준으로 userTBL의 조건에 맞는 데이터 값들을 buyTBL에 붙여야함 
-- 명확하게 어디에 속해있는 column을 명시해 줘야 함.
-- 밑에 prodName은 buyTBL에만 있어서 생략한것. 원래는 어떤 테이블에 속한 것인지 적는 것이 좋음

-- 아래처럼 사용할 수 있어요!
-- 일반적으로 현업에서 이 방법을 많이 이용해요!
SELECT *
FROM buyTBL, userTBL
WHERE buyTBL.userID = userTBL.userID AND
	  buyTBL.userID = 'EJW' AND 
	  buyTBL.prodName = '청바지' ;

-- JOIN을 할 때 Table dlfmadp alias를 설정하는 것은
-- 아주 일반적이에요!


-- --------------------------------------------------에러있음 선생님 코드 다시보기
SELECT userTBL.addr
FROM buyTBL B
	INNER JOIN userTBL U
    on  B.userID = U.userID
WHERE B.userID = 'EJW' AND 
	  B.prodName = '청바지';
-- ------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE stdTBL(
std_name CHAR(5) NOT NULL PRIMARY KEY,
addr CHAR(4) NOT NULL
);
INSERT INTO stdTBL VALUES('김범수', '경남');
INSERT INTO stdTBL VALUES('성시경', '서울');
INSERT INTO stdTBL VALUES('조용필', '경기');
INSERT INTO stdTBL VALUES('은지원', '경북');
INSERT INTO stdTBL VALUES('바비킴', '서울');


SELECT *
FROM stdtbl;


CREATE TABLE stdclubTBL(
	num INT AUTO_INCREMENT PRIMARY KEY,
	std_name CHAR(5) NOT NULL,
	club_name CHAR(5) NOT NULL,
FOREIGN KEY(std_name) REFERENCES stdTBL(std_name),
FOREIGN KEY(club_name) REFERENCES clubTBL(club_name)
);

INSERT INTO stdclubTBL VALUES(NOT NULL, '김범수', '바둑');
INSERT INTO stdclubTBL VALUES(NOT NULL, '김범수', '축구');
INSERT INTO stdclubTBL VALUES(NOT NULL, '조용필', '축구');
INSERT INTO stdclubTBL VALUES(NOT NULL, '은지원', '축구');
INSERT INTO stdclubTBL VALUES(NOT NULL, '은지원', '봉사');
INSERT INTO stdclubTBL VALUES(NOT NULL, '바비킴', '봉사');

SELECT*
FROM stdclubTBL;



CREATE TABLE clubTBL(
club_name CHAR(5) NOT NULL PRIMARY KEY,
room CHAR(5) NOT NULL
);
INSERT INTO clubTBL VALUES('수영', '101호');
INSERT INTO clubTBL VALUES('바둑', '102호');
INSERT INTO clubTBL VALUES('축구', '103호');
INSERT INTO clubTBL VALUES('봉사', '104호');

SELECT*
FROM clubTBL;

SELECT stdclubTBL.std_name, stdTBL.addr, stdclubTBL.club_name, clubTBL.room
FROM stdclubTBL
	INNER JOIN stdTBL
    ON stdclubTBL.std_name = stdTBL.std_name
    INNER JOIN clubtbl
    ON stdclubTBL.club_name = clubtbl.club_name;
    

