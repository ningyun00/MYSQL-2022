-- 【上机作业】#导入数据库

#使用数据库
USE orderdb;

-- 1. 查询商品类别’笔记本’的所有商品
SELECT TypeID FROM protypes WHERE TypeName = '笔记本';
SELECT * FROM products WHERE typeid = 
	(SELECT TypeID FROM protypes WHERE TypeName = '笔记本');
	
-- 2. 查询商品名包含‘i5’的商品并查询与此商品同类型的商品
SELECT TypeID FROM products WHERE ProName LIKE '%i5%';
SELECT * FROM products WHERE TypeID = 
	(SELECT TypeID FROM products WHERE ProName LIKE '%i5%');

-- 3. 查询客户昵称为‘雪人骑士’的所有评论信息
SELECT CusID FROM customers WHERE CusNick = '雪人骑士';
SELECT * FROM assess WHERE CusID = 
	(SELECT CusID FROM customers WHERE CusNick = '雪人骑士');
	
-- 4. 查询积分大于 5000 的用户的评价信息
SELECT cusid FROM customers WHERE cuspoint>5000;
SELECT cusid,AssContent FROM assess WHERE cusid IN 
	(SELECT cusid FROM customers WHERE cuspoint>5000);

-- 5. 查询积分最高的用户的所有评论
SELECT cusid FROM customers ORDER BY CusPoint DESC LIMIT 1;
SELECT * FROM assess WHERE cusid =
	(SELECT cusid FROM customers ORDER BY CusPoint DESC LIMIT 1);

-- 6. 查询积分最高的用户购买的所有商品及商品信息
SELECT cusid FROM customers ORDER BY CusPoint DESC LIMIT 1;
SELECT OrderNum FROM orders WHERE cusid = 
	(SELECT cusid FROM customers ORDER BY CusPoint DESC LIMIT 1);
SELECT proid FROM orderdetail WHERE OrderNum IN 
	(SELECT OrderNum FROM orders WHERE cusid = 
		(SELECT cusid FROM customers ORDER BY CusPoint DESC LIMIT 1));
SELECT * FROM products WHERE proid IN 
	(SELECT proid FROM orderdetail WHERE OrderNum IN 
		(SELECT OrderNum FROM orders WHERE cusid = 
			(SELECT cusid FROM customers ORDER BY CusPoint DESC LIMIT 1)));

-- 7. 查询没有产生过订单的客户信息
SELECT cusid FROM orders;
SELECT * FROM customers WHERE cusid NOT IN 
	(SELECT cusid FROM orders);
	
-- 8. 查询没有发布过评价的客户信息
SELECT cusid FROM assess;
SELECT * FROM customers WHERE cusid NOT IN 
	(SELECT cusid FROM assess);
	
-- 9. 查询默认地址为湖南客户购买的所有商品，显示客户信息和商品信息，购买数量及价格
SELECT * FROM cusadds WHERE CADefault = 0 AND CAProvince = '湖南';
SELECT * FROM orders WHERE cusid IN
	(SELECT cusid FROM cusadds WHERE CADefault = 0 AND CAProvince = '湖南');
SELECT proid FROM orderdetail WHERE OrderNum IN 
	(SELECT OrderNum FROM orders WHERE cusid IN
		(SELECT cusid FROM cusadds WHERE CADefault = 0 AND CAProvince = '湖南'));
SELECT CusNick,ProName,ODCount FROM orderdetail 
INNER JOIN orders ON orderdetail.`OrderNum`=orders.`OrderNum`
INNER JOIN customers ON customers.`CusID`=orders.`CusID`
INNER JOIN products ON products.`ProID` = orderdetail.`ProID`
WHERE orderdetail.proid IN 
(SELECT proid FROM orderdetail WHERE OrderNum IN 
	(SELECT OrderNum FROM orders WHERE cusid IN
		(SELECT cusid FROM cusadds WHERE CADefault = 0 AND CAProvince = '湖南')));

-- 10. 查询评价数最高的商品所产生的订单信息
SELECT proid FROM assess GROUP BY ProID ORDER BY  COUNT(proid) DESC LIMIT 1;
SELECT * FROM products WHERE proid = 
	(SELECT proid FROM assess GROUP BY ProID ORDER BY  COUNT(proid) DESC LIMIT 1);

#地址表
SELECT * FROM cusadds;
	
#订单表
SELECT * FROM orderdetail;

#订单编号表
SELECT * FROM orders;

#评论表
SELECT * FROM assess;

#客户表
SELECT * FROM customers;

#商品类别表
SELECT * FROM protypes;

#商品表
SELECT * FROM products;

-- 【课后作业】#导入数据
#创建数据库
DROP DATABASE IF EXISTS SararyDB;
CREATE DATABASE SararyDB CHARACTER SET utf8;

#使用数据库
USE SararyDB;

(-- 部门表
DROP TABLE IF EXISTS dept;
CREATE TABLE dept
(
      DeptNo INT PRIMARY KEY,
      Dname  VARCHAR(15) NOT NULL,
      Location VARCHAR(100) NOT NULL
);
INSERT INTO dept VALUES(10,'会计部','纽约');
INSERT INTO dept VALUES(20,'调查部','达拉斯');
INSERT INTO dept VALUES(30,'销售部','芝加哥');
INSERT INTO dept VALUES(40,'业务营运部','波士顿');

-- 员工表
DROP TABLE IF EXISTS emp;
CREATE TABLE emp
(
   EmpNo INT PRIMARY KEY,
   Ename VARCHAR(40),
   Job   VARCHAR(40),
   MGR  INT,
   HIREDATE  DATETIME,
   Sal  DECIMAL(6,2),
   DeptNo  INT
);

INSERT INTO Emp VALUES(7369,'SMITH',   '职员',7902, '1980-12-27',800 ,20);
INSERT INTO Emp VALUES(7499,'ALLEN',   '销售',7698, '1981-2-20',1600 ,30);
INSERT INTO Emp VALUES(7521,  'WARD'  , '销售',7698,'1981-2-22' , 1250,30);
INSERT INTO Emp VALUES(7566 , 'JONES' ,'经理' , 7839 ,'1981-4-22',  2975,20);
INSERT INTO Emp VALUES(7782, 'CLARK' ,'经理' , 7839, '1981-6-9',2450,10);
INSERT INTO Emp VALUES(7698 , 'BLAKE' ,'经理',  7839, '1981-05-8' ,2850,30);
INSERT INTO emp VALUES(7902 , 'FORD' , '研究员' , 7566 ,'1981-12-3' ,3000,20);
INSERT INTO Emp VALUES(7934,  'MILLER', '职员' ,   7782,  '1982-1-31', 1300 ,40);
)

-- 1. 查询员工的姓名和员工部门名称
SELECT deptno FROM dept;
SELECT ename,dname FROM emp 
	INNER JOIN dept ON emp.deptno=dept.deptno 
		WHERE emp.deptno IN (SELECT deptno FROM dept);
		
-- 2. 查询每个员工所在的部门和部门所在的地区
	#a) 使用连接查询
SELECT ename,dname,location FROM emp 
	INNER JOIN dept ON emp.deptno=dept.deptno 
	#b) 使用子查询
SELECT deptno FROM emp;
SELECT * FROM dept WHERE deptno IN (SELECT deptno FROM emp);

-- 3. 统计各部门平均工资
SELECT deptno FROM dept;
SELECT deptno,AVG(sal) FROM emp WHERE deptno IN (SELECT deptno FROM dept) GROUP BY deptno;

-- 4. 查询SMITH上级领导的姓名，提示使用子查询
SELECT empno FROM emp WHERE ename = 'smith';
SELECT * FROM emp WHERE empno = (SELECT empno FROM emp WHERE ename = 'smith');

-- 5. 查询工资高于JONES的员工的姓名和工资情况
SELECT sal FROM emp WHERE ename = 'jones';
SELECT * FROM emp WHERE sal > (SELECT sal FROM emp WHERE ename = 'jones');

-- 6. 查询和ALLEN不在同一部门的员工的姓名和所在部门名称
SELECT deptno FROM emp WHERE ename = 'allen';
SELECT deptno,ename FROM emp WHERE deptno =(SELECT deptno FROM emp WHERE ename = 'allen');

-- 7. 查询工资高于1500并且在30号部门工作的员工号，员工名，工资；
SELECT empno,ename,sal FROM emp WHERE sal>1500 AND deptno>30;

-- 8. 查询员工信息，按照员工的部门号升序排列，同部门的再按员工工资降序排列；
SELECT * FROM emp ORDER BY deptno ASC,sal DESC;

-- 9. 查工资不超过2000的员工信息。
SELECT * FROM emp WHERE sal< 2000;

-- 10. 查出工资比平均工资低的员工信息。
SELECT * FROM emp HAVING sal<AVG(sal);

-- 11. 查出名字为“CLARK”的工资，生日、部门编号，地址
SELECT sal,ename,emp.deptno,location FROM emp INNER JOIN dept ON emp.deptno=dept.deptno WHERE ename = 'clark';

#部门表
SELECT * FROM dept;

#员工表
SELECT * FROM emp;