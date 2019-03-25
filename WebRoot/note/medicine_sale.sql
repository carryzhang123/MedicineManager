/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50712
Source Host           : localhost:3306
Source Database       : medicine_sale

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2019-03-04 16:58:36
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tb_category`
-- ----------------------------
DROP TABLE IF EXISTS `tb_category`;
CREATE TABLE `tb_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of tb_category
-- ----------------------------
INSERT INTO `tb_category` VALUES ('1', '感冒用药', '主治感冒、发烧、头痛。', '2009-06-10 08:41:25');
INSERT INTO `tb_category` VALUES ('2', '胃肠用药', '胃炎、肠炎专用药。', '2009-06-10 08:41:25');
INSERT INTO `tb_category` VALUES ('3', '儿童用药', '慎用，儿童用药。', '2009-06-10 08:41:25');

-- ----------------------------
-- Table structure for `tb_medicine`
-- ----------------------------
DROP TABLE IF EXISTS `tb_medicine`;
CREATE TABLE `tb_medicine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medNo` varchar(100) NOT NULL,
  `name` varchar(200) NOT NULL,
  `factoryAdd` varchar(200) DEFAULT NULL,
  `description` text,
  `price` double NOT NULL,
  `medCount` int(11) DEFAULT NULL,
  `reqCount` int(11) DEFAULT NULL,
  `photoPath` varchar(255) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `medNo` (`medNo`),
  KEY `FKCB73D4EB5CE1611D` (`categoryId`),
  CONSTRAINT `FKCB73D4EB5CE1611D` FOREIGN KEY (`categoryId`) REFERENCES `tb_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of tb_medicine
-- ----------------------------
INSERT INTO `tb_medicine` VALUES ('1', 'abc001', '感冒胶囊A', '制药一厂', '效果很好', '2.5', '3', '0', null, '1');
INSERT INTO `tb_medicine` VALUES ('2', 'abc002', '感冒胶囊B', '制药一厂', '治疗伤风、头痛效果很好', '10.05', '10', '0', null, '1');
INSERT INTO `tb_medicine` VALUES ('3', 'abc003', 'xx肠炎灵', '制药二厂', '主治拉肚子', '5.8', '100', '0', null, '2');
INSERT INTO `tb_medicine` VALUES ('4', 'abc004', '小儿感冒冲剂', '制药三厂', '效果很好', '5.8', '100', '0', null, '3');

-- ----------------------------
-- Table structure for `tb_selldetail`
-- ----------------------------
DROP TABLE IF EXISTS `tb_selldetail`;
CREATE TABLE `tb_selldetail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sellName` varchar(200) NOT NULL,
  `sellPrice` double NOT NULL,
  `sellCount` int(11) NOT NULL,
  `sellTime` datetime NOT NULL,
  `medid` int(11) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK56C63894822F277` (`userid`),
  KEY `FK56C63894DD16E7A7` (`medid`),
  CONSTRAINT `FK56C63894822F277` FOREIGN KEY (`userid`) REFERENCES `tb_user` (`id`),
  CONSTRAINT `FK56C63894DD16E7A7` FOREIGN KEY (`medid`) REFERENCES `tb_medicine` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of tb_selldetail
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_user`
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES ('1', 'admin', 'admin', '2009-06-10 08:41:25');
