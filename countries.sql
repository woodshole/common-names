-- MySQL dump 10.13  Distrib 5.1.43, for apple-darwin10.2.0 (i386)
--
-- Host: localhost    Database: common_names_development
-- ------------------------------------------------------
-- Server version	5.1.43

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
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `iso_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=248 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'AFGHANISTAN','AF'),(2,'ÅLAND ISLANDS','AX'),(3,'ALBANIA','AL'),(4,'ALGERIA','DZ'),(5,'AMERICAN SAMOA','AS'),(6,'ANDORRA','AD'),(7,'ANGOLA','AO'),(8,'ANGUILLA','AI'),(9,'ANTARCTICA','AQ'),(10,'ANTIGUA AND BARBUDA','AG'),(11,'ARGENTINA','AR'),(12,'ARMENIA','AM'),(13,'ARUBA','AW'),(14,'AUSTRALIA','AU'),(15,'AUSTRIA','AT'),(16,'AZERBAIJAN','AZ'),(17,'BAHAMAS','BS'),(18,'BAHRAIN','BH'),(19,'BANGLADESH','BD'),(20,'BARBADOS','BB'),(21,'BELARUS','BY'),(22,'BELGIUM','BE'),(23,'BELIZE','BZ'),(24,'BENIN','BJ'),(25,'BERMUDA','BM'),(26,'BHUTAN','BT'),(27,'BOLIVIA, PLURINATIONAL STATE OF','BO'),(28,'BOSNIA AND HERZEGOVINA','BA'),(29,'BOTSWANA','BW'),(30,'BOUVET ISLAND','BV'),(31,'BRAZIL','BR'),(32,'BRITISH INDIAN OCEAN TERRITORY','IO'),(33,'BRUNEI DARUSSALAM','BN'),(34,'BULGARIA','BG'),(35,'BURKINA FASO','BF'),(36,'BURUNDI','BI'),(37,'CAMBODIA','KH'),(38,'CAMEROON','CM'),(39,'CANADA','CA'),(40,'CAPE VERDE','CV'),(41,'CAYMAN ISLANDS','KY'),(42,'CENTRAL AFRICAN REPUBLIC','CF'),(43,'CHAD','TD'),(44,'CHILE','CL'),(45,'CHINA','CN'),(46,'CHRISTMAS ISLAND','CX'),(47,'COCOS (KEELING) ISLANDS','CC'),(48,'COLOMBIA','CO'),(49,'COMOROS','KM'),(50,'CONGO','CG'),(51,'CONGO, THE DEMOCRATIC REPUBLIC OF THE','CD'),(52,'COOK ISLANDS','CK'),(53,'COSTA RICA','CR'),(54,'CÔTE D\'IVOIRE','CI'),(55,'CROATIA','HR'),(56,'CUBA','CU'),(57,'CYPRUS','CY'),(58,'CZECH REPUBLIC','CZ'),(59,'DENMARK','DK'),(60,'DJIBOUTI','DJ'),(61,'DOMINICA','DM'),(62,'DOMINICAN REPUBLIC','DO'),(63,'ECUADOR','EC'),(64,'EGYPT','EG'),(65,'EL SALVADOR','SV'),(66,'EQUATORIAL GUINEA','GQ'),(67,'ERITREA','ER'),(68,'ESTONIA','EE'),(69,'ETHIOPIA','ET'),(70,'FALKLAND ISLANDS (MALVINAS)','FK'),(71,'FAROE ISLANDS','FO'),(72,'FIJI','FJ'),(73,'FINLAND','FI'),(74,'FRANCE','FR'),(75,'FRENCH GUIANA','GF'),(76,'FRENCH POLYNESIA','PF'),(77,'FRENCH SOUTHERN TERRITORIES','TF'),(78,'GABON','GA'),(79,'GAMBIA','GM'),(80,'GEORGIA','GE'),(81,'GERMANY','DE'),(82,'GHANA','GH'),(83,'GIBRALTAR','GI'),(84,'GREECE','GR'),(85,'GREENLAND','GL'),(86,'GRENADA','GD'),(87,'GUADELOUPE','GP'),(88,'GUAM','GU'),(89,'GUATEMALA','GT'),(90,'GUERNSEY','GG'),(91,'GUINEA','GN'),(92,'GUINEA-BISSAU','GW'),(93,'GUYANA','GY'),(94,'HAITI','HT'),(95,'HEARD ISLAND AND MCDONALD ISLANDS','HM'),(96,'HOLY SEE (VATICAN CITY STATE)','VA'),(97,'HONDURAS','HN'),(98,'HONG KONG','HK'),(99,'HUNGARY','HU'),(100,'ICELAND','IS'),(101,'INDIA','IN'),(102,'INDONESIA','ID'),(103,'IRAN, ISLAMIC REPUBLIC OF','IR'),(104,'IRAQ','IQ'),(105,'IRELAND','IE'),(106,'ISLE OF MAN','IM'),(107,'ISRAEL','IL'),(108,'ITALY','IT'),(109,'JAMAICA','JM'),(110,'JAPAN','JP'),(111,'JERSEY','JE'),(112,'JORDAN','JO'),(113,'KAZAKHSTAN','KZ'),(114,'KENYA','KE'),(115,'KIRIBATI','KI'),(116,'KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF','KP'),(117,'KOREA, REPUBLIC OF','KR'),(118,'KUWAIT','KW'),(119,'KYRGYZSTAN','KG'),(120,'LAO PEOPLE\'S DEMOCRATIC REPUBLIC','LA'),(121,'LATVIA','LV'),(122,'LEBANON','LB'),(123,'LESOTHO','LS'),(124,'LIBERIA','LR'),(125,'LIBYAN ARAB JAMAHIRIYA','LY'),(126,'LIECHTENSTEIN','LI'),(127,'LITHUANIA','LT'),(128,'LUXEMBOURG','LU'),(129,'MACAO','MO'),(130,'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF','MK'),(131,'MADAGASCAR','MG'),(132,'MALAWI','MW'),(133,'MALAYSIA','MY'),(134,'MALDIVES','MV'),(135,'MALI','ML'),(136,'MALTA','MT'),(137,'MARSHALL ISLANDS','MH'),(138,'MARTINIQUE','MQ'),(139,'MAURITANIA','MR'),(140,'MAURITIUS','MU'),(141,'MAYOTTE','YT'),(142,'MEXICO','MX'),(143,'MICRONESIA, FEDERATED STATES OF','FM'),(144,'MOLDOVA, REPUBLIC OF','MD'),(145,'MONACO','MC'),(146,'MONGOLIA','MN'),(147,'MONTENEGRO','ME'),(148,'MONTSERRAT','MS'),(149,'MOROCCO','MA'),(150,'MOZAMBIQUE','MZ'),(151,'MYANMAR','MM'),(152,'NAMIBIA','NA'),(153,'NAURU','NR'),(154,'NEPAL','NP'),(155,'NETHERLANDS','NL'),(156,'NETHERLANDS ANTILLES','AN'),(157,'NEW CALEDONIA','NC'),(158,'NEW ZEALAND','NZ'),(159,'NICARAGUA','NI'),(160,'NIGER','NE'),(161,'NIGERIA','NG'),(162,'NIUE','NU'),(163,'NORFOLK ISLAND','NF'),(164,'NORTHERN MARIANA ISLANDS','MP'),(165,'NORWAY','NO'),(166,'OMAN','OM'),(167,'PAKISTAN','PK'),(168,'PALAU','PW'),(169,'PALESTINIAN TERRITORY, OCCUPIED','PS'),(170,'PANAMA','PA'),(171,'PAPUA NEW GUINEA','PG'),(172,'PARAGUAY','PY'),(173,'PERU','PE'),(174,'PHILIPPINES','PH'),(175,'PITCAIRN','PN'),(176,'POLAND','PL'),(177,'PORTUGAL','PT'),(178,'PUERTO RICO','PR'),(179,'QATAR','QA'),(180,'RÉUNION','RE'),(181,'ROMANIA','RO'),(182,'RUSSIAN FEDERATION','RU'),(183,'RWANDA','RW'),(184,'SAINT BARTHÉLEMY','BL'),(185,'SAINT HELENA, ASCENSION AND TRISTAN DA CUNHA','SH'),(186,'SAINT KITTS AND NEVIS','KN'),(187,'SAINT LUCIA','LC'),(188,'SAINT MARTIN','MF'),(189,'SAINT PIERRE AND MIQUELON','PM'),(190,'SAINT VINCENT AND THE GRENADINES','VC'),(191,'SAMOA','WS'),(192,'SAN MARINO','SM'),(193,'SAO TOME AND PRINCIPE','ST'),(194,'SAUDI ARABIA','SA'),(195,'SENEGAL','SN'),(196,'SERBIA','RS'),(197,'SEYCHELLES','SC'),(198,'SIERRA LEONE','SL'),(199,'SINGAPORE','SG'),(200,'SLOVAKIA','SK'),(201,'SLOVENIA','SI'),(202,'SOLOMON ISLANDS','SB'),(203,'SOMALIA','SO'),(204,'SOUTH AFRICA','ZA'),(205,'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS','GS'),(206,'SPAIN','ES'),(207,'SRI LANKA','LK'),(208,'SUDAN','SD'),(209,'SURINAME','SR'),(210,'SVALBARD AND JAN MAYEN','SJ'),(211,'SWAZILAND','SZ'),(212,'SWEDEN','SE'),(213,'SWITZERLAND','CH'),(214,'SYRIAN ARAB REPUBLIC','SY'),(215,'TAIWAN, PROVINCE OF CHINA','TW'),(216,'TAJIKISTAN','TJ'),(217,'TANZANIA, UNITED REPUBLIC OF','TZ'),(218,'THAILAND','TH'),(219,'TIMOR-LESTE','TL'),(220,'TOGO','TG'),(221,'TOKELAU','TK'),(222,'TONGA','TO'),(223,'TRINIDAD AND TOBAGO','TT'),(224,'TUNISIA','TN'),(225,'TURKEY','TR'),(226,'TURKMENISTAN','TM'),(227,'TURKS AND CAICOS ISLANDS','TC'),(228,'TUVALU','TV'),(229,'UGANDA','UG'),(230,'UKRAINE','UA'),(231,'UNITED ARAB EMIRATES','AE'),(232,'UNITED KINGDOM','GB'),(233,'UNITED STATES','US'),(234,'UNITED STATES MINOR OUTLYING ISLANDS','UM'),(235,'URUGUAY','UY'),(236,'UZBEKISTAN','UZ'),(237,'VANUATU','VU'),(238,'VATICAN CITY STATE  see HOLY S','EE'),(239,'VENEZUELA, BOLIVARIAN REPUBLIC OF','VE'),(240,'VIET NAM','VN'),(241,'VIRGIN ISLANDS, BRITISH','VG'),(242,'VIRGIN ISLANDS, U.S.','VI'),(243,'WALLIS AND FUTUNA','WF'),(244,'WESTERN SAHARA','EH'),(245,'YEMEN','YE'),(246,'ZAMBIA','ZM'),(247,'ZIMBABWE','ZW');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-05-11 10:31:45
