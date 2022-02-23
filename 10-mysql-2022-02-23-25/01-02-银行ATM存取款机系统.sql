#需求1：建库、建表、建约束
#需求2：创建触发器实现检查约束
#需求3：插入测试数据
#需求4：模拟常规业务
#需求5：利用视图实现较复杂的数据查询
#需求6：使用存储过程实现业务处理
#需求7：利用事务实现较复杂的数据更新

#【练习1】使用SQL语句建库建表建约束需求说明使用SQL语言创建数据库BankDB使用SQL语言创建表并设置约束（非空约束、主外键约束，默认约束，唯一约束）存款类型表客户信息表银行卡信息表交易信息表
DROP DATABASE IF EXISTS bankdb; -- 要求全小写 删除数据库
CREATE DATABASE bankdb CHARACTER SET utf8; -- 创建数据库
SHOW DATABASES; -- 查看所有数据库
USE bankdb;  -- 使用数据库

	--	存款类型表结构（Deposit） 
DROP TABLE IF EXISTS deposit;
CREATE TABLE deposit
(
	savingid INT PRIMARY KEY AUTO_INCREMENT,	-- 存款类型号
	savingname VARCHAR(20)	NOT NULL,		-- 存款类型名称
	descrip	VARCHAR(200)				-- 描述	
);

	-- 	客户信息表结构（UserInfo）
DROP TABLE IF EXISTS userinfo;
CREATE TABLE userinfo 
(	cusid INT AUTO_INCREMENT PRIMARY KEY,	-- 客户编号
	cusname VARCHAR(20) NOT NULL, 		-- 开户姓名
	cuscard	CHAR(18) NOT NULL UNIQUE,	-- 身份证信息
	custel VARCHAR(20) NOT NULL,		-- 电话号码
	cusadd VARCHAR(50)			-- 居住地址	
);


	--	银行卡信息表结构（CardInfo）
DROP TABLE IF EXISTS cardinfo;
CREATE TABLE cardinfo
(
	cardid	CHAR(19) PRIMARY KEY NOT NULL,			-- 卡号
	savingid INT NOT NULL,					-- 货币种类
	curvalue VARCHAR(10)NOT NULL DEFAULT 'rmb',		-- 存款类型
	opendate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,	-- 开户日期
	openmoney DECIMAL(12,2) NOT NULL,			-- 开户金额
	balance DECIMAL(12,2) NOT NULL,				-- 余额
	pass CHAR(6) NOT NULL,					-- 密码
	lsreportloss BIT NOT NULL DEFAULT 0,			-- 是否挂失 (1,挂失,0,不挂失)
	customerid INT NOT NULL ,				-- 客户编号 
	CONSTRAINT fk_cardifo_userinfo FOREIGN KEY (customerid) REFERENCES userinfo(cusid),
	CONSTRAINT fk_cardifo_deposit FOREIGN KEY (savingid) REFERENCES deposit(savingid)
);

	--	交易信息表结构 （TradeInfo）
DROP TABLE IF EXISTS tradeinfo;
CREATE TABLE tradeinfo
(
	tranid INT PRIMARY KEY AUTO_INCREMENT,			-- 交易编号
	cardid CHAR(19)	NOT NULL,				-- 卡号
	transdate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,	-- 交易日期
	transtype VARCHAR(10) NOT NULL,				-- 交易类型(存入/支出)
	transmoney DECIMAL(12,2) NOT NULL,			-- 交易金额
	remark VARCHAR(200)					-- 备注	
);

#【练习2】使用SQL创建触发器，实现数据验证
-- 1.为CardInfo表添加insert触发器，要求openMoney、balance列的值必须大于等于1，要求pass列的长度必须等于6
DROP TRIGGER IF EXISTS t_cardinfo_insert;
DELIMITER $$
CREATE TRIGGER t_cardinfo_insert BEFORE INSERT
ON cardinfo FOR EACH ROW
BEGIN
	IF new.openmoney<1 OR new.balance<1 OR CHAR_LENGTH(new.pass)!=6 THEN
		INSERT INTO 不符合要求 VALUES(NULL);		
	END IF;
END $$
SELECT * FROM cardinfo;



-- 2.为TradeInfo表添加insert触发器，要求transMoney列的值必须大于1,transType的值必须是“存入”或“支取”
DROP TRIGGER IF EXISTS t_tradeinfo_insert;
DELIMITER $$
CREATE TRIGGER t_tradeinfo_insert BEFORE INSERT
ON tradeinfo FOR EACH ROW
BEGIN
	IF new.transmoney<1 OR new.transtype!='存入' OR '支取' THEN 
		INSERT INTO 不符合要求 VALUES(NULL);
	END IF;
END $$

#【练习3】执行“测试数据.sql”文件中的代码来添加测试数据
-- 说明：如果插入数据出错，请检查创建的表，添加的触发器是否有问题，
(
-- 清除数据
TRUNCATE TABLE tradeInfo;
TRUNCATE TABLE cardInfo;
TRUNCATE TABLE userInfo;
TRUNCATE TABLE deposit;
-- 存款类型
INSERT INTO deposit (savingName,descrip) VALUES ('活期','按存款日结算利息');
INSERT INTO deposit (savingName,descrip) VALUES ('定期一年','存款期是1年');
INSERT INTO deposit (savingName,descrip) VALUES ('定期二年','存款期是2年');
INSERT INTO deposit (savingName,descrip) VALUES ('定期三年','存款期是3年');
INSERT INTO deposit (savingName) VALUES ('定活两便');
INSERT INTO deposit (savingName) VALUES ('通知');
INSERT INTO deposit (savingName,descrip) VALUES ('零存整取一年','存款期是1年');
INSERT INTO deposit (savingName,descrip) VALUES ('零存整取二年','存款期是2年');
INSERT INTO deposit (savingName,descrip) VALUES ('零存整取三年','存款期是3年');
INSERT INTO deposit (savingName,descrip) VALUES ('存本取息五年','按月支取利息');

INSERT INTO userInfo(CusName,CusCard,CusTel,CusAdd)
     VALUES('张三','123456789012346','010-67898978','长沙开福');     
INSERT INTO cardInfo(cardID,savingID,openMoney,balance,customerid,pass)
     VALUES('1010 3576 1234 5678',1,1000,1000,1,'123456');

INSERT INTO userInfo(CusName,CusCard,CusTel,CusAdd)
     VALUES('李四','321245678912345678','0478-44443333','长沙岳麓');
INSERT INTO cardInfo(cardID,savingID,openMoney,balance,customerid,pass)
     VALUES('1010 3576 1212 1134',2,1,1,2,'123456');

INSERT INTO userInfo(CusName,CusCard,CusTel,CusAdd)
     VALUES('王五','567891234532124670','010-44443333','长沙岳麓');
INSERT INTO cardInfo(cardID,savingID,openMoney,balance,customerid,pass)
     VALUES('1010 3576 1212 1130',2,1,1,3,'123456');

INSERT INTO userInfo(CusName,CusCard,CusTel,CusAdd)
     VALUES('丁六','567891321242345618','0752-43345543','长沙天心');
INSERT INTO cardInfo(cardID,savingID,openMoney,balance,customerid,pass)
     VALUES('1010 3576 1212 1004',2,1,1,4,'123456');

/*
张三的卡号（1010 3576 1234 5678）取款900元，李四的卡号（1010 3576 1212 1134）存款5000元，要求保存交易记录，以便客户查询和银行业务统计。
说明：当存钱或取钱（如300元）时候，会往交易信息表（tradeInfo）中添加一条交易记录，
      同时应更新银行卡信息表（cardInfo）中的现有余额（如增加或减少300元）
*/
/*--------------交易信息表插入交易记录--------------------------*/
INSERT INTO tradeInfo(transType,cardID,transMoney)
      VALUES('支取','1010 3576 1234 5678',900) ; 
/*-------------更新银行卡信息表中的现有余额-------------------*/
UPDATE cardInfo SET balance=balance-900 WHERE cardID='1010 3576 1234 5678';

INSERT INTO tradeInfo(transType,cardID,transMoney) 
      VALUES('存入','1010 3576 1212 1130',300);
/*-------------更新银行卡信息表中的现有余额-------------------*/
UPDATE cardInfo SET balance=balance+300 WHERE cardID='1010 3576 1212 1130';

INSERT INTO tradeInfo(transType,cardID,transMoney) 
      VALUES('存入','1010 3576 1212 1004',1000);  
/*-------------更新银行卡信息表中的现有余额-------------------*/
UPDATE cardInfo SET balance=balance+1000 WHERE cardID='1010 3576 1212 1004';

INSERT INTO tradeInfo(transType,cardID,transMoney) 
      VALUES('支取','1010 3576 1212 1130',1900);  
/*-------------更新银行卡信息表中的现有余额-------------------*/
UPDATE cardInfo SET balance=balance+1900 WHERE cardID='1010 3576 1212 1130';
/*--------------交易信息表插入交易记录--------------------------*/
INSERT INTO tradeInfo(transType,cardID,transMoney) 
      VALUES('存入','1010 3576 1212 1134',5000);   
/*-------------更新银行卡信息表中的现有余额-------------------*/
UPDATE cardInfo SET balance=balance+5000 WHERE cardID='1010 3576 1212 1134';
)

#【练习4】常规业务
#升级银行卡密码
-- 编写SQL语句，将密码升级为md5编码（在表中添加一个新的密码列）
ALTER TABLE cardinfo ADD carmd5 VARCHAR(120);

#修改银行卡密码
-- 编写修改银行卡密码的SQL语句，根据卡号和密码为条件，修改密码（修改后的密码为MD5编码）
UPDATE cardinfo SET pass = 111111,carmd5 = MD5(111111) WHERE cardid = '1010 3576 1212 1004' AND pass = 123456; -- 密码为111111

#办理银行卡挂失
-- 根据卡号修改银行卡挂失状态
UPDATE cardinfo SET lsreportloss = 1 WHERE cardid = '1010 3576 1212 1004'; -- 挂失中

#统计银行资金流通余额和盈利结算
-- 使用SQL编程计算银行资金流通余额=总存入金额-总支取金额
SELECT *,
	SUM(CASE 
		WHEN transtype='存入' THEN transmoney  
		ELSE 0 END
	)AS 总存入金额,
	SUM(CASE 
		WHEN transtype='支取' THEN transmoney
		ELSE 0 END
	)AS 总支取金额  FROM tradeinfo;

--   使用SQL编程盈利结算=总支取金额 * 0.008 – 总存入金额 * 0.003
SELECT  (SUM(CASE 
		WHEN transtype='支取' THEN transmoney  
		ELSE 0 END)*0.008 )-
	(SUM(CASE 
		WHEN transtype='存入' THEN transmoney
		ELSE 0 END)*0.003) AS 总支取金额  FROM tradeinfo;

#查询本周开户的卡号，显示该卡相关信息
-- 编写SQL语句查询记录
SELECT cardid 卡号,curvalue 货币种类,opendate 开户时间,openmoney 开户金额,balance 余额 FROM cardinfo WHERE  WEEK(opendate)=WEEK(NOW());

#查询本月交易金额最高的卡号
-- 编写SQL语句查询记录	
-- 交易金额为交易信息表中交易金额总和
SELECT * FROM tradeinfo WHERE MONTH(transdate)=MONTH(NOW())  GROUP BY cardid ORDER BY SUM(transmoney) DESC LIMIT 1;

#查询挂失账号的客户信息
-- 根据银行卡中挂失状态查询客户信息
-- 使用子查询或关联查询
SELECT cardid,curvalue,opendate,openmoney,balance FROM cardinfo WHERE lsreportloss = 1;

#催款提醒业务
-- 查询账户余额少于200元的客户信息
-- 使用子查询IN 或内联接查询INNER JOIN
SELECT cusid,cusname,cuscard,custel,cusadd,cardid,curvalue,opendate FROM userinfo INNER JOIN cardinfo ON userinfo.cusid = cardinfo.customerid WHERE cusid IN (SELECT customerid FROM cardinfo WHERE balance<200);

#【练习5】利用视图查询数据
-- 为客户提供以下2个视图供其查询该客户数据
-- 银行卡信息：vw_cardInfo：包含客户信息、银行卡信息
DROP VIEW IF EXISTS vw_cardInfo;
CREATE VIEW vw_cardInfo AS SELECT cusid,cusname,cuscard,custel,cusadd,cardid,opendate,curvalue,balance FROM userinfo INNER JOIN cardinfo ON userinfo.cusid = cardinfo.customerid;

-- 银行卡交易信息：vw_tradeInfo：包含客户信息、银行卡信息、存款信息、交易信息
DROP VIEW IF EXISTS vw_tradeInfo;
CREATE VIEW vw_tradeInfo AS SELECT cusid,cusname,cardinfo.cardid,savingname FROM userinfo INNER JOIN cardinfo ON userinfo.cusid = cardinfo.customerid INNER JOIN deposit ON deposit.savingid=cardinfo.savingid INNER JOIN tradeinfo ON tradeinfo.cardid = cardinfo.cardid;

#调用创建的视图获得查询结果
SELECT * FROM vw_cardInfo;
SELECT * FROM vw_tradeInfo;

-- 查询、统计本周内没有发生交易的账户信息
SELECT *,COUNT(*) FROM tradeinfo WHERE WEEK(transdate)=WEEK(NOW());

-- 统计本月“长沙”地区客户在银行卡交易量和交易额。
SELECT COUNT(*)交易量,SUM(transmoney)交易额 FROM tradeinfo WHERE cardid IN(SELECT cardid FROM cardinfo WHERE customerid IN(SELECT cusid FROM userinfo WHERE cusadd LIKE'%长沙%'));

#【练习6】使用存储过程实现业务功能
-- 完成取款或存款业务
-- 存储过程输入参数：银行卡卡号，操作金额，操作类型（存款，取款）
-- 在存储过程中添加交易信息和修改银行卡余额（需要判断操作类型：存款，取款）
-- 返回修改后的余额
DROP PROCEDURE IF EXISTS pro_wd;
DELIMITER $$
CREATE PROCEDURE pro_wd(IN ncid CHAR(19),IN wd VARCHAR(6),IN nmoney INT,OUT nvmoney INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;
	START TRANSACTION;
		IF wd = '存款' THEN
			INSERT INTO tradeinfo VALUES(NULL,ncid,DEFAULT,'存入',nmoney,NULL);
			UPDATE cardinfo SET balance = balance+nmoney WHERE cardid = ncid;
		END IF;
		IF wd = '取款' THEN
			INSERT INTO tradeinfo VALUES(NULL,ncid,DEFAULT,'支取',nmoney,NULL);
			UPDATE cardinfo SET balance = balance-nmoney WHERE cardid = ncid;
		END IF;
		SELECT balance INTO nvmoney FROM cardinfo WHERE cardid = ncid;
	COMMIT;
END $$
SET @money = 0;
CALL pro_wd('1010 3576 1234 5678','存款',2000,@money);
SELECT @money;

  -- 根据指定显示的页数和每页的记录数分页显示交易信息
-- 存储过程输入参数：当前页数和每页记录数
DROP PROCEDURE IF EXISTS pro_awp;
DELIMITER $$
CREATE PROCEDURE pro_awp(IN a INT,IN b INT)
BEGIN
	SELECT * FROM tradeinfo LIMIT (a-1)*b , b; 
END $$

#【练习7】实现复杂的业务功能
-- 需求说明
-- 使用事务和存储过程实现转账业务
-- 思路分析
-- 转账业务包括存款和取款操作。例如A转账给B，业务流程就是A取款的过程加B存款的过程
-- 指定的客户取款
-- 指定的客户存钱
-- 为取钱客户添加交易信息
-- 为存钱客户添加交易信息
--   在此存储过程中使用事务实现
DROP PROCEDURE IF EXISTS pro_zz;
DELIMITER $$
CREATE PROCEDURE pro_zz(IN a CHAR(19),IN b CHAR(19),IN c INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;
	START TRANSACTION;
	UPDATE cardinfo SET balance = balance - c WHERE cardid = a;  -- a-->b
	UPDATE cardinfo SET balance = balance + c WHERE cardid = b;  -- b-->a	
	COMMIT;
END $$
CALL pro_zz('1010 3576 1212 1004','1010 3576 1212 1130',100);
SELECT * FROM cardinfo;

#【练习8】使用自定义函数
-- 产生随机卡号
-- 随机卡号规则：由16位数字构成，每4位数字一组，中间用空格隔开
--   如：1010 3576 1001 1202
-- 前8位数字固定的，表示发卡银行识别号（BIN）
--   前8位是1010 3576
-- 以8位随机数替代卡号的后8位数字。使用Rand函数生成随机数转化为字符串后截取后8位（使用decimal(10,8)接收随机数）
-- 定义自定义函数来生成随机卡号，无参数，返回生成的卡号（char(19)）
-- 编写SQL语句添加银行卡信息，在添加的SQL语句中调用生成卡号的自定义函数
DROP FUNCTION IF EXISTS fn_qwe;
DELIMITER $$
CREATE FUNCTION fn_qwe(A CHAR(19)) RETURNS CHAR(19) 
BEGIN
	SELECT CEIL((RAND()*9));

	SELECT CONCAT('1010 3576',,内容,'...');

	
RETURN 返回值;
END $$;

#【练习9】实现开户的存储过程
--  存储过程要求
--  输入参数：客户姓名，身份证号码，联系电话、存款类型，开户金额
--  输出参数：卡号
--  步骤：
--  1.添加客户信息，并使用@@last_insert_id获取添加客户的编号
--  2.通过随机数生成卡号，如果卡号在银行卡表中重复，则重新生成卡号直到没有重复的卡号
--  3.添加银行卡信息
 
