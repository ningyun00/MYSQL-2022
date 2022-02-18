#【作业 1】视图
-- 1. 为商品表创建视图，查询商品信息和类别名称
USE orderdb;DROP VIEW IF EXISTS view_pro;
CREATE VIEW view_pro AS
SELECT ProName,protypes.TypeName FROM products INNER JOIN protypes ON products.typeid=protypes.TypeID;
SELECT * FROM view_pro;

-- 2. 为评价表创建视图，查询评价信息和客户昵称，商品名称
USE orderdb;DROP VIEW IF EXISTS view_ass;
CREATE VIEW view_ass AS 
SELECT customers.CusNick,assess.AssContent,ProName FROM customers INNER JOIN assess ON customers.CusID=assess.CusID INNER JOIN products ON assess.ProID=products.ProID;
SELECT * FROM view_ass;

-- 3. 为订单表创建视图，查询订单信息，地址信息，客户昵称
USE orderdb;DROP VIEW IF EXISTS view_ot;
CREATE VIEW view_ot AS
SELECT OrderNum,CAProvince,CACity,CAAddress,CusNick FROM orders INNER JOIN customers ON orders.CusID=customers.CusID INNER JOIN  cusadds ON customers.CusID=cusadds.CusID;
SELECT * FROM view_ot;

-- 4. 为地址表创建视图，查询地址信息和客户昵称
USE orderdb;DROP VIEW IF EXISTS view_dizhi;
CREATE VIEW view_dizhi AS
SELECT CusNick,CAProvince,CACity,CAAddress FROM cusadds INNER JOIN customers ON cusadds.CusID=customers.CusID;
SELECT * FROM view_dizhi;

-- 5. 为订单详单表创建视图，查询订单详单信息和商品名称，类别名称
USE orderdb;DROP VIEW IF EXISTS view_dingdan;
CREATE VIEW view_dingdan AS
SELECT ProName,TypeName FROM orderdetail INNER JOIN orders ON orderdetail.OrderNum = orders.OrderNum INNER JOIN products ON orderdetail.ProID = products.ProID INNER JOIN protypes ON products.TypeID = protypes.TypeID;
SELECT* FROM view_dingdan;

#【作业 2】
-- 1. 执行”索引测试.txt”中的代码测试索引效率
DROP TABLE IF EXISTS Test;
CREATE TABLE Test
(
	TNum INT
);
/*
  存储过程 复制此段代码在查询中运行一下就会生成一个存储过程
*/
CREATE PROCEDURE my_Insert()
BEGIN
	DECLARE nindex INT DEFAULT 0;
	WHILE(nindex<100000) DO
		INSERT INTO Test VALUES(nindex);
		SET nindex=nindex+1;
	END WHILE;
END;

 --  调用存储过程
 CALL my_insert();

 -- 没有建立索引之前进行一次查询  注意查询的时间
 SELECT *  FROM Test WHERE tnum=50000;

 -- 建立索引
 CREATE INDEX index_Test ON Test(TNum);


 -- 建立了索引后的查询  注意查询的时间 对比一下2种查询的时间
 SELECT *  FROM Test WHERE tnum=50000;
-- 2. 为订单表的订单时间创建索