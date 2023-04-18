-- This Stored Procedure is to insert ExternalIds for ContactPoint Object and its
-- dependency tables. It takes a JSON Array of ExternalIds objects
-- and creates them in MDM DB by generating an UUID.
DELIMITER //
CREATE PROCEDURE ContactPoints_ExternalIds_Upsert(externalIdsRequestJSON JSON,contactPointId VARCHAR(36))
BEGIN

	DECLARE id VARCHAR(36) default null;
	DECLARE contactPointExternalId VARCHAR(36) default null;
	DECLARE externalIdObj JSON;
   	DECLARE externalIdOutput VARCHAR(36);
    DECLARE errno INT;
    DECLARE externalIdsArrayIndx INT DEFAULT 0;
    DECLARE rowsUpdated INT DEFAULT 0;
     
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    	GET CURRENT DIAGNOSTICS CONDITION 1 errno = MYSQL_ERRNO;
    	SELECT errno AS MYSQL_ERROR;
    	ROLLBACK;
			RESIGNAL;
    END;

    START TRANSACTION;
   		REPEAT
   			SET externalIdObj = JSON_EXTRACT(externalIdsRequestJSON, CONCAT("$[", externalIdsArrayIndx, "]"));
		    
   			call ExternalIds_Upsert(externalIdObj,externalIdOutput);
  	 		
		   	-- call log_msg(CONCAT("EXTERNAL_ID as @: ", externalIdOutput));
  	 		SET id = (SELECT externalIdOutput);
			-- call log_msg(CONCAT("EXTERNAL_ID: ", id));
   	 		
		   	SET contactPointExternalId = (SELECT eicpj.EXTERNAL_ID from EXTERNAL_ID_CONTACT_POINT_JOIN eicpj where eicpj.CONTACT_POINT_ID = contactPointId and eicpj.EXTERNAL_ID= id);
   	 		-- call log_msg(CONCAT("contactPointExternalId: ", contactPointExternalId));
   	 		IF(contactPointExternalId IS NULL) THEN
		   	 	insert into EXTERNAL_ID_CONTACT_POINT_JOIN (EXTERNAL_ID,CONTACT_POINT_ID) values (id,contactPointId);
		   	END IF;
		   	
		   	SET rowsUpdated = (select ROW_COUNT());
  		   	IF (rowsUpdated = 0) THEN
  				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid ExternalId to Insert/Update records';
  			END IF;
		   	
  			SET externalIdsArrayIndx = externalIdsArrayIndx + 1;
			UNTIL externalIdsArrayIndx = JSON_LENGTH(externalIdsRequestJSON)
		END REPEAT;
     COMMIT WORK;
 END;
 //
