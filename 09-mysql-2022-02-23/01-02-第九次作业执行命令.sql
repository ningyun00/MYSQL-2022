#【作业 1】
-- 为评价表添加 insert 触发器，要求输入的内容最少有 5 个字符，少于 5 个字符时插入失败
USE orderdb;DROP TRIGGER IF EXISTS t_assess_insert;
DELIMITER $$
CREATE TRIGGER t_assess_insert BEFORE INSERT
ON assess FOR EACH ROW
BEGIN
	IF CHAR_LENGTH(new.asscontent)<5 THEN
		INSERT INTO 输入内容太少 VALUES(NULL);		
	END IF;
END $$ 
DELIMITER; 
INSERT INTO assess VALUES(NULL,9,8,'好,好,好牛的商品厉害呀',DEFAULT);
SELECT * FROM assess;

#【作业 2】
-- 为商品表添加 insert 触发器，要求产品售价必须低于产品原价，否则插入失败
USE orderdb;DROP TRIGGER IF EXISTS t_products_insert;
DELIMITER $$
CREATE TRIGGER t_products_insert BEFORE INSERT
ON products FOR EACH ROW
BEGIN 
	IF new.pronewprice>new.prooldprice THEN
		INSERT INTO 新价格比原价格高 VALUES (NULL);
	END IF;
END $$
DELIMITER;
INSERT INTO products VALUES(NULL,6,'不知道卖个啥那就随便卖吧',1900,1800,100,100,DEFAULT,DEFAULT);
SELECT * FROM products;

#【作业 3】
-- 为商品表添加 update 触发器，要求修改库存数量时，修改的库存数量必须大于原来的库存
-- 数量，否则修改失败
USE orderdb; DROP TRIGGER IF EXISTS t_products_update;
DELIMITER $$
CREATE TRIGGER t_products_update BEFORE UPDATE
ON products FOR EACH ROW
BEGIN 
	IF new.prodepot < old.prodepot THEN
		INSERT INTO 库存输入过少 VALUES(NULL);
	END IF;
END $$
DELIMITER;
UPDATE products SET prodepot = 100 WHERE proid = 24;

#【作业 4】
-- 为订单表添加 delete 触发器，在触发器中先查询此订单的总金额，根据总金额修改客户积分
-- （例如此订单的总金额为 1000，则减少此客户的积分 1000 分），再删除此订单对应的详
-- 单信息
USE orderdb;
-- DROP TRIGGER IF EXISTS t_orders_delete;
   DROP TRIGGER IF EXISTS t_orders_delete;
-- DELIMITER $$
   DELIMITER $$
-- CREATE TRIGGER t_orders_delete BEFORE DELETE ON orders FOR EACH ROW BEGIN
   CREATE TRIGGER t_orders_delete BEFORE DELETE ON orders FOR EACH ROW BEGIN

--	select sum(odcount*odprice) into @nsum from orders as od 
	SELECT SUM(odcount*odprice) INTO @nsum FROM orders AS od 
--	left join orderdetail as odd on od.ordernum = odd.ordernum
	LEFT JOIN orderdetail AS odd ON od.ordernum = odd.ordernum 
--	where od.ordernum = old.ordernum 
	WHERE od.ordernum = old.ordernum 
--	group by cusid
	GROUP BY cusid
--	having sum(odcount*odprice) in not null;
	HAVING SUM(odcount*odprice) IS NOT NULL;
--	update customers set cuspoint = cuspoint-@nsum where cusid=old.cusid;
	UPDATE customers SET cuspoint = cuspoint-@nsum WHERE cusid=old.cusid; 
--	delete from orderdetail where ordernum = old.ordernum;
	DELETE FROM orderdetail WHERE ordernum = old.ordernum;
END $$


DROP TRIGGER IF EXISTS t_orders_delete;
DELIMITER $$
CREATE TRIGGER t_orders_delete BEFORE DELETE ON orders FOR EACH ROW BEGIN
	SELECT SUM(odcount*odprice) INTO @nsum FROM orders AS od 
	LEFT JOIN orderdetail AS odd ON od.ordernum = odd.ordernum 
	WHERE od.ordernum = old.ordernum 
	GROUP BY cusid
	HAVING SUM(odcount*odprice) IS NOT NULL;
	UPDATE customers SET cuspoint =cuspoint-@nsum WHERE cusid=old.cusid; 
DELETE FROM orderdetail WHERE ordernum = old.ordernum;
END $$
#【作业 5】
-- 修改每一个用户的默认地址为订单中使用次数最多的地址
-- 获取每个用户的编号
-- 根据用户编号查找订单中地址使用次数最多的
-- 根据用户编号和地址编号修改为默认地址
USE orderdb; DROP PROCEDURE IF EXISTS pro_dizhi;
DELIMITER $$
CREATE PROCEDURE pro_dizhi()
BEGIN
	DECLARE ncid INT; -- 客户编号
	DECLARE cur_dizhi CURSOR FOR SELECT cusid,cusnick FROM customers;
	DECLARE EXIT HANDLER FOR 1329 CLOSE cur_dizhi;
	OPEN cur_dizhi;
	WHILE 1=1 DO
		FETCH cur_dizhi INTO ncid;
		UPDATE cusadds SET CADefault=0 WHERE cusid=ncid;
		UPDATE cusadds SET CADefault=1 WHERE caid=(SELECT caid FROM orders WHERE cusid=ncid GROUP BY caid ORDER BY COUNT(caid) DESC LIMIT 1)  AND cusid = ncid;
	END WHILE;	
	CLOSE cur_dizhi;
END $$
SELECT pro_dizhi();