/*
SQLyog Professional v12.08 (64 bit)
MySQL - 5.6.31-log : Database - mydb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`mydb` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `mydb`;

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `SID` int(11) NOT NULL AUTO_INCREMENT,
  `SName` varchar(10) NOT NULL,
  `SSex` char(1) DEFAULT NULL,
  `SAge` int(11) DEFAULT NULL,
  `SAddress` varchar(200) DEFAULT '地址不详',
  PRIMARY KEY (`SID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `student` */

insert  into `student`(`SID`,`SName`,`SSex`,`SAge`,`SAddress`) values (1,'寜','男',16,'地址不详'),(2,'小','女',17,'地址不详'),(3,'寜','男',18,'地址不详'),(4,'寜','女',19,'地球');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
