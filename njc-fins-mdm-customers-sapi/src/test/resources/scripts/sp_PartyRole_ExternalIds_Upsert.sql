-- This Stored Procedure is to insert ExternalIds for PartyRole Object and its
-- dependency tables. It takes a JSON Array of ExternalIds objects
-- and creates them in MDM DB by generating an UUID.
DELIMITER //
CREATE PROCEDURE PartyRole_ExternalIds_Upsert(externalIdsRequestJSON JSON,partyRoleId VARCHAR(36))
BEGIN
	DECLARE id VARCHAR(36) default null;
	DECLARE partyRoleExternalId VARCHAR(36) default null;
	DECLARE externalIdObj JSON;
   	DECLARE externalIdOutput VARCHAR(36);
    DECLARE externalIdsArrayIndx INT DEFAULT 0;
    DECLARE errno INT;
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
	  		 -- call log_msg(CONCAT("id: ", id));
			SET externalIdObj = JSON_EXTRACT(externalIdsRequestJSON, CONCAT("$[", externalIdsArrayIndx, "]"));
			call ExternalIds_Upsert(externalIdObj,externalIdOutput);
			
			-- call log_msg(CONCAT("EXTERNAL_ID as @: ", externalIdOutput));
		    SET id = (SELECT externalIdOutput);
			-- call log_msg(CONCAT("EXTERNAL_ID: ", id));
		   	
			-- Check if the EXTERNAL_ID is already associated with PARTY_ROLE_ID and retrun the External ID of the record
	   		SET partyRoleExternalId = (SELECT eiprj.EXTERNAL_ID from EXTERNAL_ID_PARTY_ROLE_JOIN eiprj where eiprj.PARTY_ROLE_ID = partyRoleId and eiprj.EXTERNAL_ID=id);
		   	-- call log_msg(CONCAT("Inside update serach by partyRoleExternalId: ", partyRoleExternalId));
	   		IF(partyRoleExternalId IS NULL) THEN
		   		insert into EXTERNAL_ID_PARTY_ROLE_JOIN (EXTERNAL_ID,PARTY_ROLE_ID) values (id,partyRoleId);
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