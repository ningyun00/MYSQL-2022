/*
SQLyog Professional v12.08 (64 bit)
MySQL - 5.6.31-log : Database - orderdb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`orderdb` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `orderdb`;

/*Table structure for table `assess` */

DROP TABLE IF EXISTS `assess`;

CREATE TABLE `assess` (
  `AssID` int(11) NOT NULL AUTO_INCREMENT,
  `CusID` int(11) DEFAULT NULL,
  `ProID` int(11) DEFAULT NULL,
  `AssContent` varchar(5000) DEFAULT NULL,
  `AssDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`AssID`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

/*Data for the table `assess` */

insert  into `assess`(`AssID`,`CusID`,`ProID`,`AssContent`,`AssDate`) values (1,7,8,'很便宜，比预期的好得多，而且还送了耳机收纳包和替换的耳塞。缺点是线不算长，手机和平板用用可以。音质么，毕竟这个价钱，我用手机听了听歌，很满意了。其他的，就是看耐不耐用了','2016-11-16 22:56:09'),(2,9,2,'京东自营放心购买，飞利浦耳机不错','2016-01-06 22:55:02'),(3,3,9,'音质蛮好的，东西蛮好的，老公蛮喜欢的','2016-04-05 22:55:43'),(4,4,10,'货真价实。设计合理，入耳不会下滑。音乐HIFI,信噪比高。价格实惠，不愧为名牌。环绕声尚未体现，可能我的CD片无环绕，以后找片再听。总之京东上购耳机不是第一次了。','2016-04-04 22:55:53'),(5,9,4,'产品质量可以，音质不错，听歌还可以。尤其是送的耳机包不错哦！???','2016-04-05 22:55:15'),(6,4,9,'午时已到！鲁大师显卡跑分超过八万！相当满意！本机平台差点。跑分时开着360卫士和360杀毒，还有无线网卡，这些会拖慢些整体速度。','2016-04-09 22:55:53'),(7,2,6,'显卡非常不错，是块好显卡，双十一860买下的，玩DOTA2特效全开帧数稳定70+，剑灵5档，玩家多了激战的时候帧数掉的厉害从70、80一下到了20、30帧，可能是我CPU不行，鲁大师装的驱动感觉比一般人的跑分高点，话不多说上图。','2016-07-08 22:56:01'),(8,9,7,'很不错的显卡！做工很好，双十一抢的 帮朋友装机用色。现在几乎通杀网络游戏，够用了。赞京东和影驰厂家。','2016-01-06 22:43:37'),(9,7,7,'一直相信京东！高品质，售后服务好！值得信赖！','2016-11-15 22:56:09'),(10,9,2,'双11买的，第一次网上买电子产品。心理总有点担心，不得不承认京东到货真的快！','2016-04-05 22:55:15'),(11,9,8,'等了好多天，今天终于来了。感觉很好。','2016-01-05 22:55:02'),(12,7,1,'东西很不错，外观也漂亮，值得购买。','2016-11-16 22:56:29'),(13,2,8,'内存条的兼容性很好，用于笔记本E450，加了以后速度快了。快递师傅也很给力','2016-11-18 22:56:24'),(14,7,3,'买的价格相当便宜！750G的固态不到1000块钱！笔记本整体换固态了！比MSATA接口120G的固态6多了！温度还低！这性能这价格羡慕死一群人，哈哈哈。','2016-11-20 22:56:09'),(15,10,3,'第一次用ssd，和原来机械硬盘相比，速度有了极大的飞跃，开机只需10秒左右，750g硬盘容量足，对得起价格，双11活动价和某猫差不多，不过看重京东的售后服务！','2016-11-18 22:56:35');

/*Table structure for table `cusadds` */

DROP TABLE IF EXISTS `cusadds`;

CREATE TABLE `cusadds` (
  `CAID` int(11) NOT NULL AUTO_INCREMENT,
  `CusID` int(11) DEFAULT NULL,
  `CAProvince` varchar(100) DEFAULT NULL,
  `CACity` varchar(100) DEFAULT NULL,
  `CAAddress` varchar(500) DEFAULT NULL,
  `CADefault` bit(1) DEFAULT b'0',
  PRIMARY KEY (`CAID`),
  KEY `FK_Reference_7` (`CusID`),
  CONSTRAINT `FK_Reference_7` FOREIGN KEY (`CusID`) REFERENCES `customers` (`CusID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Data for the table `cusadds` */

insert  into `cusadds`(`CAID`,`CusID`,`CAProvince`,`CACity`,`CAAddress`,`CADefault`) values (1,1,'北京','北京','abc',''),(2,1,'湖南','长沙','abc','\0'),(3,2,'湖南','长沙','abc',''),(4,3,'上海','上海','abc','\0'),(5,3,'广东','广州','abc',''),(6,3,'广东','深圳','abc','\0'),(7,4,'上海','上海','abc',''),(8,4,'湖北','武汉','abc','\0'),(9,5,'湖南','株洲','abc',''),(10,5,'北京','北京','abc','\0'),(11,6,'北京','北京','abc',''),(12,7,'上海','上海','abc',''),(13,8,'广东','广州','abc',''),(14,9,'湖南','长沙','abc',''),(15,9,'湖北','武汉','abc','\0'),(16,10,'广东','广州','abc',''),(17,12,'湖南','长沙','涉外国际公馆 3 栋 1 单元',''),(18,12,'湖南','长沙','麓谷企业广场','\0');

/*Table structure for table `customers` */

DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `CusID` int(11) NOT NULL AUTO_INCREMENT,
  `CusNick` varchar(50) DEFAULT NULL,
  `CusLogin` varchar(50) DEFAULT NULL,
  `CusPwd` varchar(50) DEFAULT NULL,
  `CusPoint` int(11) DEFAULT NULL,
  `CusCreateDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `CusLoginDate` datetime DEFAULT NULL,
  PRIMARY KEY (`CusID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `customers` */

insert  into `customers`(`CusID`,`CusNick`,`CusLogin`,`CusPwd`,`CusPoint`,`CusCreateDate`,`CusLoginDate`) values (1,'黑暗之女','123','123',1650,'2016-04-29 22:08:13','2016-11-21 22:09:27'),(2,'寒冰射手','123','123',6726,'2015-12-23 22:08:13','2016-09-05 22:09:27'),(3,'牛头酋长','123','123',8677,'2016-06-26 22:08:13','2016-08-28 22:09:27'),(4,'卡牌大师','123','123',3209,'2016-03-25 22:08:13','2016-08-16 22:09:27'),(5,'战争女神','123','123',13,'2016-03-09 22:08:13','2016-10-24 22:09:27'),(6,'迅捷斥候','123','123',439,'2016-06-07 22:08:13','2016-09-29 22:09:27'),(7,'审判天使','123','123',2154,'2016-06-05 22:08:13','2016-09-01 22:09:27'),(8,'末日使者','123','123',9452,'2016-03-27 22:08:13','2016-10-06 22:09:27'),(9,'雪人骑士','123','123',800,'2016-08-22 22:08:13','2016-08-22 22:09:27'),(10,'流浪法师','123','123',5645,'2016-06-29 22:08:13','2016-11-06 22:09:27'),(11,'小寜','qwer','qwer',100,'2022-02-15 17:20:46',NULL),(12,'张三','qwer','qwer',190,'2022-02-15 17:44:30',NULL);

/*Table structure for table `orderdetail` */

DROP TABLE IF EXISTS `orderdetail`;

CREATE TABLE `orderdetail` (
  `ODID` int(11) NOT NULL AUTO_INCREMENT,
  `OrderNum` char(14) DEFAULT NULL COMMENT 'SSYYYYMMDD0001',
  `ProID` int(11) DEFAULT NULL,
  `ODCount` int(11) DEFAULT NULL,
  `ODPrice` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`ODID`),
  KEY `FK_Reference_6` (`OrderNum`),
  KEY `FK_Reference_8` (`ProID`),
  CONSTRAINT `FK_Reference_6` FOREIGN KEY (`OrderNum`) REFERENCES `orders` (`OrderNum`),
  CONSTRAINT `FK_Reference_8` FOREIGN KEY (`ProID`) REFERENCES `products` (`ProID`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

/*Data for the table `orderdetail` */

insert  into `orderdetail`(`ODID`,`OrderNum`,`ProID`,`ODCount`,`ODPrice`) values (1,'SS201604020005',3,2,'8999.00'),(2,'SS201611110001',7,3,'1469.00'),(3,'SS201604020001',4,5,'7999.00'),(4,'SS201604020001',2,2,'5399.00'),(5,'SS201611110002',7,2,'1469.00'),(6,'SS201611110007',8,3,'819.00'),(7,'SS201611110001',3,6,'8999.00'),(8,'SS201601020001',8,2,'819.00'),(9,'SS201611110003',8,6,'819.00'),(10,'SS201611110008',10,2,'599.00'),(11,'SS201611110008',1,3,'6968.00'),(12,'SS201601010002',7,4,'1469.00'),(13,'SS201611110001',8,5,'819.00'),(14,'SS201601020001',2,4,'5399.00'),(15,'SS201604020003',9,2,'539.00'),(16,'SS201605070001',6,6,'2649.00'),(17,'SS201604020005',9,6,'539.00'),(18,'SS201611111111',9,2,'539.00'),(19,'SS201604020005',10,1,'599.00'),(20,'SS201611110009',3,4,'8999.00'),(21,'SS201601010001',2,1,'5999.00'),(24,'SS202202150001',3,1,'8999.00'),(25,'SS202202150002',23,2,'69.00');

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `OrderNum` char(14) NOT NULL COMMENT 'SSYYYYMMDD0001',
  `CAID` int(11) DEFAULT NULL,
  `CusID` int(11) DEFAULT NULL,
  `OrderDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`OrderNum`),
  KEY `FK_Reference_4` (`CAID`),
  KEY `FK_Reference_5` (`CusID`),
  CONSTRAINT `FK_Reference_4` FOREIGN KEY (`CAID`) REFERENCES `cusadds` (`CAID`),
  CONSTRAINT `FK_Reference_5` FOREIGN KEY (`CusID`) REFERENCES `customers` (`CusID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `orders` */

insert  into `orders`(`OrderNum`,`CAID`,`CusID`,`OrderDate`) values ('SS201601010001',13,8,'2016-01-01 22:43:08'),('SS201601010002',14,9,'2016-01-01 22:43:37'),('SS201601020001',15,9,'2016-01-02 22:55:02'),('SS201604020001',15,9,'2016-04-02 22:55:15'),('SS201604020002',11,6,'2016-04-02 22:55:30'),('SS201604020003',5,3,'2016-04-02 22:55:43'),('SS201604020005',7,4,'2016-04-02 22:55:53'),('SS201605070001',3,2,'2016-07-01 22:56:01'),('SS201611110001',12,7,'2016-11-11 22:56:09'),('SS201611110002',13,8,'2016-11-11 22:56:15'),('SS201611110003',12,7,'2016-11-11 22:56:20'),('SS201611110007',3,2,'2016-11-11 22:56:24'),('SS201611110008',12,7,'2016-11-11 22:56:29'),('SS201611110009',16,10,'2016-11-11 22:56:35'),('SS201611111111',12,7,'2016-11-11 22:56:41'),('SS201611111112',4,3,'2016-11-11 22:56:48'),('SS202202150001',17,12,'2022-02-15 00:00:00'),('ss202202150002',17,12,'2022-02-15 18:15:00'),('SS202202150099',17,12,'2022-02-15 21:06:37');

/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `ProID` int(11) NOT NULL AUTO_INCREMENT,
  `TypeID` int(11) DEFAULT NULL,
  `ProName` varchar(100) DEFAULT NULL,
  `ProOldPrice` decimal(10,2) DEFAULT NULL,
  `ProNewPrice` decimal(10,2) DEFAULT NULL,
  `ProSale` int(11) DEFAULT NULL,
  `Prodepot` int(11) DEFAULT NULL,
  `ProSaleBegin` datetime DEFAULT NULL,
  `ProSaleEnd` datetime DEFAULT NULL,
  PRIMARY KEY (`ProID`),
  KEY `FK_Reference_1` (`TypeID`),
  CONSTRAINT `FK_Reference_1` FOREIGN KEY (`TypeID`) REFERENCES `protypes` (`TypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

/*Data for the table `products` */

insert  into `products`(`ProID`,`TypeID`,`ProName`,`ProOldPrice`,`ProNewPrice`,`ProSale`,`Prodepot`,`ProSaleBegin`,`ProSaleEnd`) values (1,1,'Apple MacBook Air 13.3英寸笔记本电脑','6988.00','6968.00',74,23,NULL,NULL),(2,1,'联想(Lenovo)小新700电竞尊享升级版','5888.00','5399.00',63,18,NULL,NULL),(3,1,'ThinkPad X1 Carbon','9000.00','8999.00',18,4,NULL,NULL),(4,1,'惠普（HP）EliteBook 1040','8200.00','7999.00',45,34,NULL,NULL),(5,1,'戴尔(DELL) 游匣15PR-2648B','6100.00','5999.00',36,21,NULL,NULL),(6,2,'英特尔（Intel）酷睿四核 i7-6700k','2780.00','2649.00',13,1,NULL,NULL),(7,2,'英特尔（Intel）酷睿四核 i5-6500','1689.00','1469.00',42,12,NULL,NULL),(8,2,'英特尔（Intel）酷睿双核 i3-6100','899.00','819.00',7,3,NULL,NULL),(9,2,'AMD APU系列 A8-7650K','550.00','539.00',43,12,NULL,NULL),(10,3,'三星(SAMSUNG) 750 EVO 250G','599.00','599.00',100,44,NULL,NULL),(11,3,'金士顿(Kingston)V300 120G','389.00','385.00',23,10,NULL,NULL),(12,3,'英睿达(Crucial)MX300系列 750G','1299.00','1199.00',6,3,NULL,NULL),(13,4,'金士顿(Kingston)骇客神条8G','388.00','369.00',48,8,NULL,NULL),(14,4,'海盗船(USCORSAIR) 复仇者8G','388.00','349.00',76,37,NULL,NULL),(15,4,'金士顿(Kingston)低电压版 DDR3 1600 4GB','199.00','189.00',41,15,NULL,NULL),(16,5,'索泰（ZOTAC）Geforce GTX1060','2100.00','1999.00',5,7,NULL,NULL),(17,5,'技嘉（GIGABYTE） GTX1080','5999.00','5899.00',1,2,NULL,NULL),(18,5,'迪兰（Dataland）RX 460 ','1099.00','999.00',32,19,NULL,NULL),(19,5,'影驰（Galaxy）GTX 1050黑将','1099.00','999.00',41,1,NULL,NULL),(20,6,'Beats Solo2 Wireless','1799.00','1299.00',109,87,NULL,NULL),(21,6,'森海塞尔（Sennheiser） IE80','1999.00','1999.00',4,3,NULL,NULL),(22,6,'索尼（SONY）XBA-N3AP','2399.00','2199.00',12,9,NULL,NULL),(23,6,'飞利浦（PHILIPS） SHE6000','78.00','69.00',299,54,NULL,NULL);

/*Table structure for table `protypes` */

DROP TABLE IF EXISTS `protypes`;

CREATE TABLE `protypes` (
  `TypeID` int(11) NOT NULL AUTO_INCREMENT,
  `TypeName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`TypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `protypes` */

insert  into `protypes`(`TypeID`,`TypeName`) values (1,'笔记本'),(2,'CPU'),(3,'固态硬盘'),(4,'内存'),(5,'显卡'),(6,'耳机');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
