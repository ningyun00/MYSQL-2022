#创建数据库
CREATE DATABASE mydb CHARACTER SET utf8;
#查看数据库
SHOW CREATE DATABASE mydb;
#使用数据库
USE mydb;
#创建表
CREATE TABLE student
(
SID/*学生编号*/INT/*数据类型int*/NOT NULL/*非空*/PRIMARY KEY/*主键*/AUTO_INCREMENT/*自动增长*/,
SName/*学生姓名*/VARCHAR(10)/*数据类型varchar长度15*/NOT NULL/*非空*/,
SSex/*学生性别*/NCHAR(1)/*长度*/,
SAge/*学生年龄*/INT,
SAddress/*联系地址*/VARCHAR(200)/*长度*/DEFAULT '地址不详'
);
#查询表
SELECT * FROM student
#添加数据
INSERT INTO student VALUES(NULL,'寜','男',16,DEFAULT);
INSERT INTO student VALUES(NULL,'小','女',17,DEFAULT);
INSERT INTO student VALUES(NULL,'寜','男',18,DEFAULT);
INSERT INTO student VALUES(NULL,'寜','女',19,'地球');
#创建表
CREATE DATABASE TestDB CHARACTER SET utf8;
