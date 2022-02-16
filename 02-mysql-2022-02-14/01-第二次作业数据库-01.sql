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
  `AssCusID` int(11) DEFAULT NULL,
  `AssProID` int(11) DEFAULT NULL,
  `AssContent` varchar(5000) DEFAULT NULL,
  `AssDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`AssID`),
  KEY `fk_Customers_Assess` (`AssCusID`),
  KEY `fk_Products_Assess` (`AssProID`),
  CONSTRAINT `fk_Customers_Assess` FOREIGN KEY (`AssCusID`) REFERENCES `customers` (`CusID`),
  CONSTRAINT `fk_Products_Assess` FOREIGN KEY (`AssProID`) REFERENCES `products` (`ProID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `assess` */

insert  into `assess`(`AssID`,`AssCusID`,`AssProID`,`AssContent`,`AssDate`) values (1,1,1,'打杂阿萨的菌丝','2022-02-14 17:08:55'),(2,1,1,'打杂阿萨的啊你发刺激菌丝','2022-02-14 17:09:09');

/*Table structure for table `cusadds` */

DROP TABLE IF EXISTS `cusadds`;

CREATE TABLE `cusadds` (
  `CAID` int(11) NOT NULL AUTO_INCREMENT,
  `CACusID` int(11) DEFAULT NULL,
  `CAProvince` varchar(100) DEFAULT NULL,
  `CACity` varchar(100) DEFAULT NULL,
  `CAAddress` varchar(500) DEFAULT NULL,
  `CADefault` bit(1) DEFAULT b'0',
  PRIMARY KEY (`CAID`),
  KEY `fk_Customers_Cusadds` (`CACusID`),
  CONSTRAINT `fk_Customers_Cusadds` FOREIGN KEY (`CACusID`) REFERENCES `customers` (`CusID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `cusadds` */

insert  into `cusadds`(`CAID`,`CACusID`,`CAProvince`,`CACity`,`CAAddress`,`CADefault`) values (1,1,'不知道','不知道','不知道','\0'),(2,1,'不知道','不知道','不知道','\0'),(3,1,'不知道','不知道','不知道','');

/*Table structure for table `customers` */

DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `CusID` int(11) NOT NULL AUTO_INCREMENT,
  `CusNick` varchar(50) DEFAULT NULL,
  `CusLogin` varchar(50) DEFAULT NULL,
  `CusPwd` varchar(50) DEFAULT NULL,
  `CusPoint` int(11) DEFAULT NULL,
  `CusCreateData` datetime DEFAULT CURRENT_TIMESTAMP,
  `CusLoginDate` datetime DEFAULT NULL,
  PRIMARY KEY (`CusID`),
  UNIQUE KEY `CusNick` (`CusNick`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `customers` */

insert  into `customers`(`CusID`,`CusNick`,`CusLogin`,`CusPwd`,`CusPoint`,`CusCreateData`,`CusLoginDate`) values (1,'小樱','xiaoying','xiaoying01',0,'2022-02-14 15:30:43',NULL),(4,'樱花','yinghua','yinghua02',30,'2022-02-14 15:35:27',NULL);

/*Table structure for table `orderdetail` */

DROP TABLE IF EXISTS `orderdetail`;

CREATE TABLE `orderdetail` (
  `ODID` int(11) NOT NULL AUTO_INCREMENT,
  `ODrderNum` int(11) DEFAULT NULL,
  `ODCount` int(11) DEFAULT NULL,
  `ODPrice` decimal(10,2) DEFAULT NULL,
  `ODProID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ODID`),
  KEY `fk_Orders_OrderDetail` (`ODrderNum`),
  KEY `fk_Products_OrderDetail` (`ODProID`),
  CONSTRAINT `fk_Orders_OrderDetail` FOREIGN KEY (`ODrderNum`) REFERENCES `orders` (`OrderNum`),
  CONSTRAINT `fk_Products_OrderDetail` FOREIGN KEY (`ODProID`) REFERENCES `products` (`ProID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `orderdetail` */

insert  into `orderdetail`(`ODID`,`ODrderNum`,`ODCount`,`ODPrice`,`ODProID`) values (1,1,1,'1.00',1),(2,1,1,'1.00',1);

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `OrderNum` int(11) NOT NULL AUTO_INCREMENT,
  `OrdCAID` int(11) DEFAULT NULL,
  `OrdCusID` int(11) DEFAULT NULL,
  `OrderDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`OrderNum`),
  KEY `fk_CusAdds_Orders` (`OrdCAID`),
  KEY `fk_Products_Orders` (`OrdCusID`),
  CONSTRAINT `fk_CusAdds_Orders` FOREIGN KEY (`OrdCAID`) REFERENCES `cusadds` (`CAID`),
  CONSTRAINT `fk_Products_Orders` FOREIGN KEY (`OrdCusID`) REFERENCES `customers` (`CusID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `orders` */

insert  into `orders`(`OrderNum`,`OrdCAID`,`OrdCusID`,`OrderDate`) values (1,1,1,'2022-02-14 17:24:10'),(2,1,1,'2022-02-14 17:24:13');

/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `ProID` int(11) NOT NULL AUTO_INCREMENT,
  `ProName` varchar(100) DEFAULT NULL,
  `ProOldPrice` decimal(10,2) DEFAULT NULL,
  `ProNewPrice` decimal(10,2) DEFAULT NULL,
  `ProSale` int(11) DEFAULT NULL,
  `Prodepot` int(11) DEFAULT NULL,
  `ProSaleBegin` datetime DEFAULT NULL,
  `ProSaleEnd` datetime DEFAULT NULL,
  `ProTypeID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ProID`),
  KEY `fk_ProTypes_Products` (`ProTypeID`),
  CONSTRAINT `fk_ProTypes_Products` FOREIGN KEY (`ProTypeID`) REFERENCES `protypes` (`TypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `products` */

insert  into `products`(`ProID`,`ProName`,`ProOldPrice`,`ProNewPrice`,`ProSale`,`Prodepot`,`ProSaleBegin`,`ProSaleEnd`,`ProTypeID`) values (1,'小樱','1.00','2.00',100,200,'2022-02-14 00:00:00','2022-02-15 00:00:00',1),(2,'小樱','1.00','2.00',100,200,'2022-02-14 00:00:00','2022-02-15 00:00:00',1),(3,'樱花','1.00','2.00',100,200,'2022-02-14 00:00:00','2022-02-15 00:00:00',2);

/*Table structure for table `protypes` */

DROP TABLE IF EXISTS `protypes`;

CREATE TABLE `protypes` (
  `TypeID` int(11) NOT NULL AUTO_INCREMENT,
  `TypeName` varchar(100) NOT NULL,
  PRIMARY KEY (`TypeID`),
  UNIQUE KEY `TypeName` (`TypeName`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `protypes` */

insert  into `protypes`(`TypeID`,`TypeName`) values (1,'01'),(2,'02');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
