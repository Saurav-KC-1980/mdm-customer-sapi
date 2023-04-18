-- This Stored Procedure is to insert/update ContactPointEmail Object and its
-- dependency tables. It takes a JSON Array of ContactPointEmail objects,partyId
-- and inserts/updates them in MDM DB if the id of the object exists.
DELIMITER //
CREATE PROCEDURE ContactPointEmail_Upsert (queryParams JSON,partyId VARCHAR(36))
BEGIN
	DECLARE id VARCHAR(36) default null;
	DECLARE activeFromDate DATE default null;
	DECLARE activeToDate DATE default null;
	DECLARE bestTimeToContactEndTime TIME default null;
	DECLARE bestTimeToContactStartTime TIME ;
	DECLARE createdBy VARCHAR(500);
	DECLARE createdDate DATETIME;
	DECLARE forBusinessUse TINYINT(1) DEFAULT 0;
	DECLARE forPersonalUse TINYINT(1) DEFAULT 0;
	DECLARE isUsedForBilling TINYINT(1) DEFAULT 0;
	DECLARE isUsedForShipping TINYINT(1) DEFAULT 0;
	DECLARE primaryFlag TINYINT(1) DEFAULT 0;
	DECLARE profileFirstCreatedDate TIME ;
	DECLARE profileLastUpdatedDate TIME ;
	DECLARE profileOccurrenceCount INT default 0;
	DECLARE updatedBy VARCHAR(500);
	DECLARE updatedDate DATETIME;
	DECLARE emailJSONRecord JSON;
	DECLARE emailAddress VARCHAR(500) default null;
	DECLARE emailBouncedReason VARCHAR(500) default null;
	DECLARE emailDomain VARCHAR(500) default null;
	DECLARE emailLatestBounceDateTime DATE;
	DECLARE emailMailBox VARCHAR(500) default null;
	DECLARE contactPointType JSON default null;
    DECLARE contactPointTypeTxt VARCHAR(500) default null;
	DECLARE contactPointName VARCHAR(500) default null;
	DECLARE contactPointTypeEmailId VARCHAR(36) default null;
	DECLARE contactPointTypeId VARCHAR(36) default null;
    DECLARE externalIds JSON ;
    DECLARE externalIdTableId VARCHAR(36);
    DECLARE externalIdType VARCHAR(36);
    DECLARE cpTypeindx INT DEFAULT 0;
    DECLARE indx INT DEFAULT 0;
    DECLARE rowsUpdate INT DEFAULT 0;
   	DECLARE primaryContactPointId VARCHAR(36) default null;
    DECLARE primaryFlagContactPointId VARCHAR(36) default null;
    DECLARE primaryFlagNoFirstContactPointId VARCHAR(36) default null;
   	DECLARE insertFlag TINYINT(1) DEFAULT 0;


    DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    	GET CURRENT DIAGNOSTICS CONDITION 1 errno = MYSQL_ERRNO;
    	SELECT errno AS MYSQL_ERROR;
    	ROLLBACK;
			RESIGNAL;
    END;

    START TRANSACTION;

	 	REPEAT
		  -- call log_msg(CONCAT("Initial indx: ",indx));
		  -- call log_msg(CONCAT("Initial array size: ",JSON_LENGTH(queryParams)));
	    	SET emailJSONRecord = JSON_EXTRACT(queryParams, CONCAT("$[", indx, "]"));
	    	SET id =  JSON_UNQUOTE(JSON_EXTRACT(emailJSONRecord,'$.id'));
	      -- call log_msg(CONCAT("id: ", id));

			IF(JSON_UNQUOTE(JSON_EXTRACT(emailJSONRecord,'$.activeFromDate')) IS NOT NULL) THEN
			  select CAST(JSON_UNQUOTE(JSON_EXTRACT(emailJSONRecord,'$.activeFromDate')) as DATETIME) into activeFromDate;
			END IF;
			IF(JSON_UNQUOTE(JSON_EXTRACT(emailJSONRecord,'$.activeToDate')) IS NOT NULL) THEN
			  select CAST(JSON_UNQUOTE(JSON_EXTRACT(emailJSONRecord,'$.activeToDate')) as DATETIME) into activeToDate;
			END IF;
			IF(JSON_UNQUOTE(JSON_EXTRACT(emailJSONRecord,'$.profileFirstCreatedDate')) IS NOT NULL) THEN
			  select CAST(JSON_UNQUOTE(JSON_EXTRACT(emailJSONRecord,'$.profileFirstCreatedDate')) as DATETIME) into profileFirstCreatedDate;
			END IF;
			IF(JSON_UNQUOTE(JSON_EXTRACT(emailJSONRecord,'$.profileLastUpdatedDate')) IS NOT NULL) THEN
			select CAST(JSON_UNQUOTE(JSON_EXTRACT(emailJSONRecord,'$.profileLastUpdatedDate')) as DATETIME) into profileLastUpdatedDate;
			END IF;
			IF(JSON_UNQUOTE(JSON_EXTRACT(emailJSONRecord,'$.bestTimeToContactEndTime')) IS NOT NULL) THEN
			select CAST(JSON_UNQUOTE(JSON_EXTRACT(emailJSONRecord,'$.bestTimeToContactEndTime')) as TIME) into bestTimeToContactEndTime;
			END IF;
			IF(JSON_UNQUOTE(JSON_EXTRACT(emailJSONRecord,'$.bestTimeToContactStartTime')) IS NOT NULL) THEN
			select CAST(JSON_UNQUOTE(JSON_EXTRACT(emailJSONRecord,'$.bestTimeToContactStartTime')) as TIME) into bestTimeToContactStartTime;
			END IF;
			IF(JSON_UNQUOTE(JSON_EXTRACT(emailJSONRecord,'$.emailLatestBounceDateTime')) IS NOT NULL) THEN
				select CAST(JSON_UNQUOTE(JSON_EXTRACT(emailJSONRecord,'$.emailLatestBounceDateTime')) as DATE) into emailLatestBounceDateTime;
			END IF;

			SET emailAddress = JSON_UNQUOTE(JSON_EXTRACT(emailJSONRecord,'$.emailAddress'));
			SET emailBouncedReason = JSON_UNQUOTE(JSON_EXTRACT(emailJSONRecord,'$.emailBouncedReason'));
			SET emailDomain = JSON_UNQUOTE(JSON_EXTRACT(emailJSONRecord,'$.emailDomain'));
			SET emailMailBox = JSON_UNQUOTE(JSON_EXTRACT(emailJSONRecord,'$.emailMailBox'));
			SET contactPointName = JSON_UNQUOTE(JSON_EXTRACT(emailJSONRecord,'$.name'));
	   	 -- call log_msg(CONCAT("After Email Fields: ", emailMailBox));
			SET profileOccurrenceCount = JSON_EXTRACT(emailJSONRecord,'$.profileOccurrenceCount');
			SET forBusinessUse = JSON_EXTRACT(emailJSONRecord,'$.forBusinessUse');
			SET forPersonalUse = JSON_EXTRACT(emailJSONRecord,'$.forPersonalUse');
			SET isUsedForBilling = JSON_EXTRACT(emailJSONRecord,'$.isUsedForBilling');
			SET isUsedForShipping = JSON_EXTRACT(emailJSONRecord,'$.isUsedForShipping');
			SET primaryFlag = JSON_EXTRACT(emailJSONRecord,'$.primaryFlag');
            SET externalIds = JSON_EXTRACT(emailJSONRecord,'$.externalIds');

	     -- call log_msg(CONCAT("After Flag fields: ", primaryFlag));

			SET createdBy = JSON_UNQUOTE(JSON_EXTRACT(emailJSONRecord,'$.createdBy'));
			SET createdDate = NOW() ;
		 -- call log_msg(CONCAT("createdBy: ", createdBy));
			SET updatedBy = JSON_UNQUOTE(JSON_EXTRACT(emailJSONRecord,'$.updatedBy'));
			SET updatedDate = NOW() ;
			
			IF( id IS NULL) THEN
				SET insertFlag = 1;
		   		SET id = UUID();
		   	ELSE 
				SET insertFlag = 0;
			END IF;
		
			SET primaryContactPointId = (select cppj.CONTACT_POINT_ID from CONTACT_POINT_EMAIL cpe,CONTACT_POINT_EMAIL_PARTY_JOIN cpepj,CONTACT_POINT_PARTY_JOIN cppj  where cpe.PRIMARY_FLAG =1 and cpe.ID=cppj.CONTACT_POINT_ID and cpepj.CONTACT_POINT_EMAIL_ID =cppj.CONTACT_POINT_ID and cpepj.PARTY_ID = partyId limit 1);
			
	     --  call log_msg(CONCAT("primaryFlag: ", primaryFlag));
			IF(primaryFlag = 1) THEN
				-- If primary flag is set, check if any of other records previously iterated have the flag as 1 if so do not set the flag else set it as 1 
				--  call log_msg(CONCAT("primaryFlagContactPointId: ", primaryFlagContactPointId));
				IF (primaryFlagContactPointId IS NULL) THEN
					SET primaryFlagContactPointId = id;
					SET primaryFlag = 1;
			 		--  call log_msg(CONCAT("primaryFlagContactPointId: ", primaryFlagContactPointId));
				ELSE 
					SET primaryFlag = 0;
					-- call log_msg(CONCAT("Resetting primaryFlagContactPointId: ", primaryFlagContactPointId));
				END IF;
			ELSE
				-- call log_msg(CONCAT("Else block of primaryFlag: ", primaryFlag));
				SET primaryFlag = 0;
				-- If there is already a ContactPoint that has primaryFlag as true, try retaining it if there is no other input with primaryFlag set
				IF (primaryContactPointId IS NOT NULL) THEN
					set primaryFlagNoFirstContactPointId = primaryContactPointId;
				END IF;
				-- Get the first contact point id record in the list to set the primary flag
				IF (primaryFlagNoFirstContactPointId IS NULL) THEN
					SET primaryFlagNoFirstContactPointId = id;
				-- 	call log_msg(CONCAT("primaryFlagNoFirstContactPointId: ", primaryFlagNoFirstContactPointId));
				END IF;
			END IF;
		
			IF (insertFlag = 1) THEN
	    	    SET externalIdTableId = UUID();
				insert into CONTACT_POINT (ACTIVE_FROM_DATE,ACTIVE_TO_DATE,BEST_TIME_TO_CONTACT_END_TIME,BEST_TIME_TO_CONTACT_START_TIME,CREATED_BY,CREATED_DATE,FOR_BUSINESS_USE,FOR_PERSONAL_USE,ID,NAME,PRIMARY_FLAG,PROFILE_FIRST_CREATED_DATE,PROFILE_LAST_UPDATED_DATE,PROFILE_OCCURRENCE_COUNT,UPDATED_BY,UPDATED_DATE) values (activeFromDate,activeToDate,bestTimeToContactEndTime,bestTimeToContactStartTime,createdBy,createdDate,forBusinessUse,forPersonalUse,id,contactPointName,primaryFlag,profileFirstCreatedDate,profileLastUpdatedDate,profileOccurrenceCount,updatedBy,updatedDate);
			    insert into CONTACT_POINT_PARTY_JOIN (CONTACT_POINT_ID,PARTY_ID) values (id,partyId);
				-- Hardcoded EMAIL_LATEST_BOUNCE_DATE_TIME to null.
			    insert into CONTACT_POINT_EMAIL (ID,ACTIVE_FROM_DATE,ACTIVE_TO_DATE,BEST_TIME_TO_CONTACT_END_TIME,BEST_TIME_TO_CONTACT_START_TIME,CREATED_BY,CREATED_DATE,EMAIL_ADDRESS,EMAIL_LATEST_BOUNCE_REASON_TEXT,EMAIL_DOMAIN,EMAIL_LATEST_BOUNCE_DATE_TIME,EMAIL_MAIL_BOX,FOR_BUSINESS_USE,FOR_PERSONAL_USE,NAME,PRIMARY_FLAG,PROFILE_FIRST_CREATED_DATE,PROFILE_LAST_UPDATED_DATE,PROFILE_OCCURRENCE_COUNT,UPDATED_DATE,UPDATED_BY) values (id,activeFromDate,activeToDate,bestTimeToContactEndTime,bestTimeToContactStartTime,createdBy,createdDate,emailAddress,emailBouncedReason,emailDomain,null,emailMailBox,forBusinessUse,forPersonalUse,contactPointName,primaryFlag,profileFirstCreatedDate,profileLastUpdatedDate,profileOccurrenceCount,updatedDate,updatedBy);
				insert into CONTACT_POINT_EMAIL_PARTY_JOIN (CONTACT_POINT_EMAIL_ID,PARTY_ID) values (id,partyId);
				
				-- Add the External Id for this Contact Point Id	   
				SET externalIdType = (select ext.ID from EXTERNAL_ID_TYPE ext where ext.NAME='MDM');
				insert into EXTERNAL_ID (ID,EXTERNAL_ID,EXTERNAL_ID_TYPE,STATUS,CREATED_DATE,CREATED_BY,UPDATED_DATE,UPDATED_BY) values (externalIdTableId,id,externalIdType,'VALID',createdDate,createdBy,updatedDate,updatedBy);
				insert into EXTERNAL_ID_CONTACT_POINT_JOIN (CONTACT_POINT_ID,EXTERNAL_ID) values (id,externalIdTableId);
				-- Upsert the External Id for this Contact Point Id	   
		        IF (externalIds IS NOT NULL) THEN
					CALL ContactPoints_ExternalIds_Upsert(externalIds,id);
				END IF;		
			
				
				SET contactPointType = JSON_EXTRACT(emailJSONRecord,'$.contactPointType');

			-- call log_msg(contactPointType);
				REPEAT
					SET contactPointTypeTxt = JSON_UNQUOTE(JSON_EXTRACT(contactPointType, CONCAT("$[", cpTypeindx, "]")));
				    Call ContactPointType_Lookup (contactPointTypeTxt,@contactPointTypeEmailId);
			-- call log_msg(CONCAT("contactPointTypeId: ", @contactPointTypeEmailId));
					insert into CONTACT_POINT_EMAIL_CONTACT_POINT_TYPE_JOIN (CONTACT_POINT_EMAIL_ID,CONTACT_POINT_TYPE_ID) values (id, @contactPointTypeEmailId);
					insert into CONTACT_POINT_CONTACT_POINT_TYPE_JOIN (CONTACT_POINT_ID,CONTACT_POINT_TYPE_ID) values (id, @contactPointTypeEmailId);
			-- call log_msg("Completed Inserts: ");
					SET cpTypeindx = cpTypeindx + 1;
				UNTIL cpTypeindx = JSON_LENGTH(contactPointType)
				END REPEAT;
				SET cpTypeindx = 0;
			ELSE
				Update CONTACT_POINT cp set cp.ACTIVE_FROM_DATE=activeFromDate,cp.ACTIVE_TO_DATE=activeToDate,cp.BEST_TIME_TO_CONTACT_END_TIME=bestTimeToContactEndTime,cp.BEST_TIME_TO_CONTACT_START_TIME=bestTimeToContactStartTime,cp.FOR_BUSINESS_USE=forBusinessUse,cp.FOR_PERSONAL_USE=forPersonalUse,cp.NAME=contactPointName,cp.PRIMARY_FLAG=primaryFlag,cp.PROFILE_FIRST_CREATED_DATE=profileFirstCreatedDate,cp.PROFILE_LAST_UPDATED_DATE=profileLastUpdatedDate,cp.PROFILE_OCCURRENCE_COUNT=profileOccurrenceCount,cp.UPDATED_BY=updatedBy,cp.UPDATED_DATE=updatedDate where cp.ID=id;
				-- Hardcoded EMAIL_LATEST_BOUNCE_DATE_TIME to null
				Update CONTACT_POINT_EMAIL cpe set cpe.ACTIVE_FROM_DATE=activeFromDate,cpe.ACTIVE_TO_DATE=activeToDate,cpe.BEST_TIME_TO_CONTACT_END_TIME=bestTimeToContactEndTime,cpe.BEST_TIME_TO_CONTACT_START_TIME=bestTimeToContactStartTime,cpe.EMAIL_ADDRESS=emailAddress,cpe.EMAIL_LATEST_BOUNCE_REASON_TEXT=emailBouncedReason,cpe.EMAIL_DOMAIN=emailDomain,cpe.EMAIL_LATEST_BOUNCE_DATE_TIME=null,cpe.EMAIL_MAIL_BOX=emailMailBox,cpe.FOR_BUSINESS_USE=forBusinessUse,cpe.FOR_PERSONAL_USE=forPersonalUse,cpe.NAME=contactPointName,cpe.PRIMARY_FLAG=primaryFlag,cpe.PROFILE_FIRST_CREATED_DATE=profileFirstCreatedDate,cpe.PROFILE_LAST_UPDATED_DATE=profileLastUpdatedDate,cpe.PROFILE_OCCURRENCE_COUNT=profileOccurrenceCount,cpe.UPDATED_DATE=updatedDate,cpe.UPDATED_BY=updatedBy where cpe.ID=id;
	
				SET rowsUpdate = (select ROW_COUNT());
	  			IF (rowsUpdate = 0) THEN
	  				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid ContactPoint Id to update records';
	  			END IF;
			END IF;
			
			-- Upsert the External Id for this Contact Point Id	   
			IF (externalIds IS NOT NULL) THEN
				CALL ContactPoints_ExternalIds_Upsert(externalIds,id);
			END IF;
		
			SET indx = indx + 1;
			UNTIL indx = JSON_LENGTH(queryParams)
		END REPEAT;
		
		-- Reset the primaryFlag for existing ContactPoint in case another ContactPoint has come with the flag set.	
		IF ((primaryContactPointId IS NOT NULL) AND (primaryFlagContactPointId IS NOT NULL) AND (primaryContactPointId <> primaryFlagContactPointId))THEN
			UPDATE  CONTACT_POINT cp SET cp.PRIMARY_FLAG=0 WHERE  cp.ID = primaryContactPointId;
			UPDATE  CONTACT_POINT_EMAIL cpe SET cpe.PRIMARY_FLAG=0 WHERE  cpe.ID = primaryContactPointId;
			-- call log_msg(CONCAT("After update by primaryContactPointId: ", primaryContactPointId));
		END IF;
		-- If there are no records with primaryFlag set the first record in the list to have primaryFlag set as 1. This is overriding the default value set either by Insert/Update queries above
		IF (primaryFlagContactPointId IS NULL) THEN
			UPDATE  CONTACT_POINT cp SET cp.PRIMARY_FLAG=1 WHERE  cp.ID = primaryFlagNoFirstContactPointId;
			UPDATE  CONTACT_POINT_EMAIL cpe SET cpe.PRIMARY_FLAG=1 WHERE  cpe.ID = primaryFlagNoFirstContactPointId;
			-- call log_msg(CONCAT("After update by primaryFlagNoFirstContactPointId: ", primaryFlagNoFirstContactPointId));
		END IF;
	
 	COMMIT WORK;
END;
//