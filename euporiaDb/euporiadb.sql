-- MySQL dump 10.13  Distrib 5.6.31, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: euporiadb
-- ------------------------------------------------------
-- Server version	5.6.31-0ubuntu0.14.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `euporiadb`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `euporiadb` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `euporiadb`;

--
-- Table structure for table `hashtags`
--

DROP TABLE IF EXISTS `hashtags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hashtags` (
  `id` int(11) NOT NULL,
  `hashtag` text,
  `beg` int(11) DEFAULT NULL,
  `end` int(11) DEFAULT NULL,
  `annoid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `beg_idx` (`beg`),
  KEY `end_idx` (`end`),
  KEY `hashtag` (`hashtag`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `progtrag`
--

DROP TABLE IF EXISTS `progtrag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `progtrag` (
  `trag` int(11) DEFAULT NULL,
  `progt` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `ref_hashtags`
--

DROP TABLE IF EXISTS `ref_hashtags`;
/*!50001 DROP VIEW IF EXISTS `ref_hashtags`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `ref_hashtags` AS SELECT 
 1 AS `id`,
 1 AS `hashtag`,
 1 AS `beg`,
 1 AS `end`,
 1 AS `annoid`,
 1 AS `beg_auth`,
 1 AS `beg_work`,
 1 AS `beg_line`,
 1 AS `beg_lineadd`,
 1 AS `beg_token`,
 1 AS `end_auth`,
 1 AS `end_work`,
 1 AS `end_line`,
 1 AS `end_lineadd`,
 1 AS `end_token`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `titles`
--

DROP TABLE IF EXISTS `titles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `titles` (
  `prog` int(11) DEFAULT NULL,
  `id` int(11) DEFAULT NULL,
  `progt` int(11) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `work` varchar(255) DEFAULT NULL,
  `short_author` varchar(255) DEFAULT NULL,
  `short_work` varchar(255) DEFAULT NULL,
  KEY `progt_idx` (`progt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL,
  `line` int(11) DEFAULT NULL,
  `lineadd` varchar(11) DEFAULT NULL,
  `speechid` int(11) DEFAULT NULL,
  `progt` int(11) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `word` varchar(255) DEFAULT NULL,
  `br` varchar(2) DEFAULT NULL,
  `short_author` varchar(255) DEFAULT NULL,
  `short_work` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `progt_idx` (`progt`),
  KEY `line_idx` (`line`),
  KEY `lineadd_idx` (`lineadd`),
  KEY `token_idx` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tragedies`
--

DROP TABLE IF EXISTS `tragedies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tragedies` (
  `id` int(11) NOT NULL DEFAULT '0',
  `trag` int(11) DEFAULT NULL,
  `n` int(11) DEFAULT NULL,
  `speaker` mediumtext,
  `speech` mediumtext,
  `annotation` mediumtext,
  `progt` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `trag_idx` (`trag`),
  KEY `n_idx` (`n`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'euporiadb'
--

--
-- Dumping routines for database 'euporiadb'
--
/*!50003 DROP PROCEDURE IF EXISTS `curdemo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`federico`@`localhost` PROCEDURE `curdemo`()
begin declare beg, end int; declare cur1 cursor for select beg,end from ref_hashtags; open cur1;fetch cur1 into beg,end; select * from ref_hashtags where ref_hashtags.beg>=beg and ref_hashtags.end<=end; drop table if exists temptab;create temporary table temptab as select * from ref_hashtags limit 10; end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `intersectproc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`federico`@`localhost` PROCEDURE `intersectproc`(in ht1par varchar(255), ht2par varchar(255),befbeg int, aftend int)
    READS SQL DATA
begin
declare begv int default 0;
declare endv int default 0;
declare finished int default 0;
declare cur1 cursor for select hashtags.beg, hashtags.end from hashtags where hashtag=ht1par;
declare continue handler for not found set finished=1;
open cur1;
set autocommit=0;
drop table if exists htemp1;
create temporary table htemp1(id int primary key auto_increment, beg int, end int);
loop1: loop
       fetch cur1 into begv, endv;
       set begv=begv-befbeg;
       set endv=endv+aftend;
       insert into htemp1 (htemp1.beg, htemp1.end) select greatest(hashtags.beg, begv), least(hashtags.end,endv) from hashtags where hashtag=ht2par and ((hashtags.beg>=begv and hashtags.beg<=endv) or (begv>=hashtags.beg and begv<=hashtags.end));
       if finished=1 then
          leave loop1;
       end if;
end loop loop1;
close cur1;
select (h.id+0) as id, (h.beg+0) as beg, concat(t1.short_author,'') as bauth, concat(t1.short_work,'') as bwork, concat(t1.lineadd,'') as bline, concat(t1.token,'') as btoken, (h.end+0) as end, concat(t2.short_author,'') as eauth, concat(t2.short_work,'') as ework, concat(t2.lineadd,'') as eline, concat(t2.token,'') as etoken from htemp1 as h left join tokens as t1 on h.beg=t1.id left join tokens as t2 on h.end=t2.id;
drop table if exists htemp1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `procdemo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`federico`@`localhost` PROCEDURE `procdemo`()
    READS SQL DATA
begin
select * from titles;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `showhashtags` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`federico`@`localhost` PROCEDURE `showhashtags`(currbeg int, currend int, befbeg int, aftend int)
    READS SQL DATA
begin
select h.hashtag as hashtag, concat(t1.short_author,'') as bauth, concat(t1.short_work,'') as bwork, concat(t1.lineadd,'') as bline, concat(t1.token,'') as btoken, concat(t2.short_author,'') as eauth, concat(t2.short_work,'') as ework, concat(t2.lineadd,'') as eline, concat(t2.token,'') as etoken from hashtags as h left join tokens as t1 on h.beg=t1.id left join tokens as t2 on h.end=t2.id where (currbeg>=beg-befbeg and currbeg<=end+aftend) or (beg-befbeg>=currbeg and beg-befbeg<=currend) order by annoid;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `euporiadb`
--

USE `euporiadb`;

--
-- Final view structure for view `ref_hashtags`
--

/*!50001 DROP VIEW IF EXISTS `ref_hashtags`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`federico`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ref_hashtags` AS select `hashtags`.`id` AS `id`,`hashtags`.`hashtag` AS `hashtag`,`hashtags`.`beg` AS `beg`,`hashtags`.`end` AS `end`,`hashtags`.`annoid` AS `annoid`,`t1`.`short_author` AS `beg_auth`,`t1`.`short_work` AS `beg_work`,`t1`.`line` AS `beg_line`,`t1`.`lineadd` AS `beg_lineadd`,`t1`.`token` AS `beg_token`,`t2`.`short_author` AS `end_auth`,`t2`.`short_work` AS `end_work`,`t2`.`line` AS `end_line`,`t2`.`lineadd` AS `end_lineadd`,`t2`.`token` AS `end_token` from ((`hashtags` left join `tokens` `t1` on((`hashtags`.`beg` = `t1`.`id`))) left join `tokens` `t2` on((`hashtags`.`end` = `t2`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-11-15 12:56:30
