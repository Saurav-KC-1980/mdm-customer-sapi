-- This Stored Procedure is to insert/upsert Households Object and its
-- dependency tables. It takes a JSON Array of Households objects
-- and creates them in MDM by generating an UUID or updates if it exists.
DELIMITER //
CREATE PROCEDURE Households_Upsert (householdRequestJSON JSON,OUT householdId VARCHAR(36))
BEGIN

	DECLARE createdBy VARCHAR(500) default null;
	DECLARE createdDate DATETIME default null;
	DECLARE globalParty VARCHAR(500) default null;
	DECLARE householdMemberCount INT ;
	DECLARE householdFormedDate DATE default null;
	DECLARE householdDissolvedDate DATE default null;
	DECLARE id VARCHAR(36) default null;
	DECLARE partyType VARCHAR(50) default null;
	DECLARE noMergeReason VARCHAR(500) default null;
	DECLARE name VARCHAR(500) default null;
	DECLARE primaryAccount VARCHAR(50) default null;
	DECLARE updatedBy VARCHAR(500) default null;
	DECLARE updatedDate DATETIME default null;
	DECLARE externalIdTableId VARCHAR(36) ;
    DECLARE externalIdType VARCHAR(500) default null;
    DECLARE errno INT;

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    	GET CURRENT DIAGNOSTICS CONDITION 1 errno = MYSQL_ERRNO;
    	SELECT errno AS MYSQL_ERROR;
    	ROLLBACK;
		RESIGNAL;
    END;

    START TRANSACTION;
		SET id = JSON_UNQUOTE(JSON_EXTRACT(householdRequestJSON,'$.id'));
		SET householdMemberCount = JSON_EXTRACT(householdRequestJSON,'$.householdMemberCount');
		SET householdFormedDate =  JSON_UNQUOTE(JSON_EXTRACT(householdRequestJSON,'$.householdFormedDate'));
		SET householdDissolvedDate =  JSON_UNQUOTE(JSON_EXTRACT(householdRequestJSON,'$.householdDissolvedDate'));
		SET name =  JSON_UNQUOTE(JSON_EXTRACT(householdRequestJSON,'$.name'));
		SET globalParty =  JSON_UNQUOTE(JSON_EXTRACT(householdRequestJSON,'$.globalParty'));
		SET noMergeReason =  JSON_UNQUOTE(JSON_EXTRACT(householdRequestJSON,'$.noMergeReason'));
		SET partyType =  JSON_UNQUOTE(JSON_EXTRACT(householdRequestJSON,'$.partyType'));
		SET primaryAccount = JSON_UNQUOTE(JSON_EXTRACT(householdRequestJSON,'$.primaryAccount'));
		IF(JSON_UNQUOTE(JSON_EXTRACT(householdRequestJSON,'$.householdDissolvedDate')) IS NOT NULL) THEN
		    select CAST(JSON_UNQUOTE(JSON_EXTRACT(householdRequestJSON,'$.householdDissolvedDate')) as DATE) into householdDissolvedDate;
		END IF;
		IF(JSON_UNQUOTE(JSON_EXTRACT(householdRequestJSON,'$.householdFormedDate')) IS NOT NULL) THEN
		    select CAST(JSON_UNQUOTE(JSON_EXTRACT(householdRequestJSON,'$.householdFormedDate')) as DATE) into householdFormedDate;
		END IF;
		SET createdBy = JSON_UNQUOTE(JSON_EXTRACT(householdRequestJSON,'$.createdBy'));
		SET createdDate = NOW() ;
	-- call log_msg(CONCAT("createdBy: ", createdBy));
		SET updatedBy = JSON_UNQUOTE(JSON_EXTRACT(householdRequestJSON,'$.updatedBy'));
		SET updatedDate = NOW() ;

		SET id = (select hh.ID from HOUSEHOLD hh where hh.ID = id);
		IF (id IS NULL) THEN
	  		SET id = UUID();
	  		SET externalIdTableId = UUID();
			insert into PARTY (ID,PARTY_TYPE,GLOBAL_PARTY,NO_MERGE_REASON,CREATED_BY,CREATED_DATE,UPDATED_BY,UPDATED_DATE) values (id,partyType,globalParty,noMergeReason,createdBy,createdDate,updatedBy,updatedDate);
		-- 	call log_msg("inside insert household ");
			insert into HOUSEHOLD (ID,PARTY_TYPE,GLOBAL_PARTY,NO_MERGE_REASON, CREATED_BY,CREATED_DATE,NAME,HOUSEHOLD_MEMBER_COUNT, HOUSEHOLD_FORMED_DATE,HOUSEHOLD_DISSOLVED_DATE,UPDATED_BY,UPDATED_DATE) values (
			id,partyType,globalParty,noMergeReason,createdBy,createdDate,name,householdMemberCount,householdFormedDate,householdDissolvedDate, updatedBy,updatedDate);
			-- call log_msg("after household ");
			SET externalIdType = (select ext.ID from EXTERNAL_ID_TYPE ext where ext.NAME='MDM');
		-- Add the External Id for this household Id	
			insert into EXTERNAL_ID (ID,EXTERNAL_ID,EXTERNAL_ID_TYPE,STATUS,CREATED_BY,CREATED_DATE,UPDATED_BY,UPDATED_DATE) values (externalIdTableId,id,externalIdType,'VALID',createdBy,createdDate,updatedBy,updatedDate);
			insert into EXTERNAL_ID_PARTY_JOIN (EXTERNAL_ID,PARTY_ID) values (externalIdTableId,id);
		-- call log_msg("after EXTERNAL_ID_PARTY_JOIN ");
		ELSE
		-- 	call log_msg("inside update household ");
			update HOUSEHOLD hh set hh.NAME=name, hh.HOUSEHOLD_MEMBER_COUNT=householdMemberCount, hh.HOUSEHOLD_DISSOLVED_DATE=householdDissolvedDate,
			hh.GLOBAL_PARTY=globalParty,hh.NO_MERGE_REASON=noMergeReason, hh.UPDATED_BY = updatedBy,hh.UPDATED_DATE=updatedDate
			where hh.ID = id;
	   END IF;
	   SET householdId = id;
  COMMIT WORK;
END;
//