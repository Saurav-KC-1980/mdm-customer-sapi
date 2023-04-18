-- This Stored Procedure is to insert ExternalIds for Party Object and its
-- dependency tables. It takes a JSON Array of ExternalIds objects
-- and creates them in MDM DB by generating an UUID.
DELIMITER //
CREATE PROCEDURE Parties_ExternalIds_Upsert(externalIdsRequestJSON JSON,partyId VARCHAR(36))
BEGIN


	DECLARE id VARCHAR(36) default null;
    DECLARE partyExternalId VARCHAR(36) default null;
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
   	 		
		   	SET partyExternalId = (SELECT eipj.EXTERNAL_ID from EXTERNAL_ID_PARTY_JOIN eipj where eipj.PARTY_ID = partyId and eipj.EXTERNAL_ID= id);
   	 		-- call log_msg(CONCAT("partyExternalId: ", partyExternalId));
   	 		IF(partyExternalId IS NULL) THEN
		   	 	insert into EXTERNAL_ID_PARTY_JOIN (EXTERNAL_ID,PARTY_ID) values (id,partyId);
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
