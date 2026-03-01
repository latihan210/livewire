/*
 Navicat Premium Data Transfer

 Source Server         : MySQL_Local
 Source Server Type    : MySQL
 Source Server Version : 100410
 Source Host           : localhost:3306
 Source Schema         : livewire

 Target Server Type    : MySQL
 Target Server Version : 100410
 File Encoding         : 65001

 Date: 01/03/2026 21:51:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `two_factor_secret` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `two_factor_recovery_codes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `package` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'free',
  `sponsor` bigint NOT NULL DEFAULT 0 COMMENT 'Sponsor Recruitement',
  `sponsor_uid` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `parent` bigint NOT NULL DEFAULT 0 COMMENT 'Parent of Tree',
  `parent_uid` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `position` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'root for admin',
  `group` int NOT NULL DEFAULT 0,
  `gen` int NOT NULL DEFAULT 0,
  `level` int NOT NULL DEFAULT 0,
  `tree_sponsor` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `tree` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `password_pin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `password_trx` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `type` int NOT NULL DEFAULT 1 COMMENT '1=Administrator,2=Member',
  `status` int NOT NULL DEFAULT 0 COMMENT '0=Not Active,1=Active,2=Banned,3=Deleted',
  `birthdate` date NULL DEFAULT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `idcard` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `npwp` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `country` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `province` smallint NOT NULL DEFAULT 0,
  `district` smallint NOT NULL DEFAULT 0,
  `subdistrict` smallint NULL DEFAULT NULL,
  `village` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `bank` int NOT NULL DEFAULT 0,
  `bill` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bill_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `photo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `idcard_img` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `qrcode_img` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `total_omzet` double NOT NULL DEFAULT 0,
  `package_omzet` double NOT NULL DEFAULT 0,
  `rank` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `referral_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `as_stockist` tinyint NOT NULL DEFAULT 0 COMMENT '1=ms, 2=stockist, 3=master',
  `as_stockist_pusat` tinyint NOT NULL DEFAULT 0,
  `stockist_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `stockist_province` smallint NULL DEFAULT NULL,
  `stockist_district` smallint NULL DEFAULT NULL,
  `stockist_subdistrict` smallint NULL DEFAULT NULL,
  `stockist_village` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `stockist_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `to_stockist` bigint NOT NULL DEFAULT 0,
  `shop_invoice` smallint NOT NULL DEFAULT 0,
  `shop_uniquecode` smallint NOT NULL DEFAULT 0,
  `wd_status` tinyint NOT NULL DEFAULT 1 COMMENT '0=\"Otomatis Sistem\"; 1=\"Manual WD\"',
  `wd_min` int NOT NULL DEFAULT 0,
  `agree_ethic` tinyint NOT NULL DEFAULT 0,
  `change_password` smallint NOT NULL DEFAULT 0,
  `last_login` datetime NULL DEFAULT NULL,
  `member_hu` bigint NOT NULL DEFAULT 0,
  `is_ro` int NOT NULL DEFAULT 0,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `userunique`(`username`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email`) USING BTREE,
  INDEX `users_sponsor_index`(`sponsor`) USING BTREE,
  INDEX `users_parent_index`(`parent`) USING BTREE,
  INDEX `users_phone_index`(`phone`) USING BTREE,
  INDEX `users_type_index`(`type`) USING BTREE,
  INDEX `users_status_index`(`status`) USING BTREE,
  INDEX `users_rank_index`(`rank`) USING BTREE,
  INDEX `users_member_hu_index`(`member_hu`) USING BTREE,
  INDEX `users_is_ro_index`(`is_ro`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'Yosep Solahudin', 'solahudin210', 'yosepsolahudin200@gmail.com', '2026-02-25 17:21:00', '$2y$12$wxr7XWPxSMFsKc2WCvK/5uEHeEZeyAGa3nLmcQeXsDRdUD.oiWdRm', NULL, NULL, NULL, 'admin', 0, NULL, 0, NULL, 'root', 0, 0, 0, '1', '1', NULL, '', NULL, 1, 1, NULL, NULL, '0000000000000000', '', 'id', 6, 152, 2098, 'Kemayoran', 'Jakarta', 0, NULL, NULL, NULL, NULL, NULL, 0, 0, 'member', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, 1, 0, '2026-03-01 14:19:31', 0, 0, '6zx2VxaRuraSsHfDrblwVhfGSdaI6Ur1xjmQu0GE0HeU7Xga0wGZgMiU8ye0', '2026-02-25 13:39:09', '2026-03-01 14:19:31');

SET FOREIGN_KEY_CHECKS = 1;
-- $2y$05$Z2VsarGZCYg9Rt2S9hwiB.89XywfKV80gzsRj/WZvMA8OFSZzOew2
-- $2y$05$ZI3ZeopIrWkSiSZfvXEo3.LHwmm1vsu0BVBkXJsMCh.yqPUpOZmHe Cic_jpb000