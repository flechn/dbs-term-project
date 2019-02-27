CREATE DATABASE takeawayDB
ON PRIMARY
(NAME = takeawayDB_dat,
FILENAME = 'D:\takeawayDB\takeawayDB_dat.mdf',
SIZE = 10, MAXSIZE = 500, FILEGROWTH = 15%),
FILEGROUP takeawayGroup
( NAME = takeawayFil_dat,
FILENAME = 'D:\takeawayDB\takeawayFil_dat.ndf',
SIZE = 10, MAXSIZE = 500, FILEGROWTH = 15%)

LOG ON
(NAME= takeawayDB_log,
FILENAME = 'D:\takeawayDB\takeawayDB_log.ldf',
SIZE = 5MB, MAXSIZE = 25MB, FILEGROWTH = 5MB);

USE takeawayDB
GO
CREATE TABLE merchant(
    Mno      CHAR(10)  PRIMARY KEY,       /*商家号（merchant number）*/
	Sname    CHAR(10)  UNIQUE NOT NULL,   /*店名（store name）*/
	Mname    CHAR(10)  NOT NULL,          /*店主名（merchant name）*/
	Maddr    CHAR(20)  UNIQUE NOT NULL,   /*地址（merchant address）*/
	Mtel     CHAR(20)  UNIQUE NOT NULL,   /*联系方式（merchant telephone）*/
	Mtime    CHAR(20),                    /*营业时间（merchant time）*/
	Mcont    CHAR(20))                    /*经营内容（merchant content）*/

CREATE TABLE goods(
    Gno      CHAR(10),                    /*商品号（goods number）*/
	Mno      CHAR(10),                    /*商家号（merchant number）*/
	Gname    CHAR(10)  NOT NULL,          /*商品名（goods name）*/
	Gprice   FLOAT     NOT NULL,          /*商品价格（goods price）*/
	PRIMARY KEY(Gno, Mno),
	FOREIGN KEY(Mno) REFERENCES merchant(Mno))

CREATE TABLE customer(
    Cno      CHAR(10)  PRIMARY KEY,       /*顾客号（customer number）*/
	Cname    CHAR(10)  NOT NULL,          /*顾客名（customer name）*/
	Caddr    CHAR(20)  NOT NULL,          /*收货地址（customer address）*/
	Ctel     CHAR(20)  UNIQUE NOT NULL,   /*联系方式（customer telephone）*/
	Cmail    CHAR(20)  UNIQUE)            /*邮箱（customer mailbox）*/

CREATE TABLE deliveryman(
    Dno      CHAR(10)  PRIMARY KEY,       /*骑手号（deliveryman number）*/
	Dname    CHAR(10)  NOT NULL,          /*骑手名（deliveryman name）*/
	Dtel     CHAR(20)  UNIQUE NOT NULL)   /*联系方式（deliveryman telephone）*/

create table Torder(
    Tno      CHAR(30),                    /*订单号*/
	Mno      CHAR(10),                    /*商家号（merchant number）*/
	Cno      CHAR(10),                    /*顾客号（customer number）*/
	Dno      CHAR(10),                    /*骑手号（deliveryman number）*/
    Gno      CHAR(10),                    /*商品号（goods number）*/
	Ttime    CHAR(20),                    /*下单时间*/
	Tstat    CHAR(20),                    /*订单状态*/
	PRIMARY KEY(Tno, Gno),
	FOREIGN KEY(Cno) REFERENCES customer(Cno),
	FOREIGN KEY(Dno) REFERENCES deliveryman(Dno),
    FOREIGN KEY(Gno, Mno) REFERENCES goods(Gno, Mno))

/*
drop table Torder;
drop table goods;
drop table merchant;
drop table customer;
drop table deliveryman;
*/

/*一组测试数据*/
INSERT INTO merchant    VALUES('m10001','Steam','GFat','America','+110086',null,null);
INSERT INTO goods       VALUES('01','m10001','Ori','64');
INSERT INTO customer    VALUES('c20001','Snivy蛇','SYSU Zhuhai L11','+8610086','f@l.e');
INSERT INTO deliveryman VALUES('d30001','啊啊啊','+8610000');
INSERT INTO Torder      VALUES('t40001','m10001','c20001','d30001','01','20180521_215003','invalid');

/*预先录入的数据*/
INSERT INTO merchant    VALUES('m10002','Nintendo','GF','Alola','+8110086','Weekday','ns');
INSERT INTO merchant    VALUES('m10003','Sony','Yoshida','Tokyo','+8110010','8:00-24:00','ps4');
INSERT INTO merchant    VALUES('m10004','Ms','Bill Gates','USA','+110010','24h','OS');
INSERT INTO merchant    VALUES('m10005','海市蜃楼','刘老板','中珠北门右转几公里','+110000','天气好时','各种东西');
INSERT INTO merchant    VALUES('m10006','冒险岛','肾大网络','不知道就问下DNS吧。','+1110','24h','情怀');

INSERT INTO goods       VALUES('02','m10001','光之子','68');
INSERT INTO goods       VALUES('03','m10001','Rainbow6','99');
INSERT INTO goods       VALUES('04','m10001','TotheMoon','36');
INSERT INTO goods       VALUES('05','m10001','Bastion','28');
INSERT INTO goods       VALUES('06','m10001','命令与征服','78');
INSERT INTO goods       VALUES('07','m10001','红色警戒','78');

INSERT INTO goods       VALUES('01','m10002','PokemonEP','200');
INSERT INTO goods       VALUES('02','m10002','PokemonAG','200');
INSERT INTO goods       VALUES('03','m10002','PokemonDP','200');
INSERT INTO goods       VALUES('04','m10002','PokemonBW','200');
INSERT INTO goods       VALUES('05','m10002','PokemonXY','200');
INSERT INTO goods       VALUES('06','m10002','PokemonSM','200');

INSERT INTO goods       VALUES('01','m10003','怪物猎人','220');
INSERT INTO goods       VALUES('02','m10003','最终幻想','220');
INSERT INTO goods       VALUES('03','m10003','真三国无双','220');
INSERT INTO goods       VALUES('04','m10003','合金装备','220');

INSERT INTO goods       VALUES('01','m10004','光环5','300');
INSERT INTO goods       VALUES('02','m10004','古墓丽影','300');
INSERT INTO goods       VALUES('03','m10004','极限竞速','300');
INSERT INTO goods       VALUES('04','m10004','泰坦陨落','300');

INSERT INTO goods       VALUES('01','m10005','落日霞辉','10');
INSERT INTO goods       VALUES('02','m10005','提神海水','10');
INSERT INTO goods       VALUES('03','m10005','彼岸花','10');
INSERT INTO goods       VALUES('04','m10005','去深圳船票','70');

INSERT INTO goods       VALUES('01','m10006','魔方99999','99');
INSERT INTO goods       VALUES('02','m10006','回城卷轴','5');

INSERT INTO customer    VALUES('c20002','剁手狂魔','SYSU Zhuhai R14','+8618888888888','666@qq.com');
INSERT INTO customer    VALUES('c20003','毛毛细雨','SYSU Zhuhai L9','+8613014248652','itakeawayDB@e.me');

INSERT INTO deliveryman VALUES('d30002','送得快','+8618012454222');
INSERT INTO deliveryman VALUES('d30003','包装好','+8613312455555');
INSERT INTO deliveryman VALUES('d30004','态度好','+8616645213363');

INSERT INTO Torder      VALUES('t40002','m10001','c20002','d30001','06','20180522_220050','ok');
INSERT INTO Torder      VALUES('t40003','m10002','c20002','d30003','04','20180522_220115','ok');
INSERT INTO Torder      VALUES('t40004','m10004','c20002','d30002','04','20180522_220120','ok');
INSERT INTO Torder      VALUES('t40005','m10003','c20003','d30004','03','20180522_220122','ok');
INSERT INTO Torder      VALUES('t40006','m10005','c20003','d30002','02','20180522_220125','cancel');
INSERT INTO Torder      VALUES('t40007','m10003','c20002','d30002','04','20180522_220127','delivering');
INSERT INTO Torder      VALUES('t40008','m10006','c20002','d30004','01','20180522_220129','unpaid');
INSERT INTO Torder      VALUES('t40009','m10002','c20002','d30003','02','20180522_220133','ok');
INSERT INTO Torder      VALUES('t40010','m10003','c20002','d30001','03','20180522_220134','invalid');
INSERT INTO Torder      VALUES('t40011','m10001','c20001','d30001','07','20180522_220138','invalid');

ALTER TABLE goods
    ADD CONSTRAINT C1 CHECK(Gprice BETWEEN 0 AND 500);

CREATE ROLE MCH; /*merchant*/

GRANT SELECT
ON merchant
TO PUBLIC; /*商家信息所有人可查*/

GRANT SELECT,UPDATE
ON merchant
TO MCH;

GRANT SELECT,UPDATE,INSERT,DELETE
ON goods
TO MCH;

GRANT SELECT,UPDATE,INSERT,DELETE
ON Torder
TO MCH;

REVOKE UPDATE(Mno)
ON goods
TO MCH; /*商家不能更改商品表中的商家号*/

CREATE LOGIN m10001 WITH PASSWORD = '123456' ;
CREATE USER m10001 FOR LOGIN m10001 WITH DEFAULT_SCHEMA=dbo;

CREATE LOGIN m10002 WITH PASSWORD = '123456' ;
CREATE USER m10002 FOR LOGIN m10002 WITH DEFAULT_SCHEMA=dbo;

CREATE LOGIN m10003 WITH PASSWORD = '123456' ;
CREATE USER m10003 FOR LOGIN m10003 WITH DEFAULT_SCHEMA=dbo;

CREATE LOGIN m10004 WITH PASSWORD = '123456' ;
CREATE USER m10004 FOR LOGIN m10004 WITH DEFAULT_SCHEMA=dbo;

CREATE LOGIN m10005 WITH PASSWORD = '123456' ;
CREATE USER m10005 FOR LOGIN m10005 WITH DEFAULT_SCHEMA=dbo;

CREATE LOGIN m10006 WITH PASSWORD = '123456' ;
CREATE USER m10006 FOR LOGIN m10006 WITH DEFAULT_SCHEMA=dbo;

exec sp_addrolemember 'MCH','m10001';
exec sp_addrolemember 'MCH','m10002';
exec sp_addrolemember 'MCH','m10003';
exec sp_addrolemember 'MCH','m10004';
exec sp_addrolemember 'MCH','m10005';
exec sp_addrolemember 'MCH','m10006';