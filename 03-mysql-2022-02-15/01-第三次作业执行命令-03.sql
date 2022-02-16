(#【1】
#创建数据库
DROP DATABASE IF EXISTS OrderDB;
	CREATE DATABASE OrderDB CHARACTER SET utf8;

#使用数据库
USE OrderDB;

#查看表的结构
DESC customers;

#【2】
-- 1. 张三注册了一个新用户，昵称为德玛西亚，登录账号和密码自行设定，新用户注册送 100 积分
INSERT INTO customers VALUES(NULL,'小寜','qwer','qwer',100,CURRENT_TIMESTAMP,NULL);
	INSERT INTO customers VALUES(NULL,'张三','qwer','qwer',100,CURRENT_TIMESTAMP,NULL);

-- 2. 张三为自己的账号设置了 2 个收货地址：
	#a) 湖南，长沙，涉外国际公馆 3 栋 1 单元
INSERT INTO cusadds VALUES(NULL,12,'湖南','长沙','涉外国际公馆 3 栋 1 单元',1);

	#b) 湖南，长沙，麓谷企业广场（默认地址）
INSERT INTO cusadds VALUES(NULL,12,'湖南','长沙','麓谷企业广场',0);

-- 3. 张三购买了 2 个商品，使用的是默认地址：
	#a) ThinkPad X1 Carbon 数量=1
INSERT INTO orders VALUES('SS202202150001',17,12,CURRENT_TIMESTAMP);
	INSERT INTO orderdetail VALUES(NULL,'SS202202150001',3,1,8999.00);

	#b) 飞利浦（PHILIPS） SHE6000 数量=2
INSERT INTO orders VALUES('SS202202150002',17,12,CURRENT_TIMESTAMP);#手动添加无法用代码添加
	INSERT INTO orderdetail VALUES(NULL,'SS202202150002',23,2,69.00);

-- 4. 张三对商品 ThinkPad X1 Carbon 进行了评价：“非常好的笔记本”
INSERT INTO assess VALUES(NULL,17,3,'非常好的笔记本',CURRENT_TIMESTAMP);

-- 5. 系统根据张三的购买记录，修改了张三的积分，积分规则为每 100 元 1 积分
UPDATE customers SET CusPoint=(CusPoint+90) WHERE CusID = 12;

-- 6. 按照张三的要求，客服将收货地址为了他设置的第一个地址（涉外国际公馆 3 栋 1 单元）
UPDATE orders SET CAID = 17 WHERE CusID = 12;

-- 7. 张三修改了对 ThinkPad X1 Carbon 的评价为：“金三胖也是用这个电脑”
UPDATE assess SET AssContent = '金三胖也是用这个电脑' WHERE CusID = 17;

-- 8. 客服发现张三的评价中有违规信息，将他的评论进行了删除
DELETE FROM assess WHERE CusID = 17;

#【3】
-- 1. 按照商品价格排序从高到底排序显示数据 
SELECT * FROM products ORDER BY ProNewPrice DESC;

-- 2. 查询订单详单中每个商品的购买总数及总金额
SELECT COUNT(*),ProID,SUM(ODPrice) FROM orderdetail GROUP BY ODPrice;

-- 3. 查询商品信息并显示商品信息及类别名称
SELECT * FROM products INNER JOIN protypes ON products.TypeID=protypes.TypeID;

-- 4. 显示商品价格最高的 3 个商品
SELECT * FROM products ORDER BY ProNewPrice DESC LIMIT 3;

-- 5. 假设每页显示 5 条记录，请查询出商品中第三页的数据
SELECT * FROM products LIMIT 10,5;

-- 6. 查询评价表显示客户昵称、商品名称、评价信息
SELECT CusNick,AssContent,ProName FROM assess INNER JOIN customers ON assess.CusID = customers.CusID INNER JOIN products ON assess.CusID=products.`ProID`;

-- 7. 查询显示客户信息及客户说使用的默认地址的详细信息
SELECT * FROM customers INNER JOIN cusadds ON customers.CusID = cusadds.CusID WHERE CADefault = 0;

-- 8. 查询显示每个客户的信息及最后发表的商品评价信息
	#提示：对评价信息进行分组查询，将分组查询的结果与客户信息进行关联查询
SELECT CusNick,AssContent FROM customers INNER JOIN assess ON customers.CusID = assess.CusID GROUP BY AssContent;
'/*改*/'
SELECT 
#查看用户表
SELECT * FROM customers;

#查看用户地址表
SELECT * FROM cusadds;

#查看订单表
SELECT * FROM orders;

#查看订单详细表
SELECT * FROM orderdetail;

#商品表
SELECT * FROM products;

#商品分类表
SELECT * FROM protypes;

#评价表
SELECT * FROM assess;
)
(#【4】以下作业的数据请自行在 MySQL 中创建数据库，并导入“workDB.sql”中的内容
#建表
DROP DATABASE IF EXISTS Workdb;
	CREATE DATABASE Workdb CHARACTER SET utf8;
	
#使用数据库
USE workdb	
	
-- 1. 按国家分组查询每一个国家获得了多少金牌
SELECT country,COUNT(*) FROM king GROUP BY country;

-- 2. 按大项目分组，查询每一项目产生多少金牌
SELECT bigitem,COUNT(*) FROM king GROUP BY bigitem;

-- 3. 按国家和大项目分组，查询那个国家某个项目分别获得多少金牌
SELECT country,bigitem,COUNT(*) FROM king GROUP BY country,bigitem;

-- 4. 找出获得金牌数大于 25 以上的国家
SELECT country,COUNT(*) FROM king GROUP BY country HAVING COUNT(*)>25;

-- 5. 按照大项目分组，中国每个大项目获得的金牌数,并且金牌总数超过 5 枚的
SELECT country,bigitem,COUNT(*) FROM king GROUP BY bigitem HAVING COUNT(*)>5;

#运动员表
SELECT * FROM king;

#【5】
-- 1.查询各科目的平均成绩
SELECT  ExamSubject,AVG(ExamResult) FROM studentexam GROUP BY ExamSubject ;

-- 2.查询考试不及格的人数
SELECT * FROM studentexam WHERE ExamResult<60;

-- 3.查询每个学员各参加几次考试
SELECT * FROM studentexam GROUP BY EStuID;

-- 4.查询男女学员的平均年龄
SELECT StuSex,AVG(StuAge) FROM studentinfo GROUP BY StuSex;

-- 5.查询各学员的总成绩，要求筛选出总成绩在 140 分以上的
SELECT * FROM studentexam GROUP BY  EStuID HAVING  SUM(ExamResult)>140;

-- 6.查询所有学员的信息，要求显示：姓名，学号，考试科目，考试成绩，并按照考试成绩降序和学号排序升序排序(提示：每个学员的信息都要求显示，不论是否有参加考试)
SELECT StuName,StuCard,ExamSubject,ExamResult FROM studentinfo INNER JOIN studentexam ON studentinfo.StuID=studentexam.EStuID ORDER BY ExamResult ASC , Estuid DESC;

-- 7.按入学月份分组，查询学员的平均成绩.
SELECT AVG(ExamResult) FROM studentinfo INNER JOIN studentexam ON studentinfo.StuID=studentexam.EStuID GROUP BY StuJoinTime;

-- 8.按班级名称分组，查询每个班级的平均成绩。（3 表联接）
SELECT ClassNumber,AVG(ExamResult) FROM classinfo INNER JOIN studentinfo ON classinfo.ClassID=studentinfo.SClassID INNER JOIN studentexam ON studentinfo.StuID=studentexam.EStuID GROUP BY ClassNumber;

-- 9.查询所有 3 月份入学男学员，按所在班级分组，要求显示每个班级的考试平均分,并按从高到低排列.（3 表联接）
'
select * from studentinfo inner join studentexam ON studentinfo.StuID=studentexam.EStuID inner join classinfo ON classinfo.CTeacherID=studentinfo.SClassID group by CTeacherID having StuSex='男' order by ExamResult desc;
''不会'

-- 10.查询每个班主任所带学员信息，要求显示：班主任姓名，班主任联系电话，班级名称，学员姓名，学员学号.(提示：3 表联接)
SELECT TeacherName,TeacherTel,ClassNumber,StuName,StuCard FROM teacherinfo INNER JOIN classinfo ON teacherinfo.TeacherID=classinfo.CTeacherID INNER JOIN studentinfo ON classinfo.ClassID=studentinfo.SClassID;

-- 11.按班主任姓名分组，查所带班级的总成绩分（假定每个班主任只带一个班级）.(提示：4表联接)
SELECT TeacherName,AVG(ExamResult) FROM teacherinfo INNER JOIN classinfo ON teacherinfo.TeacherID = classinfo.CTeacherID INNER JOIN studentinfo ON classinfo.ClassID=studentinfo.SClassID INNER JOIN studentexam ON studentinfo.StuID=studentexam.EStuID GROUP BY TeacherName;

#编号
SELECT * FROM classinfo;

#成绩表
SELECT * FROM studentexam;

#人员信息
SELECT * FROM studentinfo;

#邮件地址
SELECT * FROM teacherinfo;
)