#【作业 1】：使用 OrderDB 数据库
#使用数据库
USE orderdb;

-- 1. 生成 1-100 的随机数
SELECT CEIL(RAND()*100) AS '1~100';

-- 2. 生成 1-30 的随机数
SELECT CEIL(RAND()*30) AS '1~30';

-- 3. 抽取积分大于 100 的幸运客户，名额为 3 个
SELECT * FROM customers WHERE CusPoint>100 ORDER BY RAND() LIMIT 3;

-- 4. 查询客户地址表,显示效果:
	#姓名 地址
	#张三 湖南省长沙市涉外国际公馆
SELECT CusNick AS '姓名',CONCAT(CAProvince,'省',cacity,'市',caaddress) AS '地址' FROM customers 
	INNER JOIN cusadds ON customers.CusID = cusadds.CusID;

-- 5. 查询密码长度小于 5 的用户
SELECT * FROM customers WHERE CHAR_LENGTH(cuspwd)<5;

-- 6. 将用户密码转化成 MD5 编码，并编写登录的 SQL 语句（注意：用户输入的密码为正常内容）
SELECT IF((SELECT MD5(cuspwd) FROM customers 
	WHERE CusNick = '张三' LIMIT 1)=(SELECT MD5(cuspwd) FROM customers 
		WHERE CusNick='张三' AND cuspwd = 'qwer' LIMIT 1),'成功','错误'); 

-- 7. 查询本月的所有订单
SELECT * FROM orders WHERE MONTH(OrderDate)=MONTH(NOW());

-- 8. 查询今天所有的评价信息
SELECT * FROM assess WHERE DAY(AssDate)=DAY(NOW())-1;

-- 9. 查询上月的销售总金额（根据订单表和订单详单表）
SELECT MONTH(CONVERT(OrderDate,DATE)) AS 上月,SUM(ODPrice) FROM orders 
	INNER JOIN orderdetail ON orders.OrderNum = orderdetail.OrderNum 
		WHERE MONTH(orderdate)= MONTH(NOW())-1;

-- 10. 查询去年每个商品类别的商品销售总数
SELECT protypes.TypeID,TypeName,COUNT(ProSale) FROM orders 
INNER JOIN orderdetail ON orderdetail.OrderNum=orders.OrderNum 
	INNER JOIN products  ON products.ProID = orderdetail.ProID
	INNER JOIN protypes ON products.TypeID=protypes.TypeID 
		WHERE YEAR(OrderDate)=2016 GROUP BY TypeName;

-- 11. 查询本周登录过的用户
SELECT * FROM customers WHERE WEEK(cuslogindate)=WEEK(NOW());

-- 12. 定义函数，接受参数数量和价格，返回总金额，在查询订单详单时，显示订单详单信息和总金额（使用函数实现）
DROP FUNCTION IF EXISTS fn_ning;
CREATE FUNCTION fn_ning (number INT,money DECIMAL) RETURNS DECIMAL
	RETURN number*money;
SELECT *,fn_ning(ODCount,odprice) AS 总价 FROM orderdetail;

#【作业 2】
-- 1. 获得今天的日期
SELECT NOW();

-- 2. 使用日期函数得到今天星期几
SELECT WEEKDAY(NOW())+1;

-- 3. 获取今天距离新年还有几天 （新年 2023 年 1 月 22 日）
SELECT DATEDIFF('2023-01-22',NOW());

-- 4. 获取今天距离新年还有多少周
SELECT CEIL((DATEDIFF('2023-01-22',NOW()))/7);

-- 5. 使用日期函数得到今年元旦后 5 周的日期
SELECT DATE_ADD('2023-01-01',INTERVAL (5*7) DAY);

-- 6. 使用日期函数得到今年元旦 5 天后星期几
SELECT WEEKDAY(DATE_ADD('2023-01-01',INTERVAL 5 DAY))+1;

-- 7. 找出'去,我又没钱吃饭了'中'去'字的位置
SELECT LOCATE('去,我又没钱吃饭了','去');

-- 8. 将'去,我又没钱吃饭了'中的'去'字替换成'XX
SELECT REPLACE('去,我又没钱吃饭了','去','汤俊');

-- 9. 请截出 0731-1234567 中的区号
SELECT SUBSTRING('0731-123456',1,4);
	
#【作业 3】使用 workDB 数据库
#使用数据库
USE workdb;

-- 1. 查询所有学员从入学到今天，一共度过了多少天
SELECT DATEDIFF(NOW(),StuJoinTime) FROM studentinfo;

-- 2. 查询所有 2 号入学的学员姓名，年龄，性别
SELECT StuName,StuSex,StuAge FROM studentinfo WHERE DAY(StuJoinTime)=2;

-- 3. 查询直到‘2007-3-12’日截止，入学时间超过 6 天的所有学员信息
SELECT * FROM studentinfo WHERE DAY(StuJoinTime)<DAY('2007-3-12') AND DAY(StuJoinTime)<DAY('2007-3-12')-6;

-- 4. 查询（如果按每个学员入学时间 1 年半之后学员将毕业）所有学员的毕业日期。
SELECT *,DATE_ADD(StuJoinTime,INTERVAL 366+(366/2) DAY) AS 毕业时间 FROM studentinfo;

-- 5. 查询星期四入学的学员姓名，性别，年龄，班级编号
SELECT StuName,StuSex,StuAge,ClassNumber FROM studentinfo INNER JOIN classinfo ON studentinfo.SClassID=classinfo.ClassID WHERE WEEKDAY(StuJoinTime)+1=4;

-- 6. 查询学生信息表中学员身份证号码第 9，10 位为‘89’的学员信息。要求：使用字符串函数
SELECT * FROM studentinfo WHERE SUBSTRING(StuCard,9,2) = 89;

-- 7. 修改班主任信息，将所有老师的邮箱中的’yahoo.com’ 替换为’tuling.com’
SELECT REPLACE(TeacherEmail,'yahoo.com','tuling.com') FROM teacherinfo;

-- 8. 查找学员信息，要求结果集表达方式为：
	#学员 信息
	#'学员１，东方不败，今年 20 
SELECT CONCAT('学员',StuID),CONCAT(StuName,',今年 ',stuage) FROM studentinfo;		

-- 9. 查询 8 月 9 号一共产生多少金牌
SELECT COUNT(*) FROM king WHERE DATE(getkingdate)='2008-08-09';

-- 10. 查询 8 月 9 号中国军团一共产生多少金牌
SELECT COUNT(*) FROM king WHERE DATE(getkingdate)='2008-08-09' AND country='中国';

-- 11. 奥运会开幕三天后，中国军团获得了多少金牌
SELECT COUNT(*) FROM king WHERE DATE(getkingdate)>'2008-08-09'AND DATE(getkingdate)<ADDDATE('2008-08-09',3) AND country='中国';

-- 12. 查询蹦床冠军获得者的名子有多长
SELECT CHAR_LENGTH(athlete) FROM king WHERE bigitem = '蹦床';

-- 13. 将 id 列与 athlete 列两列合并为一列显示
SELECT CONCAT(id,athlete)FROM king;