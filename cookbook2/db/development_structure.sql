CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `created_at` datetime NOT NULL,
  `update_at` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP,
  `active` int(1) unsigned NOT NULL default '1',
  `rank` int(4) unsigned NOT NULL default '0',
  `title` varchar(128) collate utf8_unicode_ci NOT NULL,
  `instructions` text collate utf8_unicode_ci,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `categories_title` (`title`),
  KEY `categories_rank_title` (`rank`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `recipes` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `created_at` datetime NOT NULL,
  `update_at` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP,
  `active` int(1) unsigned NOT NULL default '1',
  `rank` int(4) unsigned NOT NULL default '0',
  `categories_id` int(10) unsigned NOT NULL default '1',
  `title` varchar(128) collate utf8_unicode_ci NOT NULL,
  `instructions` text collate utf8_unicode_ci,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `recipes_title` (`title`),
  KEY `recipes_rank_title` (`rank`,`title`),
  KEY `recipes_categ_rank_title` (`categories_id`,`rank`,`title`),
  CONSTRAINT `recipes_ibfk_1` FOREIGN KEY (`categories_id`) REFERENCES `categories` (`id`) ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `schema_info` (
  `version` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `schema_info` (version) VALUES (1)