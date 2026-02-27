/*
 Navicat Premium Data Transfer

 Source Server         : Mysql Local
 Source Server Type    : MySQL
 Source Server Version : 100410
 Source Host           : localhost:3306
 Source Schema         : livewire

 Target Server Type    : MySQL
 Target Server Version : 100410
 File Encoding         : 65001

 Date: 27/02/2026 21:53:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for area
-- ----------------------------
DROP TABLE IF EXISTS `area`;
CREATE TABLE `area`  (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `area_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `area_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auto_ro
-- ----------------------------
DROP TABLE IF EXISTS `auto_ro`;
CREATE TABLE `auto_ro`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_member` bigint(20) NOT NULL,
  `id_source` bigint(20) NOT NULL,
  `source` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `nominal` double NOT NULL,
  `percent` tinyint(4) NOT NULL COMMENT 'IN, OUT',
  `amount` double NOT NULL,
  `status` tinyint(1) NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `datecreated` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auto_ro_id_member_id_source_source_unique`(`id_member`, `id_source`, `source`) USING BTREE,
  INDEX `auto_ro_percent_index`(`percent`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auto_ro_out
-- ----------------------------
DROP TABLE IF EXISTS `auto_ro_out`;
CREATE TABLE `auto_ro_out`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_member` bigint(20) NOT NULL,
  `id_source` bigint(20) NOT NULL,
  `source` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'bonus, topup, shop, withdraw, transfer',
  `amount` int(11) NOT NULL,
  `status` int(11) NOT NULL COMMENT '1 = active, 0 = inactive',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `datecreated` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `routunique`(`id_member`, `id_source`, `source`) USING BTREE,
  INDEX `auto_ro_out_id_member_index`(`id_member`) USING BTREE,
  INDEX `auto_ro_out_id_source_index`(`id_source`) USING BTREE,
  INDEX `auto_ro_out_source_index`(`source`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for banks
-- ----------------------------
DROP TABLE IF EXISTS `banks`;
CREATE TABLE `banks`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `kode` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'bank',
  `flipcode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `espaycode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `linkitacode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `banks_kode_index`(`kode`) USING BTREE,
  INDEX `banks_flipcode_index`(`flipcode`) USING BTREE,
  INDEX `banks_espaycode_index`(`espaycode`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bonus
-- ----------------------------
DROP TABLE IF EXISTS `bonus`;
CREATE TABLE `bonus`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_bonus` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_member` bigint(20) NOT NULL,
  `type` int(11) NOT NULL COMMENT '1=Sponsor,2=Pairing',
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` int(11) NOT NULL,
  `amount` double NOT NULL,
  `tax` double NOT NULL,
  `amount_tax` double NOT NULL,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `bonus_id_bonus_index`(`id_bonus`) USING BTREE,
  INDEX `bonus_id_member_index`(`id_member`) USING BTREE,
  INDEX `bonus_type_index`(`type`) USING BTREE,
  INDEX `bonus_amount_index`(`amount`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bonus_generation_refs
-- ----------------------------
DROP TABLE IF EXISTS `bonus_generation_refs`;
CREATE TABLE `bonus_generation_refs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_bonus` bigint(20) NOT NULL,
  `id_member` bigint(20) NOT NULL,
  `id_downline` bigint(20) NOT NULL,
  `gen` tinyint(4) NOT NULL COMMENT 'bonus, topup, shop, withdraw, transfer',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `omzet` int(11) NOT NULL,
  `percentage` tinyint(4) NOT NULL COMMENT 'IN, OUT',
  `amount` int(11) NOT NULL,
  `year` smallint(6) NOT NULL,
  `month` tinyint(4) NOT NULL,
  `date` date NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `dateomzet` datetime(0) NULL DEFAULT NULL,
  `datecreated` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `bonus_generation_refs_id_bonus_index`(`id_bonus`) USING BTREE,
  INDEX `bonus_generation_refs_id_member_index`(`id_member`) USING BTREE,
  INDEX `bonus_generation_refs_year_index`(`year`) USING BTREE,
  INDEX `bonus_generation_refs_month_index`(`month`) USING BTREE,
  INDEX `bonus_generation_refs_date_index`(`date`) USING BTREE,
  INDEX `bonus_generation_refs_dateomzet_index`(`dateomzet`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bonus_level_refs
-- ----------------------------
DROP TABLE IF EXISTS `bonus_level_refs`;
CREATE TABLE `bonus_level_refs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_bonus` bigint(20) NOT NULL,
  `id_member` bigint(20) NOT NULL,
  `id_downline` bigint(20) NOT NULL,
  `level` smallint(6) NOT NULL COMMENT 'bonus, topup, shop, withdraw, transfer',
  `level_downline` smallint(6) NOT NULL,
  `omzet` int(11) NOT NULL,
  `percentage` tinyint(4) NOT NULL COMMENT 'IN, OUT',
  `amount` int(11) NOT NULL,
  `year` smallint(6) NOT NULL,
  `month` tinyint(4) NOT NULL,
  `date` date NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `dateomzet` datetime(0) NULL DEFAULT NULL,
  `datecreated` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `bonus_level_refs_id_bonus_index`(`id_bonus`) USING BTREE,
  INDEX `bonus_level_refs_id_member_index`(`id_member`) USING BTREE,
  INDEX `bonus_level_refs_level_index`(`level`) USING BTREE,
  INDEX `bonus_level_refs_level_downline_index`(`level_downline`) USING BTREE,
  INDEX `bonus_level_refs_year_index`(`year`) USING BTREE,
  INDEX `bonus_level_refs_month_index`(`month`) USING BTREE,
  INDEX `bonus_level_refs_date_index`(`date`) USING BTREE,
  INDEX `bonus_level_refs_dateomzet_index`(`dateomzet`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bonus_matching_refs
-- ----------------------------
DROP TABLE IF EXISTS `bonus_matching_refs`;
CREATE TABLE `bonus_matching_refs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_bonus_pairing` bigint(20) NOT NULL,
  `id_bonus_matching` bigint(20) NOT NULL,
  `id_member` bigint(20) NOT NULL,
  `id_downline` bigint(20) NOT NULL,
  `gen` tinyint(4) NOT NULL COMMENT 'bonus, topup, shop, withdraw, transfer',
  `percentage` tinyint(4) NOT NULL COMMENT 'IN, OUT',
  `bonus` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `datecreated` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `bonus_matching_refs_id_bonus_pairing_index`(`id_bonus_pairing`) USING BTREE,
  INDEX `bonus_matching_refs_id_bonus_matching_index`(`id_bonus_matching`) USING BTREE,
  INDEX `bonus_matching_refs_id_member_index`(`id_member`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cache
-- ----------------------------
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache`  (
  `key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`) USING BTREE,
  INDEX `cache_expiration_index`(`expiration`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cache
-- ----------------------------
INSERT INTO `cache` VALUES ('livewire-cache-356a192b7913b04c54574d18c28d46e6395428ab:timer', 'i:1772026136;', 1772026136);
INSERT INTO `cache` VALUES ('livewire-cache-356a192b7913b04c54574d18c28d46e6395428ab', 'i:1;', 1772026136);
INSERT INTO `cache` VALUES ('livewire-cache-819654796294103bd506e4e6ab355dae:timer', 'i:1772032936;', 1772032936);
INSERT INTO `cache` VALUES ('livewire-cache-819654796294103bd506e4e6ab355dae', 'i:1;', 1772032936);
INSERT INTO `cache` VALUES ('livewire-cache-c6be2cf7c13d9a527ee2fe401bbae3c7:timer', 'i:1772029871;', 1772029871);
INSERT INTO `cache` VALUES ('livewire-cache-c6be2cf7c13d9a527ee2fe401bbae3c7', 'i:1;', 1772029871);
INSERT INTO `cache` VALUES ('livewire-cache-b27c5f33bc4a1918ee6a16e66233ce5d:timer', 'i:1772030622;', 1772030622);
INSERT INTO `cache` VALUES ('livewire-cache-b27c5f33bc4a1918ee6a16e66233ce5d', 'i:2;', 1772030622);
INSERT INTO `cache` VALUES ('livewire-cache-solahudin21042002@gmail.com|127.0.0.1:timer', 'i:1772030622;', 1772030622);
INSERT INTO `cache` VALUES ('livewire-cache-solahudin21042002@gmail.com|127.0.0.1', 'i:2;', 1772030622);
INSERT INTO `cache` VALUES ('livewire-cache-2eede56165559d3c1e8bd11887cc8e48:timer', 'i:1772031019;', 1772031019);
INSERT INTO `cache` VALUES ('livewire-cache-2eede56165559d3c1e8bd11887cc8e48', 'i:1;', 1772031019);
INSERT INTO `cache` VALUES ('livewire-cache-solahudin210f|127.0.0.1:timer', 'i:1772031019;', 1772031019);
INSERT INTO `cache` VALUES ('livewire-cache-solahudin210f|127.0.0.1', 'i:1;', 1772031019);
INSERT INTO `cache` VALUES ('livewire-cache-602bf3170a6e999fca74b1aa656e88e9:timer', 'i:1772031063;', 1772031063);
INSERT INTO `cache` VALUES ('livewire-cache-602bf3170a6e999fca74b1aa656e88e9', 'i:1;', 1772031063);
INSERT INTO `cache` VALUES ('livewire-cache-solahudin210h|127.0.0.1:timer', 'i:1772031063;', 1772031063);
INSERT INTO `cache` VALUES ('livewire-cache-solahudin210h|127.0.0.1', 'i:1;', 1772031063);
INSERT INTO `cache` VALUES ('livewire-cache-da4b9237bacccdf19c0760cab7aec4a8359010b0:timer', 'i:1772039796;', 1772039796);
INSERT INTO `cache` VALUES ('livewire-cache-da4b9237bacccdf19c0760cab7aec4a8359010b0', 'i:1;', 1772039796);
INSERT INTO `cache` VALUES ('livewire-cache-caf3816aa3fe7dfca6d0a8ec07b59f24:timer', 'i:1772181915;', 1772181915);
INSERT INTO `cache` VALUES ('livewire-cache-caf3816aa3fe7dfca6d0a8ec07b59f24', 'i:1;', 1772181915);
INSERT INTO `cache` VALUES ('at-me-cache-819654796294103bd506e4e6ab355dae:timer', 'i:1772203057;', 1772203057);
INSERT INTO `cache` VALUES ('at-me-cache-819654796294103bd506e4e6ab355dae', 'i:1;', 1772203057);

-- ----------------------------
-- Table structure for cache_locks
-- ----------------------------
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks`  (
  `key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`) USING BTREE,
  INDEX `cache_locks_expiration_index`(`expiration`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cart_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_member` bigint(20) NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `grouping` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `grouping_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `package_id` int(11) NOT NULL,
  `varian_id` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `weight` double NULL DEFAULT NULL,
  `bv` double NOT NULL,
  `price` double NULL DEFAULT NULL,
  `qty` int(11) NULL DEFAULT NULL,
  `subtotal` double NULL DEFAULT NULL,
  `total_item` int(11) NOT NULL,
  `items` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `cart_cart_code_unique`(`cart_code`) USING HASH,
  INDEX `cart_member`(`id_member`) USING BTREE,
  INDEX `cart_group`(`grouping`) USING BTREE,
  INDEX `cart_groupid`(`grouping_id`) USING BTREE,
  INDEX `cart_product`(`product_id`) USING BTREE,
  INDEX `cart_package`(`package_id`) USING BTREE,
  INDEX `cart_varian`(`varian_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for country
-- ----------------------------
DROP TABLE IF EXISTS `country`;
CREATE TABLE `country`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iso` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nicename` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `iso3` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `numcode` smallint(6) NULL DEFAULT NULL,
  `phonecode` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `country_iso3_index`(`iso3`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for district
-- ----------------------------
DROP TABLE IF EXISTS `district`;
CREATE TABLE `district`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `province_id` smallint(6) NOT NULL,
  `district_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `district_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `district_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `postal_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `id_express` int(11) NOT NULL,
  `lion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_id_lion`(`lion`(250)) USING BTREE,
  INDEX `idx_province_id`(`province_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for eproduct
-- ----------------------------
DROP TABLE IF EXISTS `eproduct`;
CREATE TABLE `eproduct`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_member` bigint(20) NOT NULL,
  `id_source` bigint(20) NOT NULL,
  `source` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'bonus, topup, shop, withdraw, transfer',
  `category` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'product' COMMENT 'product, shipping',
  `amount` double NOT NULL,
  `type` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'IN, OUT',
  `status` int(11) NOT NULL COMMENT '1 = active, 0 = inactive',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `datecreated` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `eproduct_id_member_index`(`id_member`) USING BTREE,
  INDEX `eproduct_source_index`(`source`) USING BTREE,
  INDEX `eproduct_type_index`(`type`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ewallet
-- ----------------------------
DROP TABLE IF EXISTS `ewallet`;
CREATE TABLE `ewallet`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_member` bigint(20) NOT NULL,
  `id_source` bigint(20) NOT NULL,
  `source` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'bonus, topup, shop, withdraw, transfer',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'commission' COMMENT 'commission, profit',
  `nominal` int(11) NOT NULL,
  `percent` tinyint(4) NOT NULL,
  `autoro` int(11) NOT NULL,
  `tax` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `type` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'IN, OUT',
  `status` int(11) NOT NULL COMMENT '1 = active, 0 = inactive',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `datecreated` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `walletunique`(`id_member`, `id_source`, `source`) USING BTREE,
  INDEX `ewallet_id_member_index`(`id_member`) USING BTREE,
  INDEX `ewallet_source_index`(`source`) USING BTREE,
  INDEX `ewallet_type_index`(`type`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ewallet_transfer
-- ----------------------------
DROP TABLE IF EXISTS `ewallet_transfer`;
CREATE TABLE `ewallet_transfer`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_transfer` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_member_sender` bigint(20) NOT NULL,
  `username_sender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_member` bigint(20) NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nominal` int(11) NOT NULL,
  `nominal_receipt` int(11) NOT NULL,
  `admin_fund` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NOT NULL,
  `created_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ewt_id_transfer`(`id_transfer`) USING BTREE,
  INDEX `ewt_id_member_sender`(`id_member_sender`) USING BTREE,
  INDEX `ewt_id_member`(`id_member`) USING BTREE,
  INDEX `ewt_status`(`status`) USING BTREE,
  INDEX `ewt_date`(`datecreated`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp(0) NOT NULL DEFAULT current_timestamp(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for job_batches
-- ----------------------------
DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches`  (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `cancelled_at` int(11) NULL DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED NULL DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `jobs_queue_index`(`queue`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for keys
-- ----------------------------
DROP TABLE IF EXISTS `keys`;
CREATE TABLE `keys`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_member` bigint(20) NOT NULL,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `level` tinyint(4) NOT NULL DEFAULT 1,
  `ignore_limits` tinyint(4) NOT NULL,
  `is_private_key` tinyint(1) NOT NULL,
  `ip_addresses` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log`  (
  `log_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `log_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `log_time` datetime(0) NOT NULL,
  `log_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `log_desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`log_id`) USING BTREE,
  INDEX `log_log_name_index`(`log_name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for log_action
-- ----------------------------
DROP TABLE IF EXISTS `log_action`;
CREATE TABLE `log_action`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `platform` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `assum` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `assum_staff` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `datetime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `log_act_name`(`name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for log_api
-- ----------------------------
DROP TABLE IF EXISTS `log_api`;
CREATE TABLE `log_api`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `platform` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `datetime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `log_act_name`(`name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for log_cron
-- ----------------------------
DROP TABLE IF EXISTS `log_cron`;
CREATE TABLE `log_cron`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cron_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_time` datetime(0) NOT NULL,
  `end_time` datetime(0) NOT NULL,
  `log_desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `log_name`(`cron_name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for log_notif
-- ----------------------------
DROP TABLE IF EXISTS `log_notif`;
CREATE TABLE `log_notif`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `send` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `date` timestamp(0) NOT NULL DEFAULT current_timestamp(0),
  `user_id` bigint(20) NULL DEFAULT NULL,
  `user_2nd` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for member_confirm
-- ----------------------------
DROP TABLE IF EXISTS `member_confirm`;
CREATE TABLE `member_confirm`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_member` bigint(20) NOT NULL,
  `member` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_sponsor` bigint(20) NOT NULL,
  `sponsor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_upline` bigint(20) NOT NULL,
  `upline` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `id_downline` bigint(20) NOT NULL,
  `downline` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `package` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `package_count` tinyint(4) NOT NULL DEFAULT 1,
  `position` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` int(11) NOT NULL COMMENT '0=Review,1=Confirmed',
  `access` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'admin, pin',
  `id_shop_order` bigint(20) NOT NULL,
  `referral_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `bv` double NOT NULL,
  `nominal` double NOT NULL,
  `shipping` double NOT NULL,
  `uniquecode` smallint(6) NOT NULL,
  `total_payment` double NOT NULL,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NOT NULL,
  `dateconfirmed` datetime(0) NULL DEFAULT NULL,
  `confirm_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for member_omzet
-- ----------------------------
DROP TABLE IF EXISTS `member_omzet`;
CREATE TABLE `member_omzet`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_member` bigint(20) NOT NULL,
  `pack_omzet` double NOT NULL,
  `bv` double NOT NULL,
  `sponsor` double NOT NULL COMMENT 'Sponsor Point',
  `pairing` double NOT NULL COMMENT 'Pairing Point',
  `reward` double NOT NULL COMMENT 'Reward Point',
  `ro` double NOT NULL,
  `omzet` double NOT NULL,
  `price` double NOT NULL,
  `amount` double NOT NULL,
  `status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `date` date NOT NULL,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mo_id_member`(`id_member`) USING BTREE,
  INDEX `mo_status`(`status`) USING BTREE,
  INDEX `mo_date`(`date`) USING BTREE,
  INDEX `mo_datecreated`(`datecreated`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for member_point
-- ----------------------------
DROP TABLE IF EXISTS `member_point`;
CREATE TABLE `member_point`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_member` bigint(20) NOT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `period` smallint(6) NOT NULL DEFAULT 0,
  `period_start` date NULL DEFAULT NULL,
  `period_end` date NULL DEFAULT NULL,
  `point_left` double NOT NULL,
  `point_right` double NOT NULL,
  `point_qualified` double NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `MP_unique`(`id_member`, `type`, `period`) USING BTREE,
  INDEX `MP_id_member`(`id_member`) USING BTREE,
  INDEX `MP_type`(`type`) USING BTREE,
  INDEX `MP_period`(`period`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for member_report
-- ----------------------------
DROP TABLE IF EXISTS `member_report`;
CREATE TABLE `member_report`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_member` bigint(20) NOT NULL,
  `pairing_left` double NOT NULL,
  `pairing_right` double NOT NULL,
  `pairing_qualified` double NOT NULL,
  `reward_left` double NOT NULL,
  `reward_right` double NOT NULL,
  `total_omzet` double NOT NULL,
  `total_ro_omzet` double NOT NULL,
  `total_ro_point` double NOT NULL,
  `last_ro_omzet` double NOT NULL,
  `last_ro_point` double NOT NULL,
  `last_ro_date` datetime(0) NULL DEFAULT NULL,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `MR_unique`(`id_member`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '0001_01_01_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '0001_01_01_000001_create_cache_table', 1);
INSERT INTO `migrations` VALUES (3, '0001_01_01_000002_create_jobs_table', 1);
INSERT INTO `migrations` VALUES (4, '2025_08_14_170933_add_two_factor_columns_to_users_table', 1);
INSERT INTO `migrations` VALUES (5, '2026_02_24_150000_create_application_tables', 1);

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `mime_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` enum('publish','draft','delete') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'publish',
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `news_slug_unique`(`slug`) USING HASH,
  INDEX `news_title_index`(`title`) USING BTREE,
  INDEX `news_status_index`(`status`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for notification
-- ----------------------------
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(11) NOT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `notification_slug_index`(`slug`(250)) USING BTREE,
  INDEX `notification_status_index`(`status`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for options
-- ----------------------------
DROP TABLE IF EXISTS `options`;
CREATE TABLE `options`  (
  `id_option` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id_option`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for otp
-- ----------------------------
DROP TABLE IF EXISTS `otp`;
CREATE TABLE `otp`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_member` bigint(20) NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `platform` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `browser` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `otp` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `expiration` int(10) UNSIGNED NULL DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `datecreated` datetime(0) NULL DEFAULT NULL,
  `datemodified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_idx`(`id_member`, `email`, `type`) USING BTREE,
  INDEX `otp_email_index`(`email`) USING BTREE,
  INDEX `type_otp`(`type`) USING BTREE,
  INDEX `otp_otp_index`(`otp`) USING BTREE,
  INDEX `last_activity_idx`(`expiration`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for package
-- ----------------------------
DROP TABLE IF EXISTS `package`;
CREATE TABLE `package`  (
  `package` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `package_index` tinyint(4) NOT NULL,
  `package_count` tinyint(4) NOT NULL DEFAULT 1,
  `bv` int(11) NOT NULL,
  `nominal` int(11) NOT NULL,
  `sponsor_percent` tinyint(4) NOT NULL,
  `passup_percent` tinyint(4) NOT NULL,
  `pairing_percent` tinyint(4) NOT NULL,
  `pairing_nominal` int(11) NOT NULL COMMENT 'Rp',
  `pairing_max` int(11) NOT NULL COMMENT 'BV',
  `pairing_point` smallint(6) NOT NULL,
  `reward_point` double NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `is_register` tinyint(1) NOT NULL,
  `is_order` tinyint(4) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NULL DEFAULT NULL,
  `modified_by` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`package`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pairing_point
-- ----------------------------
DROP TABLE IF EXISTS `pairing_point`;
CREATE TABLE `pairing_point`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_member` bigint(20) NOT NULL,
  `package` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bv` int(11) NOT NULL,
  `point` double NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `PP_id_member`(`id_member`) USING BTREE,
  INDEX `PP_type`(`type`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pairing_qualified
-- ----------------------------
DROP TABLE IF EXISTS `pairing_qualified`;
CREATE TABLE `pairing_qualified`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_member` bigint(20) NOT NULL,
  `left` double NOT NULL,
  `right` double NOT NULL,
  `qualified` double NOT NULL,
  `total_point` double NOT NULL,
  `carry_left` double NOT NULL,
  `carry_right` double NOT NULL,
  `kurs` double NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `PQ_id_member`(`id_member`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for password_reset_tokens
-- ----------------------------
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens`  (
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`email`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pin
-- ----------------------------
DROP TABLE IF EXISTS `pin`;
CREATE TABLE `pin`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_order_pin` bigint(20) NOT NULL,
  `id_pin` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_member` bigint(20) NOT NULL,
  `id_member_owner` bigint(20) NOT NULL,
  `id_member_register` bigint(20) NOT NULL,
  `id_member_registered` bigint(20) NOT NULL,
  `product` int(11) NOT NULL,
  `varian` int(11) NOT NULL DEFAULT 0,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `bv` int(11) NOT NULL,
  `amount` bigint(20) NOT NULL,
  `status` int(11) NOT NULL COMMENT '0=Pending,1=Active,2=Used',
  `used` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NOT NULL,
  `dateexpired` date NULL DEFAULT NULL,
  `dateused` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pin_id_member`(`id_member`) USING BTREE,
  INDEX `pin_id_member_register`(`id_member_register`) USING BTREE,
  INDEX `pin_id_member_registered`(`id_member_registered`) USING BTREE,
  INDEX `pin_product`(`product`) USING BTREE,
  INDEX `pin_status`(`status`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pin_transfer
-- ----------------------------
DROP TABLE IF EXISTS `pin_transfer`;
CREATE TABLE `pin_transfer`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_member_sender` bigint(20) NOT NULL,
  `username_sender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_member` bigint(20) NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_pin` bigint(20) NOT NULL,
  `product` int(11) NOT NULL,
  `varian` int(11) NOT NULL DEFAULT 0,
  `product_package` int(11) NOT NULL DEFAULT 0,
  `amount` int(11) NOT NULL,
  `price_member` int(11) NOT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'transfer_pin',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pt_id_member_sender`(`id_member_sender`) USING BTREE,
  INDEX `pt_id_member`(`id_member`) USING BTREE,
  INDEX `pt_id_pin`(`id_pin`) USING BTREE,
  INDEX `pt_product`(`product`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sku` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'All=Reg+RO',
  `varian` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hu` tinyint(4) NOT NULL,
  `bv` int(11) NOT NULL,
  `price_hpp` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `price_member` int(11) NOT NULL,
  `price_customer` int(11) NOT NULL,
  `sponsor_point` double NOT NULL,
  `pairing_point` double NOT NULL,
  `reward_point` double NOT NULL,
  `stockist_point` double NOT NULL,
  `reward_budget` int(11) NOT NULL,
  `weight` double NULL DEFAULT NULL COMMENT 'Weight = Gram',
  `stock` int(11) NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `s3_upload` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `show_order` tinyint(4) NULL DEFAULT 1,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `modified_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NULL DEFAULT NULL,
  `dateupdated` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `product_unique`(`name`, `slug`, `varian`) USING HASH,
  INDEX `product_name`(`name`) USING BTREE,
  INDEX `porduct_slug`(`slug`(250)) USING BTREE,
  INDEX `idx_type`(`type`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for product_area_fee
-- ----------------------------
DROP TABLE IF EXISTS `product_area_fee`;
CREATE TABLE `product_area_fee`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `source` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `id_source` int(11) NOT NULL,
  `id_area` int(11) NOT NULL,
  `fee` double NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `paf_unique`(`source`, `id_source`, `id_area`) USING BTREE,
  INDEX `paf_source`(`source`) USING BTREE,
  INDEX `paf_id_source`(`id_source`) USING BTREE,
  INDEX `paf_id_area`(`id_area`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for product_package
-- ----------------------------
DROP TABLE IF EXISTS `product_package`;
CREATE TABLE `product_package`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sku` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hu` tinyint(4) NOT NULL,
  `type_price` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `total_item` int(11) NOT NULL,
  `total_qty` int(11) NOT NULL,
  `total_amount` double NOT NULL DEFAULT 0,
  `bv` double NOT NULL,
  `price` double NOT NULL DEFAULT 0,
  `weight` double NULL DEFAULT NULL COMMENT 'Weight = Gram',
  `sponsor_point` double NOT NULL,
  `pairing_point` double NOT NULL,
  `stockist_point` double NOT NULL,
  `reward_point` double NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `show_order` tinyint(4) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NULL DEFAULT NULL,
  `created_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `modified_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `pp_unique`(`name`, `slug`) USING HASH
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for product_package_item
-- ----------------------------
DROP TABLE IF EXISTS `product_package_item`;
CREATE TABLE `product_package_item`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_package` int(11) NOT NULL,
  `id_product` int(11) NOT NULL,
  `id_varian` int(11) NOT NULL,
  `qty` int(11) NOT NULL DEFAULT 0,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ppi_package`(`id_package`) USING BTREE,
  INDEX `ppi_product`(`id_product`) USING BTREE,
  INDEX `ppi_varian`(`id_varian`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for product_stock
-- ----------------------------
DROP TABLE IF EXISTS `product_stock`;
CREATE TABLE `product_stock`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `price` double NOT NULL,
  `total` double NOT NULL,
  `supplier_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NOT NULL,
  `created_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `modified_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for product_stock_in
-- ----------------------------
DROP TABLE IF EXISTS `product_stock_in`;
CREATE TABLE `product_stock_in`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_supplier` bigint(20) NOT NULL,
  `id_warehouse` bigint(20) NOT NULL,
  `id_source` bigint(20) NOT NULL,
  `source` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'bonus, topup, shop, withdraw, transfer',
  `id_detail` bigint(20) NOT NULL,
  `product` int(11) NOT NULL,
  `varian` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '1 = active, 0 = inactive',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `datecreated` datetime(0) NOT NULL,
  `dateexpired` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `stockin`(`id_supplier`, `id_warehouse`, `id_source`, `source`, `product`, `varian`, `id_detail`) USING BTREE,
  INDEX `product_stock_in_id_supplier_index`(`id_supplier`) USING BTREE,
  INDEX `product_stock_in_id_warehouse_index`(`id_warehouse`) USING BTREE,
  INDEX `product_stock_in_id_source_index`(`id_source`) USING BTREE,
  INDEX `product_stock_in_source_index`(`source`) USING BTREE,
  INDEX `product_stock_in_product_index`(`product`) USING BTREE,
  INDEX `product_stock_in_status_index`(`status`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for product_stock_opname
-- ----------------------------
DROP TABLE IF EXISTS `product_stock_opname`;
CREATE TABLE `product_stock_opname`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ref_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int(11) NOT NULL,
  `varian_id` int(11) NOT NULL,
  `recorded_qty` int(11) NOT NULL,
  `actual_qty` int(11) NOT NULL,
  `difference_qty` int(11) NOT NULL,
  `price` double NOT NULL,
  `total` double NOT NULL,
  `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `memo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `date_trans` date NOT NULL,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NOT NULL,
  `created_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pso_ref_number`(`ref_number`) USING BTREE,
  INDEX `pso_product`(`product_id`) USING BTREE,
  INDEX `pso_date`(`datecreated`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for product_stock_out
-- ----------------------------
DROP TABLE IF EXISTS `product_stock_out`;
CREATE TABLE `product_stock_out`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_warehouse` bigint(20) NOT NULL,
  `id_member` bigint(20) NOT NULL,
  `id_source` bigint(20) NOT NULL,
  `source` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'bonus, topup, shop, withdraw, transfer',
  `id_detail` bigint(20) NOT NULL,
  `product` int(11) NOT NULL,
  `varian` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '1 = active, 0 = inactive',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `datecreated` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `stockout`(`id_member`, `id_source`, `source`, `product`, `varian`, `id_detail`, `id_warehouse`) USING BTREE,
  INDEX `product_stock_out_id_warehouse_index`(`id_warehouse`) USING BTREE,
  INDEX `product_stock_out_id_member_index`(`id_member`) USING BTREE,
  INDEX `product_stock_out_id_source_index`(`id_source`) USING BTREE,
  INDEX `product_stock_out_source_index`(`source`) USING BTREE,
  INDEX `product_stock_out_product_index`(`product`) USING BTREE,
  INDEX `product_stock_out_status_index`(`status`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for product_stockist
-- ----------------------------
DROP TABLE IF EXISTS `product_stockist`;
CREATE TABLE `product_stockist`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_member` bigint(20) NOT NULL,
  `id_source` bigint(20) NOT NULL,
  `source` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'bonus, topup, shop, withdraw, transfer',
  `id_detail` bigint(20) NOT NULL,
  `product` int(11) NOT NULL,
  `varian` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `price` double NOT NULL,
  `total` double NOT NULL,
  `form` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `type` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'IN, OUT',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 = active, 0 = inactive',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `pss_unique`(`id_member`, `id_source`, `source`, `id_detail`, `product`, `varian`, `type`, `status`) USING BTREE,
  INDEX `pss_id_member`(`id_member`) USING BTREE,
  INDEX `pss_id_source`(`id_source`) USING BTREE,
  INDEX `pss_source`(`source`) USING BTREE,
  INDEX `pss_detail`(`id_detail`) USING BTREE,
  INDEX `pss_product`(`product`) USING BTREE,
  INDEX `pss_varian`(`varian`) USING BTREE,
  INDEX `pss_form`(`form`) USING BTREE,
  INDEX `pss_type`(`type`) USING BTREE,
  INDEX `pss_status`(`status`) USING BTREE,
  INDEX `pss_datecreated`(`datecreated`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for product_stockist_stock_opname
-- ----------------------------
DROP TABLE IF EXISTS `product_stockist_stock_opname`;
CREATE TABLE `product_stockist_stock_opname`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ref_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_member` bigint(20) NOT NULL,
  `product_id` int(11) NOT NULL,
  `varian_id` int(11) NOT NULL,
  `recorded_qty` int(11) NOT NULL,
  `actual_qty` int(11) NOT NULL,
  `difference_qty` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `price` double NOT NULL,
  `total` double NOT NULL,
  `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `memo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `date_trans` date NOT NULL,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NOT NULL,
  `created_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pso_ref_number`(`ref_number`) USING BTREE,
  INDEX `pso_id_member`(`id_member`) USING BTREE,
  INDEX `pso_product`(`product_id`) USING BTREE,
  INDEX `pso_varian`(`varian_id`) USING BTREE,
  INDEX `pso_date`(`datecreated`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for product_varian
-- ----------------------------
DROP TABLE IF EXISTS `product_varian`;
CREATE TABLE `product_varian`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_product` int(11) NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `varian` varchar(140) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bv` double NULL DEFAULT NULL,
  `price_hpp` double NOT NULL DEFAULT 0,
  `price` double NOT NULL DEFAULT 0,
  `weight` double NOT NULL DEFAULT 0,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `pp_unique`(`id_product`, `name`, `varian`) USING BTREE,
  INDEX `pp_product`(`id_product`) USING BTREE,
  INDEX `pp_name`(`name`) USING BTREE,
  INDEX `pp_varian`(`varian`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for province
-- ----------------------------
DROP TABLE IF EXISTS `province`;
CREATE TABLE `province`  (
  `id` smallint(6) NOT NULL,
  `area_id` int(11) NOT NULL,
  `province_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `province_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `id_express` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for purchase_order
-- ----------------------------
DROP TABLE IF EXISTS `purchase_order`;
CREATE TABLE `purchase_order`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_purchase_kledo` bigint(20) NOT NULL,
  `id_purchase_delivery` bigint(20) NOT NULL,
  `id_supplier_kledo` int(11) NULL DEFAULT NULL,
  `invoice` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `id_supplier` int(11) NOT NULL,
  `ref_number_order` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `ref_number_delivery` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `products` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `total_qty` int(11) NOT NULL,
  `subtotal` int(11) NOT NULL,
  `shipping` int(11) NOT NULL,
  `unique` smallint(6) NOT NULL,
  `pph` double NOT NULL,
  `ppn` double NOT NULL,
  `discount` int(11) NOT NULL,
  `down_payment` int(11) NOT NULL,
  `total_payment` int(11) NULL DEFAULT NULL,
  `status` int(11) NOT NULL COMMENT '0=Review,1=Confirmed',
  `memo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `trans_date` date NULL DEFAULT NULL,
  `due_date` date NULL DEFAULT NULL,
  `delivery_date` date NULL DEFAULT NULL,
  `dateexpired` date NULL DEFAULT NULL,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NOT NULL,
  `dateconfirmed` datetime(0) NULL DEFAULT NULL,
  `created_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `modified_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `po_id_supplier`(`id_supplier`) USING BTREE,
  INDEX `po_status`(`status`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for purchase_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `purchase_order_detail`;
CREATE TABLE `purchase_order_detail`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_purchase_order` bigint(20) NOT NULL,
  `id_supplier` int(11) NOT NULL,
  `id_product_kledo` int(11) NOT NULL,
  `id_varian` int(11) NOT NULL,
  `product` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `varian` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `weight` int(11) NOT NULL COMMENT 'Weight = Gram',
  `price` int(11) NOT NULL,
  `price_cart` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `discount` int(11) NOT NULL,
  `pph` double NOT NULL,
  `ppn` double NOT NULL,
  `subtotal` int(11) NOT NULL,
  `subtotal_omzet` int(11) NOT NULL,
  `subtotal_weight` int(11) NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `dateexpired` date NULL DEFAULT NULL,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pod_id_purchase_order`(`id_purchase_order`) USING BTREE,
  INDEX `pod_id_supplier`(`id_supplier`) USING BTREE,
  INDEX `pod_product`(`product`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rajaongkir
-- ----------------------------
DROP TABLE IF EXISTS `rajaongkir`;
CREATE TABLE `rajaongkir`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `province_id` int(11) NOT NULL DEFAULT 0,
  `province_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `city_id` int(11) NOT NULL DEFAULT 0,
  `city_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `district_id` int(11) NOT NULL DEFAULT 0,
  `district_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_province` int(11) NOT NULL DEFAULT 0,
  `id_district` int(11) NOT NULL DEFAULT 0,
  `id_subdistrict` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `rajaongkir_province_id_index`(`province_id`) USING BTREE,
  INDEX `rajaongkir_city_id_index`(`city_id`) USING BTREE,
  INDEX `rajaongkir_district_id_index`(`district_id`) USING BTREE,
  INDEX `rajaongkir_id_province_index`(`id_province`) USING BTREE,
  INDEX `rajaongkir_id_district_index`(`id_district`) USING BTREE,
  INDEX `rajaongkir_id_subdistrict_index`(`id_subdistrict`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ranks
-- ----------------------------
DROP TABLE IF EXISTS `ranks`;
CREATE TABLE `ranks`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_member` bigint(20) NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rank` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `rank_index` tinyint(4) NOT NULL,
  `downline` int(11) NOT NULL,
  `point_left` double NOT NULL,
  `point_right` double NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `rk_id_member`(`id_member`) USING BTREE,
  INDEX `rk_rank`(`rank`) USING BTREE,
  INDEX `rk_index`(`rank_index`) USING BTREE,
  INDEX `rk_status`(`status`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for reward
-- ----------------------------
DROP TABLE IF EXISTS `reward`;
CREATE TABLE `reward`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_member` bigint(20) NOT NULL,
  `id_reward` int(11) NOT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `point_qualified` bigint(20) NOT NULL,
  `point_left` bigint(20) NOT NULL,
  `point_right` bigint(20) NOT NULL,
  `rank` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nominal` double NOT NULL DEFAULT 0,
  `nominal_receipt` double NOT NULL,
  `admin_fund` double NOT NULL,
  `tax` double NOT NULL,
  `bank` int(11) NOT NULL,
  `bank_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `bill` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bill_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `is_trip` tinyint(4) NOT NULL,
  `claim` tinyint(4) NOT NULL,
  `flip_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `status` int(11) NOT NULL COMMENT '0=Pending,1=Confirmed',
  `inquiry_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NOT NULL,
  `dateconfirmed` datetime(0) NULL DEFAULT NULL,
  `dateclaimed` datetime(0) NULL DEFAULT NULL,
  `confirm_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id_member`, `id_reward`, `type`) USING BTREE,
  INDEX `R_id_member`(`id_member`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for reward_config
-- ----------------------------
DROP TABLE IF EXISTS `reward_config`;
CREATE TABLE `reward_config`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reward` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `nominal` bigint(20) NOT NULL,
  `point` int(11) NOT NULL,
  `packages` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `rank` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `start_date` date NULL DEFAULT NULL,
  `end_date` date NULL DEFAULT NULL,
  `is_lifetime` tinyint(1) NOT NULL DEFAULT 1,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_reward`(`type`, `reward`, `point`, `start_date`, `end_date`, `is_active`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for reward_point
-- ----------------------------
DROP TABLE IF EXISTS `reward_point`;
CREATE TABLE `reward_point`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_member` bigint(20) NOT NULL,
  `package` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bv` int(11) NOT NULL,
  `point` double NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `PP_id_member`(`id_member`) USING BTREE,
  INDEX `PP_type`(`type`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ro
-- ----------------------------
DROP TABLE IF EXISTS `ro`;
CREATE TABLE `ro`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `invoice` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `id_activator` bigint(20) NOT NULL,
  `id_member` bigint(20) NOT NULL,
  `id_stockist` bigint(20) NOT NULL,
  `id_shop_order` bigint(20) NOT NULL,
  `position` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `pins` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `meta` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` tinyint(4) NOT NULL,
  `point` double NOT NULL,
  `total_bv` double NOT NULL,
  `total_qty` int(11) NOT NULL,
  `subtotal` double NOT NULL,
  `unique` smallint(6) NOT NULL,
  `shipping` double NOT NULL,
  `shipping_discount` double NOT NULL,
  `discount` double NOT NULL,
  `voucher` double NOT NULL,
  `fee` double NOT NULL DEFAULT 0,
  `ppn` double NOT NULL,
  `autoro` double NOT NULL DEFAULT 0,
  `total_checkout` double NOT NULL DEFAULT 0,
  `total_payment` double NOT NULL,
  `total_omzet` double NOT NULL,
  `shipping_method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NOT NULL,
  `dateconfirmed` datetime(0) NULL DEFAULT NULL,
  `confirmed_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `modified_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ro_invoice`(`invoice`) USING BTREE,
  INDEX `ro_id_activator`(`id_activator`) USING BTREE,
  INDEX `ro_id_member`(`id_member`) USING BTREE,
  INDEX `ro_id_stockist`(`id_stockist`) USING BTREE,
  INDEX `ro_id_shop_order`(`id_shop_order`) USING BTREE,
  INDEX `ro_type`(`type`) USING BTREE,
  INDEX `ro_status`(`status`) USING BTREE,
  INDEX `ro_datecreated`(`datecreated`) USING BTREE,
  INDEX `ro_dateconfirmed`(`dateconfirmed`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ro_point_monthly
-- ----------------------------
DROP TABLE IF EXISTS `ro_point_monthly`;
CREATE TABLE `ro_point_monthly`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_member` bigint(20) NOT NULL,
  `year` smallint(6) NOT NULL,
  `month` tinyint(4) NOT NULL,
  `total_bv` bigint(20) NOT NULL,
  `total_bv_left` bigint(20) NOT NULL,
  `total_bv_right` bigint(20) NOT NULL,
  `kurs_bv_point` int(11) NOT NULL,
  `point` double NOT NULL DEFAULT 0,
  `point_left` double NOT NULL DEFAULT 0,
  `point_right` double NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0=Pending,1=Confirmed',
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NULL DEFAULT NULL,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `RP_unique`(`id_member`, `year`, `month`) USING BTREE,
  INDEX `RP_id_member`(`id_member`) USING BTREE,
  INDEX `RP_year`(`year`) USING BTREE,
  INDEX `RP_month`(`month`) USING BTREE,
  INDEX `RP_date`(`date`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions`  (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sessions_user_id_index`(`user_id`) USING BTREE,
  INDEX `sessions_last_activity_index`(`last_activity`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sessions
-- ----------------------------
INSERT INTO `sessions` VALUES ('swMIdcoHFPrcMV1t544ReKjkZBBCk0mhoe5fJ42X', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUG91WGp4MHJaRzh3RVA3MFB2eXBad21CbDhIb1N4Yk5wQUt6SDhRVyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjA6Imh0dHA6Ly9saXZld2lyZS50ZXN0IjtzOjU6InJvdXRlIjtOO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1772196756);
INSERT INTO `sessions` VALUES ('Z260zJ6mFREPkaZRZEkNOe17vkCeHyBsAadS1czf', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Cursor/2.5.26 Chrome/142.0.7444.265 Electron/39.4.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoibWRjb1FXSGNKelhNbUVzaE1QQzBTVFl3NFlLTFF0QXZhRFRPWUVtMCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9saXZld2lyZS50ZXN0L2Rhc2hib2FyZCI7czo1OiJyb3V0ZSI7czo5OiJkYXNoYm9hcmQiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1772203876);

-- ----------------------------
-- Table structure for shop_order
-- ----------------------------
DROP TABLE IF EXISTS `shop_order`;
CREATE TABLE `shop_order`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `invoice` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `id_member` bigint(20) NOT NULL,
  `id_stockist` bigint(20) NOT NULL,
  `id_espay` bigint(20) NOT NULL,
  `type_order` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `products` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `meta` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` int(11) NOT NULL COMMENT '0=Review,1=Confirmed, 2=done, 4=cancelled',
  `point_sponsor` double NOT NULL,
  `point_pairing` double NOT NULL,
  `point_reward` double NOT NULL,
  `point_stockist` double NOT NULL,
  `total_bv` double NOT NULL,
  `total_qty` int(11) NOT NULL,
  `subtotal` double NOT NULL,
  `shipping` double NOT NULL,
  `unique` smallint(6) NOT NULL,
  `discount` double NOT NULL,
  `shipping_discount` double NOT NULL,
  `fee` double NOT NULL DEFAULT 0,
  `ppn` double NOT NULL,
  `handling_fee` double NOT NULL DEFAULT 0,
  `insurance_fee` double NOT NULL DEFAULT 0,
  `additional_cost` double NOT NULL,
  `autoro` double NOT NULL DEFAULT 0,
  `total_checkout` double NOT NULL DEFAULT 0,
  `total_payment` double NOT NULL,
  `payment_remain` int(11) NOT NULL,
  `total_omzet` double NOT NULL,
  `voucher` double NOT NULL,
  `saldo_eproduct` double NOT NULL,
  `saldo_eshipping` double NOT NULL,
  `saldo_eshipping_subsidy` double NOT NULL,
  `payment_method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `payment_shipping_method` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'transfer',
  `payment_shipping_status` tinyint(4) NULL DEFAULT 1,
  `bank_code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `account_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `shipping_method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `id_province` int(11) NULL DEFAULT NULL,
  `id_district` int(11) NULL DEFAULT NULL,
  `id_subdistrict` int(11) NULL DEFAULT NULL,
  `province` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `district` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `subdistrict` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `village` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `postcode` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `courier` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `service` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `weight` int(11) NOT NULL,
  `resi` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `pin_transfer` tinyint(1) NOT NULL DEFAULT 0,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `confirmed_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `modified_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NOT NULL,
  `dateconfirmed` datetime(0) NULL DEFAULT NULL,
  `datestockistconfirmed` datetime(0) NULL DEFAULT NULL,
  `dateexpired` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `po_id_member`(`id_member`) USING BTREE,
  INDEX `po_status`(`status`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for shop_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `shop_order_detail`;
CREATE TABLE `shop_order_detail`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_shop_order` bigint(20) NOT NULL,
  `id_member` bigint(20) NOT NULL,
  `product_package` int(11) NOT NULL DEFAULT 0,
  `product` int(11) NOT NULL,
  `varian` int(11) NOT NULL DEFAULT 0,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `weight` int(11) NOT NULL COMMENT 'Weight = Gram',
  `point` double NOT NULL,
  `bv` double NOT NULL,
  `omzet` double NOT NULL,
  `price` double NOT NULL,
  `price_cart` double NOT NULL,
  `additional_cost` double NOT NULL,
  `qty` int(11) NOT NULL,
  `discount` double NOT NULL,
  `subtotal` double NOT NULL,
  `subtotal_bv` double NOT NULL,
  `subtotal_omzet` double NOT NULL,
  `subtotal_weight` double NOT NULL,
  `subtotal_cost` double NOT NULL,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pod_id_shop_order`(`id_shop_order`) USING BTREE,
  INDEX `pod_id_member`(`id_member`) USING BTREE,
  INDEX `pod_id_product_package`(`product_package`) USING BTREE,
  INDEX `pod_product`(`product`) USING BTREE,
  INDEX `pod_id_varian`(`varian`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for staff
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `access` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` tinyint(4) NULL DEFAULT 1,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `staff_username_unique`(`username`) USING BTREE,
  INDEX `staff_email_index`(`email`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for subdistrict
-- ----------------------------
DROP TABLE IF EXISTS `subdistrict`;
CREATE TABLE `subdistrict`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `district_id` smallint(6) NOT NULL,
  `subdistrict_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_express` int(11) NOT NULL,
  `lion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for supplier
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `id_contact_kledo` int(11) NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT 1,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `supplier_name_unique`(`name`) USING BTREE,
  INDEX `supplier_email_index`(`email`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for upgrade
-- ----------------------------
DROP TABLE IF EXISTS `upgrade`;
CREATE TABLE `upgrade`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `upgrader` bigint(20) NULL DEFAULT 0,
  `id_member` bigint(20) NOT NULL DEFAULT 0,
  `package_before` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `package_after` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `upgrade` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `omzet` bigint(20) NOT NULL DEFAULT 0,
  `amount` bigint(20) NOT NULL DEFAULT 0,
  `point` smallint(6) NOT NULL DEFAULT 0,
  `pins` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `upgrade_id_member_index`(`id_member`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp(0) NULL DEFAULT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `two_factor_secret` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `two_factor_recovery_codes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `two_factor_confirmed_at` timestamp(0) NULL DEFAULT NULL,
  `package` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'free',
  `sponsor` bigint(20) NOT NULL DEFAULT 0 COMMENT 'Sponsor Recruitement',
  `sponsor_uid` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `parent` bigint(20) NOT NULL DEFAULT 0 COMMENT 'Parent of Tree',
  `parent_uid` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `position` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'root for admin',
  `group` int(11) NOT NULL DEFAULT 0,
  `gen` int(11) NOT NULL DEFAULT 0,
  `level` int(11) NOT NULL DEFAULT 0,
  `tree_sponsor` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `tree` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `password_pin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `password_trx` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT 1 COMMENT '1=Administrator,2=Member',
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '0=Not Active,1=Active,2=Banned,3=Deleted',
  `birthdate` date NULL DEFAULT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `idcard` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `npwp` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `country` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `province` smallint(6) NOT NULL DEFAULT 0,
  `district` smallint(6) NOT NULL DEFAULT 0,
  `subdistrict` smallint(6) NULL DEFAULT NULL,
  `village` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `bank` int(11) NOT NULL DEFAULT 0,
  `bill` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bill_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `photo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `idcard_img` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `qrcode_img` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `total_omzet` double NOT NULL DEFAULT 0,
  `package_omzet` double NOT NULL DEFAULT 0,
  `rank` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `referral_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `as_stockist` tinyint(4) NOT NULL DEFAULT 0 COMMENT '1=ms, 2=stockist, 3=master',
  `as_stockist_pusat` tinyint(4) NOT NULL DEFAULT 0,
  `stockist_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `stockist_province` smallint(6) NULL DEFAULT NULL,
  `stockist_district` smallint(6) NULL DEFAULT NULL,
  `stockist_subdistrict` smallint(6) NULL DEFAULT NULL,
  `stockist_village` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `stockist_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `to_stockist` bigint(20) NOT NULL DEFAULT 0,
  `shop_invoice` smallint(6) NOT NULL DEFAULT 0,
  `shop_uniquecode` smallint(6) NOT NULL DEFAULT 0,
  `wd_status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '0=\"Otomatis Sistem\"; 1=\"Manual WD\"',
  `wd_min` int(11) NOT NULL DEFAULT 0,
  `agree_ethic` tinyint(4) NOT NULL DEFAULT 0,
  `change_password` smallint(6) NOT NULL DEFAULT 0,
  `last_login` datetime(0) NULL DEFAULT NULL,
  `member_hu` bigint(20) NOT NULL DEFAULT 0,
  `is_ro` int(11) NOT NULL DEFAULT 0,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
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
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'Solahudin', 'solahudin210', 'solahudin21042002@gmail.com', '2026-02-25 13:27:56', '$2y$12$3w2yaUD83tBFmm899F6hCekTiY.JHKQN8.2Xv0KjrI2TTcoJbIZW6', NULL, NULL, NULL, 'admin', 0, NULL, 0, NULL, 'root', 0, 0, 0, '1', '1', NULL, '', NULL, 1, 1, NULL, NULL, '0000000000000000', '', 'id', 6, 152, 2096, 'Kemayoran', 'Jakarta', 0, NULL, NULL, NULL, NULL, NULL, 0, 0, 'member', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, 1, 0, '2026-02-27 14:36:38', 0, 0, 'Y6hNiYuAEsQDUx1wmlTKgpHHRNObR115jW4da30cxsqkw3UpwW7c4cPH9gFA', '2026-02-25 13:27:34', '2026-02-27 14:36:38');
INSERT INTO `users` VALUES (2, 'Solahudin', 'solahudin2104200', 'solahudin@gmail.com', '2026-02-25 17:15:36', '$2y$12$NzV/bpI3gmPpGGgchY7lte3OM7/sNEuK0G4GKBNXFC7xyxebaf1Nm', NULL, NULL, NULL, 'free', 0, NULL, 0, NULL, '', 0, 0, 0, '', '', NULL, '', NULL, 1, 0, NULL, NULL, NULL, '', NULL, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, '2026-02-27 09:19:47', 0, 0, 'UjXzMDa7AaM4fE0YYeJhgy1oqgyT9zRvAnd2pBrpCaTWfc10KUXfCZkxk0ng', '2026-02-25 17:11:31', '2026-02-27 09:19:47');

-- ----------------------------
-- Table structure for video
-- ----------------------------
DROP TABLE IF EXISTS `video`;
CREATE TABLE `video`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sequence` int(11) NOT NULL,
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for video_progress
-- ----------------------------
DROP TABLE IF EXISTS `video_progress`;
CREATE TABLE `video_progress`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_member` bigint(20) NOT NULL,
  `id_video` bigint(20) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for withdraw
-- ----------------------------
DROP TABLE IF EXISTS `withdraw`;
CREATE TABLE `withdraw`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_member` bigint(20) NOT NULL,
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bank` int(11) NOT NULL,
  `bank_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bank_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `bank_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bill` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bill_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nominal` int(11) NOT NULL,
  `nominal_receipt` int(11) NOT NULL,
  `tax` int(11) NOT NULL,
  `auto_ro` int(11) NOT NULL,
  `admin_fund` int(11) NOT NULL,
  `status` tinyint(4) NULL DEFAULT 0,
  `flip_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `linkita_inquiry` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `inquiry_status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `linkita_pay` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `payment_status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `datecreated` datetime(0) NOT NULL,
  `datemodified` datetime(0) NOT NULL,
  `dateconfirmed` datetime(0) NULL DEFAULT NULL,
  `confirm_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `wd_id_member`(`id_member`) USING BTREE,
  INDEX `wd_type`(`type`) USING BTREE,
  INDEX `wd_status`(`status`) USING BTREE,
  INDEX `wd_linkita_inquiry`(`linkita_inquiry`) USING BTREE,
  INDEX `wd_linkita_pay`(`linkita_pay`) USING BTREE,
  INDEX `wd_date`(`datecreated`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
