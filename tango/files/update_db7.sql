USE tango;

#
# Table structure for table 'property_pipe_class'
#

CREATE TABLE IF NOT EXISTS property_pipe_class (
  class varchar(255) NOT NULL default '',
  pipe varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  count int(11) NOT NULL default '0',
  value text default NULL,
  updated timestamp NOT NULL,
  accessed timestamp NOT NULL,
  comment text,
  KEY index_property_pipe_class (class(64),pipe(64),name(64),count)
) ENGINE=MyISAM;

#
# Table structure for table 'property_pipe_device'
#

CREATE TABLE IF NOT EXISTS property_pipe_device (
  device varchar(255) NOT NULL default '',
  pipe varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  count int(11) NOT NULL default '0',
  value text default NULL,
  updated timestamp NOT NULL,
  accessed timestamp NOT NULL,
  comment text,
  KEY index_property_pipe_device (device(64),pipe(64),name(64),count)
) ENGINE=MyISAM;

#
# For history ID
#

CREATE TABLE IF NOT EXISTS device_pipe_history_id (
  id bigint unsigned NOT NULL default '0'
) ENGINE=MyISAM;

CREATE TABLE IF NOT EXISTS class_pipe_history_id (
  id bigint unsigned NOT NULL default '0'
) ENGINE=MyISAM;

#
# History tables
#

CREATE TABLE IF NOT EXISTS property_pipe_class_hist (
  id bigint unsigned NOT NULL default '0',
  date timestamp NOT NULL,
  class varchar(255) NOT NULL default '',
  pipe varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  count int(11) NOT NULL default '0',
  value text,
  KEY index_id (id),
  KEY index_class (class),
  KEY index_pipe (pipe),
  KEY index_name (name)  
) ENGINE=MyISAM;

CREATE TABLE IF NOT EXISTS property_pipe_device_hist (
  id bigint unsigned NOT NULL default '0',
  date timestamp NOT NULL,
  device varchar(255) NOT NULL default '',
  pipe varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  count int(11) NOT NULL default '0',
  value text,
  KEY index_id (id),
  KEY index_device (device),
  KEY index_pipe (pipe),
  KEY index_name (name)  
) ENGINE=MyISAM;

#
# Load the new stored procedures
#

source stored_proc.sql

#
# Init new history ID
#

CALL init_history_ids();

#
# Update history id columns to support id on more than 32 bits
#

ALTER TABLE property_attribute_device_hist MODIFY id bigint unsigned NOT NULL default '0';
ALTER TABLE property_attribute_class_hist MODIFY id bigint unsigned NOT NULL default '0';
ALTER TABLE property_class_hist MODIFY id bigint unsigned NOT NULL default '0';
ALTER TABLE property_device_hist MODIFY id bigint unsigned NOT NULL default '0';
ALTER TABLE property_hist MODIFY id bigint unsigned NOT NULL default '0';

ALTER TABLE class_attribute_history_id MODIFY id bigint unsigned NOT NULL default '0';
ALTER TABLE class_history_id MODIFY id bigint unsigned NOT NULL default '0';
ALTER TABLE device_attribute_history_id MODIFY id bigint unsigned NOT NULL default '0';
ALTER TABLE device_history_id MODIFY id bigint unsigned NOT NULL default '0';
ALTER TABLE object_history_id MODIFY id bigint unsigned NOT NULL default '0';

#
# Create entries in the property_class tables for controlled access service
#

DELETE FROM property_class WHERE class='Database' AND count >= 32;

INSERT INTO property_class VALUES('Database','AllowedAccessCmd',32,'DbImportEvent',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',33,'DbGetDeviceAlias',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',34,'DbGetCSDbServerList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',35,'DbGetDeviceClassList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',36,'DbGetDeviceExportedList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',37,'DbGetHostServerList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',38,'DbGetAttributeAlias2',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',39,'DbGetAliasAttribute',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',40,'DbGetClassPipeProperty',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',41,'DbGetDevicePipeProperty',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',42,'DbGetClassPipeList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',43,'DbGetDevicePipeList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',44,'DbGetAttributeAliasList',NULL,NULL,NULL);

DELETE FROM property_class WHERE class='DServer' AND count >= 10;
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',10,'ZMQEventSubscriptionChange',NULL,NULL,NULL);

DELETE FROM property_class WHERE class='Starter' AND count >= 5;
INSERT INTO property_class VALUES('Starter','AllowedAccessCmd',5,'UpdateServerList',NULL,NULL,NULL);

