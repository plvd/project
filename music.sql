/*
 Navicat Premium Data Transfer

 Source Server         : mysever
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : localhost:3306
 Source Schema         : music

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 15/09/2018 10:08:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for album
-- ----------------------------
DROP TABLE IF EXISTS `album`;
CREATE TABLE `album`  (
  `albumid` int(100) NOT NULL,
  `albname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `data` date NULL DEFAULT NULL,
  `singerid` int(100) NULL DEFAULT NULL,
  PRIMARY KEY (`albumid`) USING BTREE,
  INDEX `fk_album_singer`(`singerid`) USING BTREE,
  CONSTRAINT `fk_album_singer` FOREIGN KEY (`singerid`) REFERENCES `singer` (`singerid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of album
-- ----------------------------
INSERT INTO `album` VALUES (1, '《不能说的秘密》', NULL, 1);

-- ----------------------------
-- Table structure for commment
-- ----------------------------
DROP TABLE IF EXISTS `commment`;
CREATE TABLE `commment`  (
  `commentid` int(100) NOT NULL,
  `ccontent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `cdata` date NULL DEFAULT NULL,
  `ctype` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '评论类型，动态专辑，歌曲',
  `trendid` int(225) NULL DEFAULT NULL,
  `songid` int(100) NULL DEFAULT NULL,
  `userid` int(100) NULL DEFAULT NULL,
  `albumid` int(100) NULL DEFAULT NULL,
  PRIMARY KEY (`commentid`) USING BTREE,
  INDEX `fk_comment_trend`(`trendid`) USING BTREE,
  INDEX `fk_comment_song`(`songid`) USING BTREE,
  INDEX `fk_comment_user`(`userid`) USING BTREE,
  INDEX `fk_comment_album`(`albumid`) USING BTREE,
  CONSTRAINT `fk_comment_trend` FOREIGN KEY (`trendid`) REFERENCES `trend` (`trendid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_comment_song` FOREIGN KEY (`songid`) REFERENCES `song` (`songid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_comment_user` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_comment_album` FOREIGN KEY (`albumid`) REFERENCES `album` (`albumid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for creatls
-- ----------------------------
DROP TABLE IF EXISTS `creatls`;
CREATE TABLE `creatls`  (
  `creatlsid` int(100) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `singlistid` int(100) NULL DEFAULT NULL,
  PRIMARY KEY (`creatlsid`) USING BTREE,
  INDEX `fk_creatls_singlist`(`singlistid`) USING BTREE,
  CONSTRAINT `fk_creatls_singlist` FOREIGN KEY (`singlistid`) REFERENCES `singlist` (`singlistid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply`  (
  `replyid` int(100) NOT NULL,
  `commentid` int(100) NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `data` date NULL DEFAULT NULL,
  `userid` int(100) NULL DEFAULT NULL,
  PRIMARY KEY (`replyid`) USING BTREE,
  INDEX `fk_reply_comment`(`commentid`) USING BTREE,
  INDEX `fk_reply_user`(`userid`) USING BTREE,
  CONSTRAINT `fk_reply_comment` FOREIGN KEY (`commentid`) REFERENCES `commment` (`commentid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_reply_user` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for singer
-- ----------------------------
DROP TABLE IF EXISTS `singer`;
CREATE TABLE `singer`  (
  `singerid` int(11) NOT NULL,
  `sinname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `albumid` int(100) NULL DEFAULT NULL,
  PRIMARY KEY (`singerid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of singer
-- ----------------------------
INSERT INTO `singer` VALUES (1, '周杰伦', '男', NULL);
INSERT INTO `singer` VALUES (2, '邓紫棋', '女', NULL);
INSERT INTO `singer` VALUES (3, '薛之谦', '男', NULL);

-- ----------------------------
-- Table structure for singlist
-- ----------------------------
DROP TABLE IF EXISTS `singlist`;
CREATE TABLE `singlist`  (
  `singlistid` int(100) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `hot` bit(20) NULL DEFAULT NULL,
  PRIMARY KEY (`singlistid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for song
-- ----------------------------
DROP TABLE IF EXISTS `song`;
CREATE TABLE `song`  (
  `songid` int(100) NOT NULL,
  `sname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `singerid` int(11) NULL DEFAULT NULL,
  `songlay` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '歌词',
  `songpic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面',
  `songrigi` bit(20) NULL DEFAULT NULL COMMENT '是否原创',
  `albumid` int(255) NULL DEFAULT NULL,
  `singlistid` int(100) NULL DEFAULT NULL,
  `workid` int(100) NULL DEFAULT NULL,
  PRIMARY KEY (`songid`) USING BTREE,
  INDEX `fk_song_singer`(`singerid`) USING BTREE,
  INDEX `fk_song_album`(`albumid`) USING BTREE,
  INDEX `fk_song_singlist`(`singlistid`) USING BTREE,
  INDEX `fk_song_works`(`workid`) USING BTREE,
  CONSTRAINT `fk_song_singer` FOREIGN KEY (`singerid`) REFERENCES `singer` (`singerid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_song_album` FOREIGN KEY (`albumid`) REFERENCES `album` (`albumid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_song_singlist` FOREIGN KEY (`singlistid`) REFERENCES `singlist` (`singlistid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_song_works` FOREIGN KEY (`workid`) REFERENCES `works` (`workid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for trend
-- ----------------------------
DROP TABLE IF EXISTS `trend`;
CREATE TABLE `trend`  (
  `trendid` int(11) NOT NULL,
  `ttitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tcontent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tdat` date NULL DEFAULT NULL,
  `userid` int(100) NULL DEFAULT NULL,
  PRIMARY KEY (`trendid`) USING BTREE,
  INDEX `fk_trend_user`(`userid`) USING BTREE,
  CONSTRAINT `fk_trend_user` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `userid` int(100) NOT NULL,
  `uaccount` int(255) NOT NULL,
  `upassword` int(255) NOT NULL,
  `ucallphone` int(255) NULL DEFAULT NULL,
  `uname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `uheadpic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `uattention` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关注',
  `creatlsid` int(100) NULL DEFAULT NULL,
  PRIMARY KEY (`userid`) USING BTREE,
  INDEX `fk_user_creatls`(`creatlsid`) USING BTREE,
  CONSTRAINT `fk_user_creatls` FOREIGN KEY (`creatlsid`) REFERENCES `creatls` (`creatlsid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for works
-- ----------------------------
DROP TABLE IF EXISTS `works`;
CREATE TABLE `works`  (
  `workid` int(100) NOT NULL,
  `workname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '内容',
  `userid` int(100) NULL DEFAULT NULL,
  `data` date NULL DEFAULT NULL,
  PRIMARY KEY (`workid`) USING BTREE,
  INDEX `fk_works_user`(`userid`) USING BTREE,
  CONSTRAINT `fk_works_user` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for zan
-- ----------------------------
DROP TABLE IF EXISTS `zan`;
CREATE TABLE `zan`  (
  `zanid` int(100) NOT NULL,
  `status` bit(25) NULL DEFAULT NULL COMMENT '点赞状态',
  `trendid` int(100) NULL DEFAULT NULL,
  `songid` int(100) NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '点赞类型针对作品or动态',
  PRIMARY KEY (`zanid`) USING BTREE,
  INDEX `fk_zan_trend`(`trendid`) USING BTREE,
  INDEX `fk_zan_song`(`songid`) USING BTREE,
  CONSTRAINT `fk_zan_trend` FOREIGN KEY (`trendid`) REFERENCES `trend` (`trendid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_zan_song` FOREIGN KEY (`songid`) REFERENCES `song` (`songid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
