#【作业 1】
-- 1. 定义存储过程：对库存数量大于 50 的商品进行优惠，优惠金额=7 折，优惠时间=从今天开始优惠 3 天，修改后查询参与优惠的商品
-- 2. 无参数无返回类型
USE orderdb;DROP PROCEDURE IF EXISTS pro_no1;
DELIMITER $$
CREATE PROCEDURE pro_no1()
BEGIN
	UPDATE products SET ProNewPrice=ProOldPrice*0.7,ProSaleBegin=NOW(),ProSaleEnd=ADDDATE(NOW(),3)WHERE prodepot>50;
END$$
CALL pro_no1();	
SELECT * FROM products;

#【作业 2】
-- 1. 定义存储过程: 给指定客户进行奖励，在指定月份的商品评价给客户赠送积分=评价数*100，非指定月份=评价数*50
-- 2. 参数：客户编号，月份
-- 3. 无返回类型
USE orderdb;DROP PROCEDURE IF EXISTS pro_no2;
DELIMITER $$
CREATE PROCEDURE pro_no2(IN ncid INT,IN nm INT)
BEGIN
	DECLARE ncp INT;
	DECLARE ncps INT;	
	SELECT COUNT(*) INTO ncp FROM assess WHERE MONTH(AssDate)=nm AND cusid = ncid;
	SELECT COUNT(*) INTO ncps FROM assess WHERE MONTH(AssDate)=nm AND cusid =  ncid;
	UPDATE customers SET CusPoint= ncp*100+CusPoint+ncps*50 WHERE cusid=ncid;
END$$
CALL pro_no2(7,11);
SELECT * FROM customers;

#【作业 3】
-- 1. 定义存储过程，对指定月份订单数大于等于3 的客户+500积分，订单数小于3的客户+100积分
-- 2. 参数：月份
-- 3. 无返回类型
USE orderdb;DROP PROCEDURE IF EXISTS pro_no3;
DELIMITER $$
CREATE PROCEDURE pro_no3(IN nm INT)
BEGIN
	UPDATE customers SET cuspoint = cuspoint+500 WHERE cusid IN (
	SELECT cusid FROM orders WHERE MONTH(orderdate)=nm GROUP BY cusid HAVING COUNT(*)>=3);
	UPDATE customers SET cuspoint = cuspoint+100 WHERE cusid IN(
	SELECT cusid FROM orders WHERE MONTH(orderdate)=nm GROUP BY cusid HAVING COUNT(*)<3);
	SELECT cusnick,cuspoint FROM customers;
END $$
CALL pro_no3(11);
SELECT * FROM customers;

#【作业 4】
-- 1. 定义存储过程：在指定月份评价最多的客户奖励 100 积分，并返回修改后的积分和客户姓名
-- 2. 参数：月份
-- 3. 返回类型：积分，客户姓名
USE orderdb;DROP PROCEDURE IF EXISTS pro_no4;
DELIMITER $$
CREATE PROCEDURE pro_no4(IN nm INT,OUT npt INT,OUT nname VARCHAR(50))
BEGIN
	DECLARE ncid INT;
	SELECT cusid INTO ncid FROM assess WHERE MONTH(AssDate)=nm GROUP BY cusid ORDER BY COUNT(*) DESC LIMIT 1;
	UPDATE customers SET cuspoint=cuspoint+100 WHERE cusid = ncid;
	SELECT cuspoint INTO npt FROM customers WHERE CusID = ncid;
	SELECT CusNick INTO nname FROM customers WHERE CusID = ncid;		
END $$
SET @npts = 0;
SET @names = '';
CALL pro_no4(1,@npts,@names);
SELECT @names,@npts;

#【作业 5】
-- 定义存储过程：重新计算客户积分，规则=客户购物总金额*1+评价数量*10 ，无参数无返回类型
USE orderdB;DROP PROCEDURE IF EXISTS pro_no5;
DELIMITER $$
CREATE PROCEDURE pro_no5()
BEGIN 
	UPDATE customers SET cuspoint = 
	(SELECT SUM(odcount*odprice)FROM
END $$
CALL pro_no5();

#【作业 6】
-- 定义存储：实现评论信息添加
-- 1. 参数：客户编号，商品编号，评价内容
-- 2. 返回参数：客户最新积分
-- 3. 要求：
	#a) 实现评价信息添加
	#b) 实现客户积分+10
	#c) 添加事务处理
USE orderdb;DROP PROCEDURE IF EXISTS pro_no6;
DELIMITER $$
CREATE PROCEDURE pro_no6(IN ncid INT,IN npid INT,IN nasa VARCHAR(2000),OUT cpt INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;
	START TRANSACTION;
	INSERT INTO assess VALUES(NULL,ncid,npid,nasa,DEFAULT);
	UPDATE customers SET CusPoint=cuspoint+10 WHERE cusid=ncid;
	SELECT CusPoint INTO cpt FROM customers WHERE cusid = ncid;
	COMMIT;
END $$
SET @ncpt = 0;
CALL pro_no6(1,2,'萨基丹麦芬兰的矿山救护队吧v甲壳虫v吧',@ncpt);