-- This Stored Procedure is to insert/update ContactPointPhone Object and its
-- dependency tables. It takes a JSON Array of ContactPointPhone objects,partyId
-- and insert/updates them in MDM DB if the id of the object exists.
DELIMITER //
CREATE PROCEDURE ContactPointPhone_Upsert (queryParams JSON,partyId VARCHAR(36))
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
	DECLARE phoneJSONRecord JSON;
	DECLARE areaCode VARCHAR(500) default null;
	DECLARE countryName VARCHAR(500) default null;
	DECLARE extensionNumber VARCHAR(500) default null;
	DECLARE formattedE164PhoneNumber VARCHAR(500) default null;
	DECLARE formattedInternationalPhoneNumber VARCHAR(500) default null;
	DECLARE formattedNationalPhoneNumber VARCHAR(500) default null;
	DECLARE isFaxCapable TINYINT(1) default 0;
	DECLARE isSMSCapable TINYINT(1) default 0;
	DECLARE phoneCountryCode VARCHAR(500) default null;
	DECLARE primaryPhoneType VARCHAR(500) default null;
	DECLARE shortCode INT default 0;
	DECLARE telephoneNumber VARCHAR(500) default null;
	DECLARE contactPointType JSON default null;
    DECLARE contactPointTypeTxt VARCHAR(500) default null;
    DECLARE contactPointTypeId VARCHAR(36) default null;
	DECLARE contactPointName VARCHAR(500) default null;
	DECLARE contactPointTypePhoneId VARCHAR(36) default null;
	DECLARE externalIds JSON ;
    DECLARE externalIdTableId VARCHAR(36);
    DECLARE externalIdType VARCHAR(36);
	DECLARE cpTypeindx INT DEFAULT 0;
    DECLARE indx INT DEFAULT 0;
    DECLARE rowsUpdate INT DEFAULT 0;
    DECLARE primaryFlagContactPointId VARCHAR(36) default null;
   	DECLARE primaryContactPointId VARCHAR(36) default null;
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
	    	SET phoneJSONRecord = JSON_EXTRACT(queryParams, CONCAT("$[", indx, "]"));
	    	SET id = JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.id'));
	      -- call log_msg(CONCAT("id: ", id));

	     	IF(JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.activeFromDate')) IS NOT NULL) THEN
    			select CAST(JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.activeFromDate')) as DATETIME) into activeFromDate;
			END IF;
			IF(JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.activeToDate')) IS NOT NULL) THEN
    			select CAST(JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.activeToDate')) as DATETIME) into activeToDate;
			END IF;
			IF(JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.profileFirstCreatedDate')) IS NOT NULL) THEN
    			select CAST(JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.profileFirstCreatedDate')) as DATETIME) into profileFirstCreatedDate;
			END IF;
			IF(JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.profileLastUpdatedDate')) IS NOT NULL) THEN
				select CAST(JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.profileLastUpdatedDate')) as DATETIME) into profileLastUpdatedDate;
			END IF;
			IF(JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.bestTimeToContactEndTime')) IS NOT NULL) THEN
				select CAST(JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.bestTimeToContactEndTime')) as TIME) into bestTimeToContactEndTime;
			END IF;
			IF(JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.bestTimeToContactStartTime')) IS NOT NULL) THEN
				select CAST(JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.bestTimeToContactStartTime')) as TIME) into bestTimeToContactStartTime;
			END IF;

			SET areaCode = JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.areaCode'));
			SET countryName = JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.countryName'));
			SET extensionNumber = JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.extensionNumber'));
			SET formattedE164PhoneNumber = JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.formattedE164PhoneNumber'));
			SET formattedInternationalPhoneNumber = JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.formattedInternationalPhoneNumber'));
			SET formattedNationalPhoneNumber = JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.formattedNationalPhoneNumber'));
			SET isFaxCapable = JSON_EXTRACT(phoneJSONRecord,'$.isFaxCapable');
			SET isSMSCapable = JSON_EXTRACT(phoneJSONRecord,'$.isSMSCapable');
			SET contactPointName = JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.name'));
			SET phoneCountryCode = JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.phoneCountryCode'));
			SET primaryPhoneType = JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.primaryPhoneType'));
			SET shortCode = JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.shortCode'));
			SET telephoneNumber = JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.telephoneNumber'));
		-- call log_msg(CONCAT("After Phone Fields: ", telephoneNumber));
			SET profileOccurrenceCount = JSON_EXTRACT(phoneJSONRecord,'$.profileOccurrenceCount');
			SET forBusinessUse = JSON_EXTRACT(phoneJSONRecord,'$.forBusinessUse');
			SET forPersonalUse = JSON_EXTRACT(phoneJSONRecord,'$.forPersonalUse');
			SET isUsedForBilling = JSON_EXTRACT(phoneJSONRecord,'$.isUsedForBilling');
			SET isUsedForShipping = JSON_EXTRACT(phoneJSONRecord,'$.isUsedForShipping');
			SET primaryFlag = JSON_EXTRACT(phoneJSONRecord,'$.primaryFlag');
	     -- call log_msg(CONCAT("After Flag fields: ", primaryFlag));
			SET externalIds = JSON_EXTRACT(phoneJSONRecord,'$.externalIds');

			SET createdBy = JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.createdBy'));
			SET createdDate = NOW() ;
		 -- call log_msg(CONCAT("createdBy: ", createdBy));
			SET updatedBy = JSON_UNQUOTE(JSON_EXTRACT(phoneJSONRecord,'$.updatedBy'));
            SET updatedDate = NOW() ;
           
           	IF( id IS NULL) THEN
				SET insertFlag = 1;
		   		SET id = UUID();
		   	ELSE 
				SET insertFlag = 0;
			END IF;
		
			SET primaryContactPointId = (select cppj.CONTACT_POINT_ID from CONTACT_POINT_PHONE cpp,CONTACT_POINT_PHONE_PARTY_JOIN cpppj,CONTACT_POINT_PARTY_JOIN cppj  where cpp.PRIMARY_FLAG =1 and cpp.ID=cppj.CONTACT_POINT_ID and cpppj.CONTACT_POINT_PHONE_ID =cppj.CONTACT_POINT_ID and cpppj.PARTY_ID = partyId limit 1);
			
	    	 --  call log_msg(CONCAT("primaryFlag: ", primaryFlag));
			IF(primaryFlag = 1) THEN
				--  call log_msg(CONCAT("primaryFlagContactPointId: ", primaryFlagContactPointId));
				-- If primary flag is set, check if any of other records previously iterated have the flag as 1 if so do not set the flag else set it as 1 
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
				insert into CONTACT_POINT_PHONE (ID,ACTIVE_FROM_DATE,ACTIVE_TO_DATE,AREA_CODE,BEST_TIME_TO_CONTACT_END_TIME,BEST_TIME_TO_CONTACT_START_TIME,COUNTRY_NAME,CREATED_DATE,CREATED_BY,EXTENSION_NUMBER,FOR_BUSINESS_USE,FORMATTED_E164_PHONE_NUMBER,FORMATTED_INTERNATIONAL_PHONE_NUMBER,FORMATTED_NATIONAL_PHONE_NUMBER,FOR_PERSONAL_USE,IS_FAX_CAPABLE,IS_SM_SCAPABLE,NAME,PHONE_COUNTRY_CODE,PRIMARY_FLAG,PRIMARY_PHONE_TYPE,PROFILE_FIRST_CREATED_DATE,PROFILE_LAST_UPDATED_DATE,PROFILE_OCCURRENCE_COUNT,SHORT_CODE,TELEPHONE_NUMBER,UPDATED_DATE,UPDATED_BY) values (id,activeFromDate,activeToDate,areaCode,bestTimeToContactEndTime,bestTimeToContactStartTime,countryName,createdDate,createdBy,extensionNumber,forBusinessUse,formattedE164PhoneNumber,formattedInternationalPhoneNumber,formattedNationalPhoneNumber,forPersonalUse,isFaxCapable,isSMSCapable,contactPointName,phoneCountryCode,primaryFlag,primaryPhoneType,profileFirstCreatedDate,profileLastUpdatedDate,profileOccurrenceCount,shortCode,telephoneNumber,updatedDate,updatedBy);
			    insert into CONTACT_POINT_PHONE_PARTY_JOIN (CONTACT_POINT_PHONE_ID,PARTY_ID) values (id,partyId);
				SET contactPointType = JSON_EXTRACT(phoneJSONRecord,'$.contactPointType');
			
				-- Add the External Id for this Contact Point Id	   
				SET externalIdType = (select ext.ID from EXTERNAL_ID_TYPE ext where ext.NAME='MDM');
				insert into EXTERNAL_ID (ID,EXTERNAL_ID,EXTERNAL_ID_TYPE,STATUS,CREATED_DATE,CREATED_BY,UPDATED_DATE,UPDATED_BY) values (externalIdTableId,id,externalIdType,'VALID',createdDate,createdBy,updatedDate,updatedBy);
				insert into EXTERNAL_ID_CONTACT_POINT_JOIN (CONTACT_POINT_ID,EXTERNAL_ID) values (id,externalIdTableId);
				-- Upsert the External Id for this Contact Point Id	   
		        IF (externalIds IS NOT NULL) THEN
					CALL ContactPoints_ExternalIds_Upsert(externalIds,id);
				END IF;
	    
			-- call log_msg(contactPointType);
				REPEAT
					SET contactPointTypeTxt = JSON_UNQUOTE(JSON_EXTRACT(contactPointType, CONCAT("$[", cpTypeindx, "]")));
				    Call ContactPointType_Lookup (contactPointTypeTxt,@contactPointTypePhoneId);
			-- call log_msg(CONCAT("contactPointTypePhoneId: ", @contactPointTypePhoneId));
					insert into CONTACT_POINT_PHONE_CONTACT_POINT_TYPE_JOIN (CONTACT_POINT_PHONE_ID,CONTACT_POINT_TYPE_ID) values (id, @contactPointTypePhoneId);
					insert into CONTACT_POINT_CONTACT_POINT_TYPE_JOIN (CONTACT_POINT_ID,CONTACT_POINT_TYPE_ID) values (id, @contactPointTypePhoneId);
			-- call log_msg("Completed Inserts: ");
					SET cpTypeindx = cpTypeindx + 1;
				UNTIL cpTypeindx = JSON_LENGTH(contactPointType)
				END REPEAT;
				SET cpTypeindx = 0;
			ELSE
            
				Update CONTACT_POINT cp set cp.ACTIVE_FROM_DATE=activeFromDate,cp.ACTIVE_TO_DATE=activeToDate,cp.BEST_TIME_TO_CONTACT_END_TIME=bestTimeToContactEndTime,cp.BEST_TIME_TO_CONTACT_START_TIME=bestTimeToContactStartTime,cp.FOR_BUSINESS_USE=forBusinessUse,cp.FOR_PERSONAL_USE=forPersonalUse,cp.NAME=contactPointName,cp.PRIMARY_FLAG=primaryFlag,cp.PROFILE_FIRST_CREATED_DATE=profileFirstCreatedDate,cp.PROFILE_LAST_UPDATED_DATE=profileLastUpdatedDate,cp.PROFILE_OCCURRENCE_COUNT=profileOccurrenceCount,cp.UPDATED_BY=updatedBy,cp.UPDATED_DATE=updatedDate where cp.ID=id;
				Update CONTACT_POINT_PHONE cpp set cpp.ACTIVE_FROM_DATE=activeFromDate,cpp.ACTIVE_TO_DATE=activeToDate,cpp.AREA_CODE=areaCode,cpp.BEST_TIME_TO_CONTACT_END_TIME=bestTimeToContactEndTime,cpp.BEST_TIME_TO_CONTACT_START_TIME=bestTimeToContactStartTime,cpp.COUNTRY_NAME=countryName,cpp.EXTENSION_NUMBER=extensionNumber,cpp.FOR_BUSINESS_USE=forBusinessUse,cpp.FORMATTED_E164_PHONE_NUMBER=formattedE164PhoneNumber,cpp.FORMATTED_INTERNATIONAL_PHONE_NUMBER=formattedInternationalPhoneNumber,cpp.FORMATTED_NATIONAL_PHONE_NUMBER=formattedNationalPhoneNumber,cpp.FOR_PERSONAL_USE=forPersonalUse,cpp.IS_FAX_CAPABLE=isFaxCapable,cpp.IS_SM_SCAPABLE=isSMSCapable,cpp.NAME=contactPointName,cpp.PHONE_COUNTRY_CODE=phoneCountryCode,cpp.PRIMARY_FLAG=primaryFlag,cpp.PRIMARY_PHONE_TYPE=primaryPhoneType,cpp.PROFILE_FIRST_CREATED_DATE=profileFirstCreatedDate,cpp.PROFILE_LAST_UPDATED_DATE=profileLastUpdatedDate,cpp.PROFILE_OCCURRENCE_COUNT=profileOccurrenceCount,cpp.SHORT_CODE=shortCode,cpp.TELEPHONE_NUMBER=telephoneNumber,cpp.UPDATED_DATE=updatedDate,cpp.UPDATED_BY=updatedBy where cpp.ID=id;
			-- call log_msg(contactPointType);
				SET rowsUpdate = (select ROW_COUNT());
	  			IF (rowsUpdate = 0) THEN
	  				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid ContactPoint Id to update records';
	  			END IF;
				SET updatedDate = NOW() ;
	            IF (externalIds IS NOT NULL) THEN
						CALL ContactPoints_ExternalIds_Upsert(externalIds,id);
				END IF;
			END IF;
	
			SET indx = indx + 1;
			UNTIL indx = JSON_LENGTH(queryParams)
		END REPEAT;
				
		-- Reset the primaryFlag for existing ContactPoint in case another ContactPoint has come with the flag set.	
		IF ((primaryContactPointId IS NOT NULL) AND (primaryFlagContactPointId IS NOT NULL) AND (primaryContactPointId <> primaryFlagContactPointId))THEN
			UPDATE  CONTACT_POINT cp SET cp.PRIMARY_FLAG=0 WHERE  cp.ID = primaryContactPointId;
			UPDATE  CONTACT_POINT_PHONE cpp SET cpp.PRIMARY_FLAG=0 WHERE  cpp.ID = primaryContactPointId;
			-- call log_msg(CONCAT("After update by primaryContactPointId: ", primaryContactPointId));
		END IF;
		-- If there are no records with primaryFlag set the first record in the list to have primaryFlag set as 1. This is overriding the default value set either by Insert/Update queries above
		IF (primaryFlagContactPointId IS NULL) THEN
			UPDATE  CONTACT_POINT cp SET cp.PRIMARY_FLAG=1 WHERE  cp.ID = primaryFlagNoFirstContactPointId;
			UPDATE  CONTACT_POINT_PHONE cpp SET cpp.PRIMARY_FLAG=1 WHERE  cpp.ID = primaryFlagNoFirstContactPointId;
			-- call log_msg(CONCAT("After update by primaryFlagNoFirstContactPointId: ", primaryFlagNoFirstContactPointId));
		END IF;
		
 	COMMIT WORK;
END;
//