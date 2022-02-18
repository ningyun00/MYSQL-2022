【作业 1】使用“orderDB”数据库
USE orderdb;

-- 1. 定义函数 GetAssess：根据客户编号查询此客户的评价数，并返回评价数
	#a) 参数：客户编号	select * from customers;	
	#b) 返回：评价数量	select * from assess;	
DROP FUNCTION IF EXISTS fn_GetAssess;
DELIMITER $$
CREATE FUNCTION fn_GetAssess(ncusid INT) RETURNS VARCHAR(5000)
BEGIN 
	SELECT COUNT(AssContent) INTO @several/*几条*/ FROM assess WHERE cusid = ncusid;
	IF @several=1 THEN 
		SELECT AssContent INTO @nasscontent FROM assess WHERE cusid = ncusid;		
	ELSE 
		SELECT GROUP_CONCAT(AssContent) INTO @nasscontent FROM assess WHERE cusid = ncusid;
	END IF;
		RETURN @nasscontent;
END $$

-- 2. 调用函数输出结果
SELECT fn_GetAssess(2);

#【作业 2】
-- 1. 定义函数 SetPoint：根据客户 ID 查询订单数，如果在本月产生了 2 笔或以上的订单，则奖励积分（用户积分累加），奖励积分=订单数*10
	#a) 参数：客户编号 select * from customers;
	#b) 返回：累加后的客户积分 
DROP FUNCTION IF EXISTS fn_setpoint;
DELIMITER $$
CREATE FUNCTION fn_setpoint(ncusid INT) RETURNS INT
BEGIN 
	SELECT COUNT(ordernum) INTO @several FROM orders WHERE cusid = ncusid;
	IF @several>=2 THEN 
		UPDATE	customers SET cuspoint=(cuspoint+@several*10) WHERE cusid=ncusid;
		SELECT cuspoint INTO @ncuspoint FROM customers WHERE cusid=ncusid;
	ELSE 
		SELECT cuspoint INTO @ncuspoint FROM customers WHERE cusid=ncusid;
	END IF;	
	RETURN @ncuspoint;
END $$

-- 2. 调用函数输出结果
SELECT fn_setpoint(2);

#【作业 3】
-- 查询客户表，显示客户信息，额外显示等级列，要求：
	#1000 分以下：普通会员 1000-5000 分：黄金会员 5000-10000：白金会员 10000 以上：钻石会员
SELECT *,
	CASE 
		WHEN CusPoint < 1000 THEN '普通会员' 
		WHEN CusPoint >= 1000 THEN '黄金会员'
		WHEN CusPoint >= 5000 THEN '白金会员'
		WHEN CusPoint >= 10000 THEN '钻石会员'
	END AS '会员等级' FROM customers; 
	
#【作业 4】
-- 1. 定义函数 WhileTest1，从 1 开始循环到指定的数值，累加 3 倍数的值，并返回
	#a) 参数：循环范围，例如传入 100，则从 1 循环到 100
	#b) 返回：返回累加后的值（只累加 3 倍数的值）
DROP FUNCTION IF EXISTS fn_whilethstl1;
DELIMITER $$
CREATE FUNCTION fn_whilethst1(number INT)RETURNS INT
BEGIN 
	DECLARE i INT DEFAULT 0;
	DECLARE sums INT DEFAULT 0;		
    dap:WHILE i< number DO
		SET i=i+1;
		IF i%3=0 THEN	
			SET sums=sums+i;
		END IF;	
		IF i%3!=0 THEN	
			ITERATE dap;
		END IF;			
	END WHILE;
	RETURN sums;
END $$

-- 2. 调用函数输出结果
SELECT fn_whilethst1(10);


#【作业 5】
-- 1. 定义函数 WhileTest2
	#a) 参数：数值 1，数值 2
	#b) 返回：累加结果
	#c) 功能：从 1 循环到 100 并进行累加，循环过程中遇到数值 1 的倍数时，不累加，遇到数值 1 的数值 2 的倍数时，结束循环。例如传入参数 3,6；表示从 1 累加到 100，与到 3 倍数的数时不累加，遇到 3*6=18 时，结束循环
DROP FUNCTION IF EXISTS fn_whileTest2;
DELIMITER $$
CREATE FUNCTION fn_whileTest2(A INT,B INT)RETURNS INT
BEGIN 
	DECLARE i INT DEFAULT 0;
	DECLARE sums INT DEFAULT 0;
    dep:WHILE i < 100 DO 
		SET i=i+1;

		IF A*B=i THEN
			LEAVE dep;
		END IF;
		
		IF i%A=0 THEN
			ITERATE dep;
		END IF;		
		SET sums=sums+i;		
	END WHILE;	
	RETURN sums;
END $$
-- 2. 调用函数输出结果
SELECT fn_whileTest2(3,6);

#【作业 6】
-- 1. 定义函数 whileTest3
	#a) 无参数(每次加多少积分)
	#b) 返回：积分最高的客户 ID
	#c) 要求：循环给所有用户每次加 100 积分，直到有用户的积分超过 10000 分则停止循环
DROP FUNCTION IF EXISTS fn_whileTest3;
DELIMITER $$
CREATE FUNCTION fn_whileTest3(A INT)RETURNS INT
BEGIN 
	DECLARE nlines INT DEFAULT 0;
    dep:WHILE 1=1 DO
		UPDATE customers SET CusPoint = cuspoint+A;
		SELECT COUNT(*)INTO nlines FROM customers WHERE cuspoint > 10000;
		IF nlines>0 THEN
			LEAVE dep;
		END IF;
	END WHILE;
	RETURN nlines;
END $$
-- 2. 调用函数输出结果
SELECT fn_whileTest3(100);
#【作业 7】
-- 1. 定义函数计算商品优惠后的价格
	#a) 参数：商品 ID，购买数量，优惠类型
	#b) 返回商品优惠的价格
-- 2. 说明:
	#a) 根据商品 ID 查询商品售价
	#b) 如果优惠类型=1，表示 8 折优惠
	#c) 如果优惠类型=2，表示满 100 优惠 10 元，例如商品总价格（价格*数量）=423 元，那么优惠 40 元，优惠后的金额=383
	#d) 如果优惠类型=3，表示第二件半价，例如商品价格=30 元，购买数量=5，那么 3 个商品按照原价，2 件商品半价，优惠后的金额=3*30+2*15=120，如果购买 1 个则没有优惠
DROP FUNCTION IF EXISTS fn_whileTest4;
DELIMITER $$
CREATE FUNCTION fn_whileTest4(pid INT,pnumber INT,ptype INT)RETURNS INT
BEGIN 
	DECLARE money DECIMAL(10,2);
	DECLARE newmoney DECIMAL(10,2);		
	SELECT ProNewPrice INTO newmoney FROM products WHERE ProID = pid;
	SET money= newmoney*pnumber;
	IF ptype=1 THEN
		SET money=money*0.8;
	ELSEIF ptype=2 THEN
		IF money>100 THEN 
			SET money=money-FLOOR(money/100*10);
		END IF;
	ELSEIF ptype=3 THEN
		IF pnumber>=2 THEN
			SET money = (CEIL(pnumber/2)*newmoney)+(FLOOR(pnumber/2)*(newmoney/2));
		END IF;
	END IF;
	RETURN money;
END $$

SELECT fn_whileTest4(8,2,3);

#【作业 8】使用“testDB.sql”中的脚步创建数据表
CREATE DATABASE testdb;-- 创建数据库
-- 使用 SQL 实现如下查询效果
USE testdb;
-- 1. 效果 1（Test1 表）
SELECT sno,
	SUM(
		CASE 
			WHEN smoney>0 THEN smoney
			ELSE 0
		END
	) AS 收入,
	SUM(
		CASE 
			WHEN smoney<0 THEN smoney 
			ELSE 0
		END
	) AS 支出 FROM test1 
GROUP BY sno;

-- 2. 效果 2（Teams 表）
USE testdb; SELECT teamname AS 球队,SUM(teamResult='胜')AS 胜,SUM(teamresult='败')AS 败 FROM teams GROUP BY teamname;

-- 3. 效果 3（Sales 表)
SELECT syear,
	SUM(
		CASE 
			WHEN squarter=1 THEN samount
			ELSE 0			
		END
	)AS 第一季度,
	SUM(
		CASE 
			WHEN squarter=2 THEN samount	
			ELSE 0		
		END
	)AS 第二季度,
	SUM(
		CASE 
			WHEN squarter=3 THEN samount
			ELSE 0			
		END
	)AS 第三季度,
	SUM(
		CASE 
			WHEN squarter=4 THEN samount
			ELSE 0			
		END
	)AS 第四季度
FROM sales 
GROUP BY syear;

#【思考题：】--试着做，第二天讲解
-- 1. 定义函数生成订单编号
	#a) 无参数
	#b) 返回生成后的订单编号
-- 2. 说明：订单编号规则说明：由 3 个部分组成，第一部分=SS（固定内容），第二部分=YYYYMMDD（当前时间的年月日，例如 20160101），第三部分为当天的编码，从 0001 开始累加，第二天开始重新从 0001 开始计算
	#实现步骤：
	#a) 使用 DATE_FORMAT 获取当前时间的 YYYYMMDD 格式，查询以 SSYYYYMMDD 开头的记录，如果没有记录则生成的编号=SSYYYYMMDD0001
	#b) 如果查询出数据，则查询以 SSYYYYMMDD 开头的最大订单编号
	#c) 截取订单编号的最后 4 位转化为 INT 类型+10001转化为字符串截取后四位与 SSYYYYMMDD 拼接例如查询出的今天最大编号为：’201601010015’截取后 4 位=’0015’转化为 INT 类型=15+10001=10016转化为字符串=’10016’截取后 4 位=’0016’与’SS20160101’进行拼接=’ SS201601010016
DROP FUNCTION IF EXISTS fn_sikaoti;
DELIMITER $$
CREATE FUNCTION fn_sikaoti()RETURNS VARCHAR(14)
BEGIN
	DECLARE norderNum VARCHAR(14);
	DECLARE maxNum CHAR(14);
	-- 拼接固定的ss+今天的日期
	SET norderNum=CONCAT('ss',DATE_FORMAT(NOW(),'%Y%m%d'));
	-- 查找今天的最大订单
	SELECT MAX(OrderNum) INTO maxNum  FROM orders WHERE DATE_FORMAT(OrderDate,'%Y%m%d')=DATE_FORMAT(NOW(),'%Y%m%d');
	
	IF maxNum IS NULL THEN
		-- 今天没有订单
		SET norderNum=CONCAT(norderNum,'0001');
	ELSE	
		-- 今天有订单
		SET norderNum=CONCAT(norderNum, RIGHT(RIGHT(maxNum,4)+10001,4));
	END IF;
	RETURN norderNum;	
END; $$
SELECT fn_sikaoti();