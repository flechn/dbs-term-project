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
    Mno      CHAR(10)  PRIMARY KEY,       /*�̼Һţ�merchant number��*/
	Sname    CHAR(10)  UNIQUE NOT NULL,   /*������store name��*/
	Mname    CHAR(10)  NOT NULL,          /*��������merchant name��*/
	Maddr    CHAR(20)  UNIQUE NOT NULL,   /*��ַ��merchant address��*/
	Mtel     CHAR(20)  UNIQUE NOT NULL,   /*��ϵ��ʽ��merchant telephone��*/
	Mtime    CHAR(20),                    /*Ӫҵʱ�䣨merchant time��*/
	Mcont    CHAR(20))                    /*��Ӫ���ݣ�merchant content��*/

CREATE TABLE goods(
    Gno      CHAR(10),                    /*��Ʒ�ţ�goods number��*/
	Mno      CHAR(10),                    /*�̼Һţ�merchant number��*/
	Gname    CHAR(10)  NOT NULL,          /*��Ʒ����goods name��*/
	Gprice   FLOAT     NOT NULL,          /*��Ʒ�۸�goods price��*/
	PRIMARY KEY(Gno, Mno),
	FOREIGN KEY(Mno) REFERENCES merchant(Mno))

CREATE TABLE customer(
    Cno      CHAR(10)  PRIMARY KEY,       /*�˿ͺţ�customer number��*/
	Cname    CHAR(10)  NOT NULL,          /*�˿�����customer name��*/
	Caddr    CHAR(20)  NOT NULL,          /*�ջ���ַ��customer address��*/
	Ctel     CHAR(20)  UNIQUE NOT NULL,   /*��ϵ��ʽ��customer telephone��*/
	Cmail    CHAR(20)  UNIQUE)            /*���䣨customer mailbox��*/

CREATE TABLE deliveryman(
    Dno      CHAR(10)  PRIMARY KEY,       /*���ֺţ�deliveryman number��*/
	Dname    CHAR(10)  NOT NULL,          /*��������deliveryman name��*/
	Dtel     CHAR(20)  UNIQUE NOT NULL)   /*��ϵ��ʽ��deliveryman telephone��*/

create table Torder(
    Tno      CHAR(30),                    /*������*/
	Mno      CHAR(10),                    /*�̼Һţ�merchant number��*/
	Cno      CHAR(10),                    /*�˿ͺţ�customer number��*/
	Dno      CHAR(10),                    /*���ֺţ�deliveryman number��*/
    Gno      CHAR(10),                    /*��Ʒ�ţ�goods number��*/
	Ttime    CHAR(20),                    /*�µ�ʱ��*/
	Tstat    CHAR(20),                    /*����״̬*/
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

/*һ���������*/
INSERT INTO merchant    VALUES('m10001','Steam','GFat','America','+110086',null,null);
INSERT INTO goods       VALUES('01','m10001','Ori','64');
INSERT INTO customer    VALUES('c20001','Snivy��','SYSU Zhuhai L11','+8610086','f@l.e');
INSERT INTO deliveryman VALUES('d30001','������','+8610000');
INSERT INTO Torder      VALUES('t40001','m10001','c20001','d30001','01','20180521_215003','invalid');

/*Ԥ��¼�������*/
INSERT INTO merchant    VALUES('m10002','Nintendo','GF','Alola','+8110086','Weekday','ns');
INSERT INTO merchant    VALUES('m10003','Sony','Yoshida','Tokyo','+8110010','8:00-24:00','ps4');
INSERT INTO merchant    VALUES('m10004','Ms','Bill Gates','USA','+110010','24h','OS');
INSERT INTO merchant    VALUES('m10005','������¥','���ϰ�','���鱱����ת������','+110000','������ʱ','���ֶ���');
INSERT INTO merchant    VALUES('m10006','ð�յ�','��������','��֪��������DNS�ɡ�','+1110','24h','�黳');

INSERT INTO goods       VALUES('02','m10001','��֮��','68');
INSERT INTO goods       VALUES('03','m10001','Rainbow6','99');
INSERT INTO goods       VALUES('04','m10001','TotheMoon','36');
INSERT INTO goods       VALUES('05','m10001','Bastion','28');
INSERT INTO goods       VALUES('06','m10001','����������','78');
INSERT INTO goods       VALUES('07','m10001','��ɫ����','78');

INSERT INTO goods       VALUES('01','m10002','PokemonEP','200');
INSERT INTO goods       VALUES('02','m10002','PokemonAG','200');
INSERT INTO goods       VALUES('03','m10002','PokemonDP','200');
INSERT INTO goods       VALUES('04','m10002','PokemonBW','200');
INSERT INTO goods       VALUES('05','m10002','PokemonXY','200');
INSERT INTO goods       VALUES('06','m10002','PokemonSM','200');

INSERT INTO goods       VALUES('01','m10003','��������','220');
INSERT INTO goods       VALUES('02','m10003','���ջ���','220');
INSERT INTO goods       VALUES('03','m10003','��������˫','220');
INSERT INTO goods       VALUES('04','m10003','�Ͻ�װ��','220');

INSERT INTO goods       VALUES('01','m10004','�⻷5','300');
INSERT INTO goods       VALUES('02','m10004','��Ĺ��Ӱ','300');
INSERT INTO goods       VALUES('03','m10004','���޾���','300');
INSERT INTO goods       VALUES('04','m10004','̩̹����','300');

INSERT INTO goods       VALUES('01','m10005','����ϼ��','10');
INSERT INTO goods       VALUES('02','m10005','����ˮ','10');
INSERT INTO goods       VALUES('03','m10005','�˰���','10');
INSERT INTO goods       VALUES('04','m10005','ȥ���ڴ�Ʊ','70');

INSERT INTO goods       VALUES('01','m10006','ħ��99999','99');
INSERT INTO goods       VALUES('02','m10006','�سǾ���','5');

INSERT INTO customer    VALUES('c20002','���ֿ�ħ','SYSU Zhuhai R14','+8618888888888','666@qq.com');
INSERT INTO customer    VALUES('c20003','ëëϸ��','SYSU Zhuhai L9','+8613014248652','itakeawayDB@e.me');

INSERT INTO deliveryman VALUES('d30002','�͵ÿ�','+8618012454222');
INSERT INTO deliveryman VALUES('d30003','��װ��','+8613312455555');
INSERT INTO deliveryman VALUES('d30004','̬�Ⱥ�','+8616645213363');

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
TO PUBLIC; /*�̼���Ϣ�����˿ɲ�*/

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
TO MCH; /*�̼Ҳ��ܸ�����Ʒ���е��̼Һ�*/

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