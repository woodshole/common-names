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
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iso_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `english_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `native_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=205 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'aa','Afar',NULL,NULL,NULL),(2,'ab','Abkhazian',NULL,NULL,NULL),(3,'af','Afrikaans',NULL,NULL,NULL),(4,'ak','Akan',NULL,NULL,NULL),(5,'sq','Albanian',NULL,NULL,NULL),(6,'am','Amharic',NULL,NULL,NULL),(7,'ar','Arabic',NULL,NULL,NULL),(8,'an','Aragonese',NULL,NULL,NULL),(9,'hy','Armenian',NULL,NULL,NULL),(10,'as','Assamese',NULL,NULL,NULL),(11,'av','Avaric',NULL,NULL,NULL),(12,'ae','Avestan',NULL,NULL,NULL),(13,'ay','Aymara',NULL,NULL,NULL),(14,'az','Azerbaijani',NULL,NULL,NULL),(15,'ba','Bashkir',NULL,NULL,NULL),(16,'bm','Bambara',NULL,NULL,NULL),(17,'eu','Basque',NULL,NULL,NULL),(18,'be','Belarusian',NULL,NULL,NULL),(19,'bn','Bengali',NULL,NULL,NULL),(20,'bh','Bihari languages',NULL,NULL,NULL),(21,'bi','Bislama',NULL,NULL,NULL),(22,'bo','Tibetan',NULL,NULL,NULL),(23,'bs','Bosnian',NULL,NULL,NULL),(24,'br','Breton',NULL,NULL,NULL),(25,'bg','Bulgarian',NULL,NULL,NULL),(26,'my','Burmese',NULL,NULL,NULL),(27,'ca','Catalan; Valencian',NULL,NULL,NULL),(28,'cs','Czech',NULL,NULL,NULL),(29,'ch','Chamorro',NULL,NULL,NULL),(30,'ce','Chechen',NULL,NULL,NULL),(31,'zh','Chinese',NULL,NULL,NULL),(32,'cu','Church Slavic; Old Slavonic; Church Slavonic; Old Bulgarian; Old Church Slavonic',NULL,NULL,NULL),(33,'cv','Chuvash',NULL,NULL,NULL),(34,'kw','Cornish',NULL,NULL,NULL),(35,'co','Corsican',NULL,NULL,NULL),(36,'cr','Cree',NULL,NULL,NULL),(37,'cy','Welsh',NULL,NULL,NULL),(39,'da','Danish',NULL,NULL,NULL),(40,'de','German',NULL,NULL,NULL),(41,'dv','Divehi; Dhivehi; Maldivian',NULL,NULL,NULL),(42,'nl','Dutch; Flemish',NULL,NULL,NULL),(43,'dz','Dzongkha',NULL,NULL,NULL),(44,'el','Greek',NULL,NULL,NULL),(45,'en','English',NULL,NULL,NULL),(46,'eo','Esperanto',NULL,NULL,NULL),(47,'et','Estonian',NULL,NULL,NULL),(49,'ee','Ewe',NULL,NULL,NULL),(50,'fo','Faroese',NULL,NULL,NULL),(51,'fa','Persian',NULL,NULL,NULL),(52,'fj','Fijian',NULL,NULL,NULL),(53,'fi','Finnish',NULL,NULL,NULL),(54,'fr','French',NULL,NULL,NULL),(56,'fy','Western Frisian',NULL,NULL,NULL),(57,'ff','Fulah',NULL,NULL,NULL),(58,'ka','Georgian',NULL,NULL,NULL),(60,'gd','Gaelic; Scottish Gaelic',NULL,NULL,NULL),(61,'ga','Irish',NULL,NULL,NULL),(62,'gl','Galician',NULL,NULL,NULL),(63,'gv','Manx',NULL,NULL,NULL),(65,'gn','Guarani',NULL,NULL,NULL),(66,'gu','Gujarati',NULL,NULL,NULL),(67,'ht','Haitian; Haitian Creole',NULL,NULL,NULL),(68,'ha','Hausa',NULL,NULL,NULL),(69,'he','Hebrew',NULL,NULL,NULL),(70,'hz','Herero',NULL,NULL,NULL),(71,'hi','Hindi',NULL,NULL,NULL),(72,'ho','Hiri Motu',NULL,NULL,NULL),(73,'hr','Croatian',NULL,NULL,NULL),(74,'hu','Hungarian',NULL,NULL,NULL),(76,'ig','Igbo',NULL,NULL,NULL),(77,'is','Icelandic',NULL,NULL,NULL),(78,'io','Ido',NULL,NULL,NULL),(79,'ii','Sichuan Yi; Nuosu',NULL,NULL,NULL),(80,'iu','Inuktitut',NULL,NULL,NULL),(81,'ie','Interlingue; Occidental',NULL,NULL,NULL),(82,'ia','Interlingua (International Auxiliary Language Association)',NULL,NULL,NULL),(83,'id','Indonesian',NULL,NULL,NULL),(84,'ik','Inupiaq',NULL,NULL,NULL),(86,'it','Italian',NULL,NULL,NULL),(87,'jv','Javanese',NULL,NULL,NULL),(88,'ja','Japanese',NULL,NULL,NULL),(89,'kl','Kalaallisut; Greenlandic',NULL,NULL,NULL),(90,'kn','Kannada',NULL,NULL,NULL),(91,'ks','Kashmiri',NULL,NULL,NULL),(93,'kr','Kanuri',NULL,NULL,NULL),(94,'kk','Kazakh',NULL,NULL,NULL),(95,'km','Central Khmer',NULL,NULL,NULL),(96,'ki','Kikuyu; Gikuyu',NULL,NULL,NULL),(97,'rw','Kinyarwanda',NULL,NULL,NULL),(98,'ky','Kirghiz; Kyrgyz',NULL,NULL,NULL),(99,'kv','Komi',NULL,NULL,NULL),(100,'kg','Kongo',NULL,NULL,NULL),(101,'ko','Korean',NULL,NULL,NULL),(102,'kj','Kuanyama; Kwanyama',NULL,NULL,NULL),(103,'ku','Kurdish',NULL,NULL,NULL),(104,'lo','Lao',NULL,NULL,NULL),(105,'la','Latin',NULL,NULL,NULL),(106,'lv','Latvian',NULL,NULL,NULL),(107,'li','Limburgan; Limburger; Limburgish',NULL,NULL,NULL),(108,'ln','Lingala',NULL,NULL,NULL),(109,'lt','Lithuanian',NULL,NULL,NULL),(110,'lb','Luxembourgish; Letzeburgesch',NULL,NULL,NULL),(111,'lu','Luba-Katanga',NULL,NULL,NULL),(112,'lg','Ganda',NULL,NULL,NULL),(113,'mk','Macedonian',NULL,NULL,NULL),(114,'mh','Marshallese',NULL,NULL,NULL),(115,'ml','Malayalam',NULL,NULL,NULL),(116,'mi','Maori',NULL,NULL,NULL),(117,'mr','Marathi',NULL,NULL,NULL),(118,'ms','Malay',NULL,NULL,NULL),(120,'mg','Malagasy',NULL,NULL,NULL),(121,'mt','Maltese',NULL,NULL,NULL),(122,'mn','Mongolian',NULL,NULL,NULL),(126,'na','Nauru',NULL,NULL,NULL),(127,'nv','Navajo; Navaho',NULL,NULL,NULL),(128,'nr','Ndebele',NULL,NULL,NULL),(129,'nd','Ndebele',NULL,NULL,NULL),(130,'ng','Ndonga',NULL,NULL,NULL),(131,'ne','Nepali',NULL,NULL,NULL),(133,'nn','Norwegian Nynorsk; Nynorsk',NULL,NULL,NULL),(134,'nb','Bokmål',NULL,NULL,NULL),(135,'no','Norwegian',NULL,NULL,NULL),(136,'ny','Chichewa; Chewa; Nyanja',NULL,NULL,NULL),(137,'oc','Occitan (post 1500)',NULL,NULL,NULL),(138,'oj','Ojibwa',NULL,NULL,NULL),(139,'or','Oriya',NULL,NULL,NULL),(140,'om','Oromo',NULL,NULL,NULL),(141,'os','Ossetian; Ossetic',NULL,NULL,NULL),(142,'pa','Panjabi; Punjabi',NULL,NULL,NULL),(144,'pi','Pali',NULL,NULL,NULL),(145,'pl','Polish',NULL,NULL,NULL),(146,'pt','Portuguese',NULL,NULL,NULL),(147,'ps','Pushto; Pashto',NULL,NULL,NULL),(148,'qu','Quechua',NULL,NULL,NULL),(149,'rm','Romansh',NULL,NULL,NULL),(150,'ro','Romanian; Moldavian; Moldovan',NULL,NULL,NULL),(152,'rn','Rundi',NULL,NULL,NULL),(153,'ru','Russian',NULL,NULL,NULL),(154,'sg','Sango',NULL,NULL,NULL),(155,'sa','Sanskrit',NULL,NULL,NULL),(156,'si','Sinhala; Sinhalese',NULL,NULL,NULL),(157,'sk','Slovak',NULL,NULL,NULL),(159,'sl','Slovenian',NULL,NULL,NULL),(160,'se','Northern Sami',NULL,NULL,NULL),(161,'sm','Samoan',NULL,NULL,NULL),(162,'sn','Shona',NULL,NULL,NULL),(163,'sd','Sindhi',NULL,NULL,NULL),(164,'so','Somali',NULL,NULL,NULL),(165,'st','Sotho',NULL,NULL,NULL),(166,'es','Spanish; Castilian',NULL,NULL,NULL),(168,'sc','Sardinian',NULL,NULL,NULL),(169,'sr','Serbian',NULL,NULL,NULL),(170,'ss','Swati',NULL,NULL,NULL),(171,'su','Sundanese',NULL,NULL,NULL),(172,'sw','Swahili',NULL,NULL,NULL),(173,'sv','Swedish',NULL,NULL,NULL),(174,'ty','Tahitian',NULL,NULL,NULL),(175,'ta','Tamil',NULL,NULL,NULL),(176,'tt','Tatar',NULL,NULL,NULL),(177,'te','Telugu',NULL,NULL,NULL),(178,'tg','Tajik',NULL,NULL,NULL),(179,'tl','Tagalog',NULL,NULL,NULL),(180,'th','Thai',NULL,NULL,NULL),(182,'ti','Tigrinya',NULL,NULL,NULL),(183,'to','Tonga (Tonga Islands)',NULL,NULL,NULL),(184,'tn','Tswana',NULL,NULL,NULL),(185,'ts','Tsonga',NULL,NULL,NULL),(186,'tk','Turkmen',NULL,NULL,NULL),(187,'tr','Turkish',NULL,NULL,NULL),(188,'tw','Twi',NULL,NULL,NULL),(189,'ug','Uighur; Uyghur',NULL,NULL,NULL),(190,'uk','Ukrainian',NULL,NULL,NULL),(191,'ur','Urdu',NULL,NULL,NULL),(192,'uz','Uzbek',NULL,NULL,NULL),(193,'ve','Venda',NULL,NULL,NULL),(194,'vi','Vietnamese',NULL,NULL,NULL),(195,'vo','Volapük',NULL,NULL,NULL),(197,'wa','Walloon',NULL,NULL,NULL),(198,'wo','Wolof',NULL,NULL,NULL),(199,'xh','Xhosa',NULL,NULL,NULL),(200,'yi','Yiddish',NULL,NULL,NULL),(201,'yo','Yoruba',NULL,NULL,NULL),(202,'za','Zhuang; Chuang',NULL,NULL,NULL),(204,'zu','Zulu',NULL,NULL,NULL);
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-05-11 14:47:24
