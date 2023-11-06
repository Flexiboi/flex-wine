CREATE TABLE IF NOT EXISTS `wine_barrels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `barrelid` varchar(50) DEFAULT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `coords` text DEFAULT NULL,
  `zone` varchar(50) DEFAULT 'zone1',
  `fill` int(11) DEFAULT 0,
  `progress` int(11) DEFAULT 0,
  `stage` varchar(50) DEFAULT 'cabernet',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7123 DEFAULT CHARSET=utf8mb4;