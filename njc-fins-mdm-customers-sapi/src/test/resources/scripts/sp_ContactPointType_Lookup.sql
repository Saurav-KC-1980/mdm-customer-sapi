-- This Stored Procedure is to retrieve ContactPoints Object based on name(ContactPointAddress,
-- ContactPointEmail,ContactPointPhone). It sets the contactPointTypeId of the name provided as
-- input.
DELIMITER //
CREATE PROCEDURE ContactPointType_Lookup (name VARCHAR(500), OUT contactPointTypeId VARCHAR(36))
BEGIN
	select ID into contactPointTypeId from CONTACT_POINT_TYPE cpt where cpt.NAME=name;
END;
//