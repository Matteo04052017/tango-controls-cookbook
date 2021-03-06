DROP DATABASE tango;
CREATE DATABASE tango;
USE tango;

#
# Create all database tables
#

source create_db_tables.sql

#
# Load the stored procedures
#

source stored_proc.sql

#
# Init the history identifiers
#

CALL init_history_ids();

#
# Create entry for database device server in device table
#

DELETE FROM device WHERE server='DataBaseds/2';

INSERT INTO device VALUES ('sys/database/2',NULL,'sys','database','2',0,'nada','nada','DataBaseds/2',0,'DataBase','nada',0,0,'nada');
INSERT INTO device VALUES ('dserver/DataBaseds/2',NULL,'dserver','DataBaseds','2',0,'nada','nada','DataBaseds/2',0,'DServer','nada',0,0,'nada');

#
# Create entry for test device server in device table
#

DELETE FROM device WHERE server='TangoTest/test';

INSERT INTO device VALUES ('sys/tg_test/1',NULL,'sys','tg_test','1',0,'nada','nada','TangoTest/test',0,'TangoTest','nada',0,0,'nada');
INSERT INTO device VALUES ('dserver/TangoTest/test',NULL,'dserver','TangoTest','test',0,'nada','nada','TangoTest/test',0,'DServer','nada',0,0,'nada');

#
# Create entry for Tango Control Access in device table
#

DELETE FROM device WHERE server='TangoAccessControl/1';
DELETE FROM server WHERE name='tangoaccesscontrol/1';

INSERT INTO device VALUES ('sys/access_control/1',NULL,'sys','access_control','1',0,'nada','nada','TangoAccessControl/1',0,'TangoAccessControl','nada',0,0,'nada');
INSERT INTO device VALUES ('dserver/TangoAccessControl/1',NULL,'dserver','TangoAccessControl','1',0,'nada','nada','TangoAccessControl/1',0,'DServer','nada',0,0,'nada');
INSERT INTO server VALUES ('tangoaccesscontrol/1','',0,0);

#
# Create default user access
#

CALL tango.init_tac_tables();

#
# Create entries in the property_class tables for controlled access service
#

DELETE FROM property_class WHERE class='Database';

INSERT INTO property_class VALUES('Database','AllowedAccessCmd',1,'DbGetServerInfo',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',2,'DbGetServerNameList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',3,'DbGetInstanceNameList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',4,'DbGetDeviceServerClassList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',5,'DbGetDeviceList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',6,'DbGetDeviceDomainList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',7,'DbGetDeviceFamilyList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',8,'DbGetDeviceMemberList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',9,'DbGetClassList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',10,'DbGetDeviceAliasList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',11,'DbGetObjectList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',12,'DbGetPropertyList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',13,'DbGetProperty',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',14,'DbGetClassPropertyList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',15,'DbGetClassProperty',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',16,'DbGetDevicePropertyList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',17,'DbGetDeviceProperty',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',18,'DbGetClassAttributeList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',19,'DbGetDeviceAttributeProperty',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',20,'DbGetDeviceAttributeProperty2',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',21,'DbGetLoggingLevel',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',22,'DbGetAliasDevice',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',23,'DbGetClassForDevice',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',24,'DbGetClassInheritanceForDevice',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',25,'DbGetDataForServerCache',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',26,'DbInfo',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',27,'DbGetClassAttributeProperty',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',28,'DbGetClassAttributeProperty2',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',29,'DbMysqlSelect',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',30,'DbGetDeviceInfo',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',31,'DbGetDeviceWideList',NULL,NULL,NULL);
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

#
#
#

DELETE FROM property_class WHERE class='DServer';

INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',1,'QueryClass',NULL,NULL,NULL);
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',2,'QueryDevice',NULL,NULL,NULL);
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',3,'EventSubscriptionChange',NULL,NULL,NULL);
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',4,'DevPollStatus',NULL,NULL,NULL);
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',5,'GetLoggingLevel',NULL,NULL,NULL);
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',6,'GetLoggingTarget',NULL,NULL,NULL);
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',7,'QueryWizardDevProperty',NULL,NULL,NULL);
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',8,'QueryWizardClassProperty',NULL,NULL,NULL);
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',9,'QuerySubDevice',NULL,NULL,NULL);
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',10,'ZMQEventSubscriptionChange',NULL,NULL,NULL);

#
#
#

DELETE FROM property_class WHERE class='Starter';

INSERT INTO property_class VALUES ('Starter','AllowedAccessCmd',1,'DevReadLog',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('Starter','AllowedAccessCmd',2,'DevStart',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('Starter','AllowedAccessCmd',3,'DevGetRunningServers',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('Starter','AllowedAccessCmd',4,'DevGetStopServers',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('Starter','AllowedAccessCmd',5,'UpdateServerList',NULL,NULL,NULL);

#
#
#

DELETE FROM property_class WHERE class='TangoAccessControl';

INSERT INTO property_class VALUES ('TangoAccessControl','AllowedAccessCmd',1,'GetUsers',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('TangoAccessControl','AllowedAccessCmd',2,'GetAddressByUser',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('TangoAccessControl','AllowedAccessCmd',3,'GetDeviceByUser',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('TangoAccessControl','AllowedAccessCmd',4,'GetAccess',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('TangoAccessControl','AllowedAccessCmd',5,'GetAllowedCommands',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('TangoAccessControl','AllowedAccessCmd',6,'GetAllowedCommandClassList',NULL,NULL,NULL);


