-- This Stored Procedure is to insert RelatedParties for Party Object and its
-- dependency tables. It takes a JSON Array of RelatedParties objects
-- and stores them in MDM DB.
DELIMITER //
CREATE PROCEDURE Parties_RelatedParties_Upsert(relatedPartiesRequestJSON JSON,partyId VARCHAR(36))
BEGIN


	DECLARE createdDate DATETIME;
	DECLARE createdBy VARCHAR(500) default null;
	DECLARE updatedBy VARCHAR(500) default null;
	DECLARE updatedDate DATETIME;

	DECLARE id VARCHAR(36) default null;
	DECLARE relatedPartiesItemObj JSON;

    DECLARE partyRelationshipTypeId VARCHAR(36) default null;
    DECLARE partyRelationshipType VARCHAR(500) default null;
   	DECLARE relatedFromDate DATETIME;
   	DECLARE relatedToDate DATETIME;
   	DECLARE relatedParty VARCHAR(36) default null;
    DECLARE partyIdInDB VARCHAR(36) default null;

    DECLARE errno INT;
    DECLARE indx INT DEFAULT 0;
    DECLARE rowsUpdate INT DEFAULT 0;



    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    	GET CURRENT DIAGNOSTICS CONDITION 1 errno = MYSQL_ERRNO;
    	SELECT errno AS MYSQL_ERROR;
    	ROLLBACK;
			RESIGNAL;
    END;

    START TRANSACTION;

   		REPEAT
		-- call log_msg(CONCAT("partyId: ", partyId));
   			SET relatedPartiesItemObj = JSON_EXTRACT(relatedPartiesRequestJSON, CONCAT("$[", indx, "]"));
  		
		    SET partyRelationshipType = JSON_UNQUOTE(JSON_EXTRACT(relatedPartiesItemObj,'$.partyRelationshipType'));
		-- call log_msg(CONCAT("partyRelationshipType: ", partyRelationshipType));
		   	SET createdBy = JSON_UNQUOTE(JSON_EXTRACT(relatedPartiesItemObj,'$.createdBy'));
			SET createdDate = NOW() ;
		-- call log_msg(CONCAT("createdBy: ", createdBy));
			SET updatedBy = JSON_UNQUOTE(JSON_EXTRACT(relatedPartiesItemObj,'$.updatedBy'));
			SET updatedDate = NOW() ;
			
			IF(JSON_UNQUOTE(JSON_EXTRACT(relatedPartiesItemObj,'$.relatedFromDate')) IS NOT NULL) THEN
			  select CAST(JSON_UNQUOTE(JSON_EXTRACT(relatedPartiesItemObj,'$.relatedFromDate')) as DATETIME) into relatedFromDate;
			END IF;
		
			IF(JSON_UNQUOTE(JSON_EXTRACT(relatedPartiesItemObj,'$.relatedToDate')) IS NOT NULL) THEN
			  select CAST(JSON_UNQUOTE(JSON_EXTRACT(relatedPartiesItemObj,'$.relatedToDate')) as DATETIME) into relatedToDate;
			END IF;

			SET relatedParty = JSON_UNQUOTE(JSON_EXTRACT(relatedPartiesItemObj,'$.relatedParty'));
			
		-- call log_msg(CONCAT("Parties_RelatedParties_Upsert:relatedParty: ", relatedParty));
		
			SET id = (select prp.ID from PARTY_RELATED_PARTY prp where prp.PARTY_ID = id and prp.PARTY_RELATED_PARTY_ID = relatedParty ); 
			SET partyRelationshipTypeId = (select prt.ID from PARTY_RELATIONSHIP_TYPE prt where prt.NAME=partyRelationshipType);
			
			IF(id IS NULL) THEN
				SET id = UUID(); 
   				insert into PARTY_RELATED_PARTY (ID,PARTY_ID,PARTY_RELATED_PARTY_ID,RELATED_FROM_DATE, RELATED_TO_DATE, PARTY_RELATIONSHIP_TYPE ,CREATED_BY,CREATED_DATE,UPDATED_BY,UPDATED_DATE) values (id,partyId,relatedParty,relatedFromDate,relatedToDate,partyRelationshipTypeId,createdBy,createdDate,updatedBy,updatedDate);
   			ELSE
				update PARTY_RELATED_PARTY prp set 	PARTY_ID=partyId,PARTY_RELATED_PARTY_ID=relatedParty, prp.RELATED_FROM_DATE=relatedFromDate, prp.RELATED_TO_DATE=relatedToDate, prp.PARTY_RELATIONSHIP_TYPE=partyRelationshipTypeId, prp.UPDATED_BY=updatedBy, prp.UPDATED_DATE=updatedDate where prp.ID=id;
			END IF;
		
	 		SET indx = indx + 1;
			UNTIL indx = JSON_LENGTH(relatedPartiesRequestJSON)

		END REPEAT;
      COMMIT WORK;
END;
//
