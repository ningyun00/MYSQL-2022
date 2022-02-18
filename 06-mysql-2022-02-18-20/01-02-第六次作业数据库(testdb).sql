/*
SQLyog Professional v12.08 (64 bit)
MySQL - 5.6.31-log : Database - testdb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`testdb` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `testdb`;

/*Table structure for table `sales` */

DROP TABLE IF EXISTS `sales`;

CREATE TABLE `sales` (
  `syear` int(11) DEFAULT NULL,
  `squarter` int(11) DEFAULT NULL,
  `samount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

/*Data for the table `sales` */

insert  into `sales`(`syear`,`squarter`,`samount`) values (2010,1,1000),(2010,1,2100),(2010,2,2000),(2010,2,2300),(2010,3,1400),(2010,4,2200),(2010,4,1400),(2011,1,1500),(2011,1,800);

/*Table structure for table `teams` */

DROP TABLE IF EXISTS `teams`;

CREATE TABLE `teams` (
  `teamID` int(11) NOT NULL AUTO_INCREMENT,
  `teamName` varchar(50) DEFAULT NULL,
  `teamDate` datetime DEFAULT NULL,
  `teamResult` char(1) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`teamID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=gbk;

/*Data for the table `teams` */

insert  into `teams`(`teamID`,`teamName`,`teamDate`,`teamResult`) values (1,'芝加哥公牛','2010-04-03 00:00:00','胜'),(2,'洛杉矶湖人','2010-04-03 00:00:00','败'),(3,'休斯顿火箭','2010-04-03 00:00:00','胜'),(4,'休斯顿火箭','2010-04-04 00:00:00','胜'),(5,'休斯顿火箭','2010-04-05 00:00:00','败'),(6,'洛杉矶湖人','2010-04-05 00:00:00','败'),(7,'芝加哥公牛','2010-04-06 00:00:00','胜'),(8,'洛杉矶湖人','2010-04-07 00:00:00','败'),(9,'休斯顿火箭','2010-04-08 00:00:00','胜'),(10,'洛杉矶湖人','2010-04-07 00:00:00','胜'),(11,'芝加哥公牛','2010-04-08 00:00:00','败');

/*Table structure for table `test1` */

DROP TABLE IF EXISTS `test1`;

CREATE TABLE `test1` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `sno` varchar(10) DEFAULT NULL,
  `smoney` int(11) DEFAULT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=gbk;

/*Data for the table `test1` */

insert  into `test1`(`sid`,`sno`,`smoney`) values (1,'张三',1000),(2,'张三',2000),(3,'王五',800),(4,'李四',400),(5,'张三',-600),(6,'李四',-700),(7,'李四',6000),(8,'王五',-400),(9,'王五',200);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
