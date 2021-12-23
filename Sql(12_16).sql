
-- 테이블을 만들고 그 안에 값을 기입할 때 사용하는 코드

-- 테이블
CREATE TABLE `데이터베이스 명`.`테이블 이름` (
  `column1` INT NOT NULL,  -- column이름 데이터형식 
  `column2` VARCHAR(45) NOT NULL, -- column이름 데이터형식 
  PRIMARY KEY (`cloumn1`));  -- PRIMARY key('PRIMARY KEY로 지정할 COLUMN 이름')
-- 데이터
INSERT INTO `데이터베이스 명`.`테이블 이름` (`column1`, `column2`, `column3`) VALUES ('값1', '값2', '값3');

-- column명 변경할 때 
ALTER TABLE `데이터베이스명`.`테이블명` 
CHANGE COLUMN `변경 전 column명` `변경 후 column명` VARCHAR(45) NOT NULL ;


USE shopdb;  -- 데이터베이스를 활성화 시킬 때 사용

-- Java는 코드 작성 후 컴파일 - 실행시키는 구조.
-- 하지만 SQL은 interactive한 언어예요!

-- 모든 회원을 조회하세요!
SELECT * 
FROM memberTBL;

-- 모든 회원의 이름을 조회하세요!
SELECT memberName
FROM memberTBL;

SELECT memberName '회원이름'
FROM memberTBL;

SELECT memberName '회원이름', memberAddr
FROM memberTBL;

-- 주소가 '경기' 인 회원의 이름과 주소를 출력하세요!
SELECT memberName AS '이름', memberAddr AS '주소'
FROM memberTBL
WHERE memberAddr = '경기';
