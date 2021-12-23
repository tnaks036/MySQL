USE employees;

USE shopdb;

SELECT *
FROM employees.employees;

-- Table 생성   -- 이미 데이터 베이스가 선택되었을 경우 table 명만 입력해도 됨. 본래는 CREATE TABLE `데이터베이스명`.`테이블명`임()
CREATE TABLE indexTBL(
    first_name    VARCHAR(14),
    last_name     VARCHAR(16),
    hire_date     DATE
);

-- 생성된 Table에 데이터를 입력해 보아요!
INSERT INTO indexTBL VALUES('길동','홍','20210101'); -- 앞선 언급한 방법보다 이 방법이 도 경제적일듯

SELECT *
FROM indexTBL;

-- 테이블안에 데이터를 모두 삭제
DELETE FROM indexTBL;

SELECT first_name, last_name, hire_date
FROM employees.employees
LIMIT 500;   -- 500명까지 집어넣기
    
INSERT INTO indexTBL
    SELECT first_name, last_name, hire_date
    FROM employees.employees
    LIMIT 500;

SELECT *
FROM indexTBL;
-- 안에 500개의 데이터가 존재하지만 
-- index는 설정이 안되어 있어요!!

-- indexTBL에서 first_name이 'Mary'인 사람만 조회.
SELECT *
FROM indexTBL
WHERE first_name = 'Mary';

-- 인덱스 설정을 안했기 때문에 Full Table Scan이
-- 실행되서 상당히 느리게 수행되었어요!

-- index라는걸 이용해서 좀 빨리 수행시켜 보아요!
-- index를 indexTBL에 만들어 보아요!
-- index는 column에 설정해요!
CREATE INDEX index_indexTBL_firstname  -- ※보통 index의 이름은 테이블과 column 이름으로 지어줌
ON indexTBL(first_name);  -- (index로 설정할 column의 이름)

-- index 생성 후 다시 조회
SELECT *
FROM indexTBL
WHERE first_name = 'Mary';  -- 보통 인덱스는 where을 조건으로 생성됨 -> marry 행 데이터가 전부 뜸 

-- View를 만들어 보아요!
-- View는 가상의 table이라고 생각하면 됨
-- 보통 v_talbe이름으로 생성함

CREATE VIEW v_memberTBL  
AS
    SELECT memberName, memberAddr 
    FROM memberTBL;


SELECT *
FROM v_memberTBL;

-- DELIMITER //       -- ; -> //  ;를 문장끝으로 사용하는 것이 아니라 //를 문장끝으로 사용한다는 이야기

-- CREATE PROCEDURE myProc()   -> PROCUDURE의 절차를 변수로 명시
-- BEGIN
--     SELECT * FROM memberTBL WHERE memberName = '아이유';
--     SELECT * FROM productTBL WHERE prodName = '냉장고';
-- END //

-- DELIMITER ;

-- CALL myProc();



DELIMITER //     

CREATE PROCEDURE myProc()
BEGIN
    SELECT * FROM memberTBL WHERE memberName = '아이유';
    SELECT * FROM productTBL WHERE prodName = '냉장고';
END //

DELIMITER ;
CALL myProc();

desc memberTBL; 
-- desc는 describe의 약어로 describe memberTBL로 읽어도 똑같음;
-- INSERT INTO memberTBL VALUES('Iu','아이유','서울') ;

CREATE TABLE deleteMemberTBL (
    memberID CHAR(10),
    memberName VARCHAR(45),
    memberAddr VARCHAR(45),
    deleteDate DATE
);

-- Trigger에대한 설명 
-- Trigger(트리거) : 일반적으로 table에 부착되어 table에서 insert, update(테이블에서 데이터 수정하는 것), delete 작업이 실행되면 실행되는 코드를 지칭 
-- -> 들어왔던 행동에 대해서 별도의 행동이 생성됨

-- -> 테이블 하나 생성할꺼에요 (deleteMemberTBL)
-- -> memberTBL에서 삭제작업이 일어나면 그 데이터를 deleteMemberTBL로 이동 
-- old 지금 발생한 사건을 의미 :old, :new
--  curdate()  -> my sql에서 갖고있는 현재 날짜

-- DELIMITER //
-- CREATE TRIGGER trg_deleteMemberTBL
--     AFTER DELETE			
--     ON memberTBL
--     FOR EACH ROW (각 행)
-- BEGIN
-- 	-- 삭제된 행을 deletememberTBL에 입력 
--     INSERT INTO deletememberTBL VALUE(
--         OLD.memberID, OLD.memberName, OLD.memberAddr, 
--         CURDATE()
--         );
-- END //
-- DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_deleteMemberTBL
    AFTER DELETE			
    ON memberTBL
    FOR EACH ROW
BEGIN
	-- 삭제된 행을 deletememberTBL에 입력 
    INSERT INTO deletememberTBL VALUE(
        OLD.memberID, OLD.memberName, OLD.memberAddr, 
        CURDATE()
        );
END //
DELIMITER ;

-- 정상적으로 수행되는 지 확인
SELECT * FROM memberTBL;				-- 4명
SELECT * FROM deleteMemberTBL;			-- 없어요

DELETE FROM memberTBL
WHERE memberName = '아이유';				-- 명단에서 아이유는 삭제됨 

SELECT * FROM memberTBL;				-- 3명
SELECT * FROM deletememberTBL;			-- 1명

-- 데이터 모델링 관련 내용은 필기에 있음 

-- 2개의 테이블이 간에 relation(관계)이 존재 
-- => 관계는 보통 동등한 관계가 없음  -> Master-slave(detatil) 관계
-- 주가 되는 쪽이 master고 보조가 되는 것이 slave(detatil)  
-- -> 관계가 1: n의 관계 ( 1이 마스터 -> 예를들어 고객에 대한 개인정보에 관한 내용과  고객이 구매한 내용이 각각 존재했을 때
-- 1명의 고객이 여러 개의 제품을 구매할 수 있음!)

-- work bench 통해서 모델링 하기
-- file -> new model -> Physical Scheme 밑에 있는 mydb 더블 클릭 -> 위에 add diagram 클릭 -> place new talbe 클릭 후 테이블에 데이터 넣기
-- -> 


