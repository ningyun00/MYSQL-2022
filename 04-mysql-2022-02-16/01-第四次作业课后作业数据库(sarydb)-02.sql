/*
SQLyog Professional v12.08 (64 bit)
MySQL - 5.6.31-log : Database - sararydb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sararydb` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `sararydb`;

/*Table structure for table `dept` */

DROP TABLE IF EXISTS `dept`;

CREATE TABLE `dept` (
  `DeptNo` int(11) NOT NULL,
  `Dname` varchar(15) NOT NULL,
  `Location` varchar(100) NOT NULL,
  PRIMARY KEY (`DeptNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `dept` */

insert  into `dept`(`DeptNo`,`Dname`,`Location`) values (10,'会计部','纽约'),(20,'调查部','达拉斯'),(30,'销售部','芝加哥'),(40,'业务营运部','波士顿');

/*Table structure for table `emp` */

DROP TABLE IF EXISTS `emp`;

CREATE TABLE `emp` (
  `EmpNo` int(11) NOT NULL,
  `Ename` varchar(40) DEFAULT NULL,
  `Job` varchar(40) DEFAULT NULL,
  `MGR` int(11) DEFAULT NULL,
  `HIREDATE` datetime DEFAULT NULL,
  `Sal` decimal(6,2) DEFAULT NULL,
  `DeptNo` int(11) DEFAULT NULL,
  PRIMARY KEY (`EmpNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `emp` */

insert  into `emp`(`EmpNo`,`Ename`,`Job`,`MGR`,`HIREDATE`,`Sal`,`DeptNo`) values (7369,'SMITH','职员',7902,'1980-12-27 00:00:00','800.00',20),(7499,'ALLEN','销售',7698,'1981-02-20 00:00:00','1600.00',30),(7521,'WARD','销售',7698,'1981-02-22 00:00:00','1250.00',30),(7566,'JONES','经理',7839,'1981-04-22 00:00:00','2975.00',20),(7698,'BLAKE','经理',7839,'1981-05-08 00:00:00','2850.00',30),(7782,'CLARK','经理',7839,'1981-06-09 00:00:00','2450.00',10),(7902,'FORD','研究员',7566,'1981-12-03 00:00:00','3000.00',20),(7934,'MILLER','职员',7782,'1982-01-31 00:00:00','1300.00',40);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
