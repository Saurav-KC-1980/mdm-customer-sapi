-- This Stored Procedure is to insert/update ContactPointAddress Object and its
-- dependency tables. It takes a JSON Array of ContactPointAddress objects,partyId
-- and insert/updates them in MDM DB if the id of the object exists.
DELIMITER //
CREATE PROCEDURE ContactPointAddress_Upsert (queryParams JSON,partyId VARCHAR(36))
BEGIN
	DECLARE id VARCHAR(36) default null;
	DECLARE activeFromDate DATE default null;
	DECLARE activeToDate DATE default null;
	DECLARE addressLine1 VARCHAR(500) default null;
	DECLARE addressLine2 VARCHAR(500) default null;
	DECLARE addressLine3 VARCHAR(500) default null;
	DECLARE addressLine4 VARCHAR(500) default null;
	DECLARE bestTimeToContactEndTime TIME default null;
	DECLARE bestTimeToContactStartTime TIME default null;
	DECLARE cityName VARCHAR(500) default null;
	DECLARE countryName VARCHAR(500) default null;
	DECLARE createdBy VARCHAR(500);
	DECLARE createdDate DATETIME;
	DECLARE forBusinessUse TINYINT(1) DEFAULT 0;
	DECLARE forPersonalUse TINYINT(1) DEFAULT 0;
	DECLARE geoAccuracy INT default 0;
	DECLARE geoLatitude INT default 0;
	DECLARE geoLongitude INT default 0;
	DECLARE isUsedForBilling TINYINT(1) DEFAULT 0;
	DECLARE isUsedForShipping TINYINT(1) DEFAULT 0;
	DECLARE postalCodeText VARCHAR(500) default null;
	DECLARE primaryFlag TINYINT(1) DEFAULT 0;
	DECLARE profileFirstCreatedDate TIME default null;
	DECLARE profileLastUpdatedDate TIME default null;
	DECLARE profileOccurrenceCount INT default 0;
	DECLARE stateProvinceName VARCHAR(500) default null;
	DECLARE updatedBy VARCHAR(500);
	DECLARE updatedDate DATETIME;
	DECLARE addressTxt JSON;
    DECLARE contactPointType JSON default null;
    DECLARE contactPointTypeTxt VARCHAR(500) default null;
    DECLARE contactPointTypeId VARCHAR(36) default null;
	DECLARE contactPointName VARCHAR(500) default null;
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
	    	SET addressTxt = JSON_EXTRACT(queryParams, CONCAT("$[", indx, "]"));
	    	SET id = JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.id'));
	      -- call log_msg(CONCAT("id: ", id));
	 
			IF(JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.activeFromDate')) IS NOT NULL) THEN
			  select CAST(JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.activeFromDate')) as DATETIME) into activeFromDate;
			END IF;
			IF(JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.activeToDate')) IS NOT NULL) THEN
			  select CAST(JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.activeToDate')) as DATETIME) into activeToDate;
			END IF;
			IF(JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.profileFirstCreatedDate')) IS NOT NULL) THEN
			  select CAST(JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.profileFirstCreatedDate')) as DATETIME) into profileFirstCreatedDate;
			END IF;
			IF(JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.profileLastUpdatedDate')) IS NOT NULL) THEN
			select CAST(JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.profileLastUpdatedDate')) as DATETIME) into profileLastUpdatedDate;
			END IF;
			IF(JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.bestTimeToContactEndTime')) IS NOT NULL) THEN
			select CAST(JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.bestTimeToContactEndTime')) as TIME) into bestTimeToContactEndTime;
			END IF;
			IF(JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.bestTimeToContactStartTime')) IS NOT NULL) THEN
			select CAST(JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.bestTimeToContactStartTime')) as TIME) into bestTimeToContactStartTime;
			END IF;

			SET addressLine1 = JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.addressLine1'));
			SET addressLine2 = JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.addressLine2'));
			SET addressLine3 = JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.addressLine3'));
			SET addressLine4 = JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.addressLine4'));
			SET contactPointName = JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.name'));
		 -- call log_msg(CONCAT("addressLine1: ", addressLine1));
			SET geoAccuracy = JSON_EXTRACT(addressTxt,'$.geoAccuracy');
			SET geoLatitude = JSON_EXTRACT(addressTxt,'$.geoLatitude');
			SET geoLongitude = JSON_EXTRACT(addressTxt,'$.geoLongitude');
		 -- call log_msg(CONCAT("geoLongitude: ", geoLongitude));
			SET cityName = JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.cityName'));
			SET countryName = JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.countryName'));
			SET stateProvinceName = JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.stateProvinceName'));
			SET postalCodeText = JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.postalCodeText'));
			SET profileOccurrenceCount = JSON_EXTRACT(addressTxt,'$.profileOccurrenceCount');

			SET forBusinessUse = JSON_EXTRACT(addressTxt,'$.forBusinessUse');
			SET forPersonalUse = JSON_EXTRACT(addressTxt,'$.forPersonalUse');
			SET isUsedForBilling = JSON_EXTRACT(addressTxt,'$.isUsedForBilling');
			SET isUsedForShipping = JSON_EXTRACT(addressTxt,'$.isUsedForShipping');
			SET primaryFlag = JSON_EXTRACT(addressTxt,'$.primaryFlag');
			SET externalIds = JSON_EXTRACT(addressTxt,'$.externalIds');
			SET createdBy =JSON_UNQUOTE( JSON_EXTRACT(addressTxt,'$.createdBy'));
			SET createdDate = NOW() ;
		 -- call log_msg(CONCAT("createdBy: ", createdBy));
			SET updatedBy = JSON_UNQUOTE(JSON_EXTRACT(addressTxt,'$.updatedBy'));
			SET updatedDate = NOW() ;
			
			IF( id IS NULL) THEN
				SET insertFlag = 1;
		   		SET id = UUID();
		   	ELSE 
				SET insertFlag = 0;
			END IF;
			
			-- Get the Contact Point ID that has the primaryFlag set in DB if it already exists.
			SET primaryContactPointId = (select cppj.CONTACT_POINT_ID from CONTACT_POINT_ADDRESS cpa,CONTACT_POINT_ADDRESS_PARTY_JOIN cpapj,CONTACT_POINT_PARTY_JOIN cppj  where cpa.PRIMARY_FLAG =1 and cpa.ID=cppj.CONTACT_POINT_ID and cpapj.CONTACT_POINT_ADDRESS_ID =cppj.CONTACT_POINT_ID and cpapj.PARTY_ID = partyId limit 1);
 		 --  call log_msg(CONCAT("primaryContactPointId: ", primaryContactPointId));
	     --  call log_msg(CONCAT("primaryFlag: ", primaryFlag));
			IF(primaryFlag = 1) THEN
				-- If primary flag is set, check if any of other records previously iterated have the flag as 1 if so do not set the flag else set it as 1 
				-- call log_msg(CONCAT("primaryFlagContactPointId: ", primaryFlagContactPointId));
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
		
			-- Handling of insert if the ContactPoint Address does not exists.
			IF (insertFlag = 1) THEN
	    	    SET externalIdTableId = UUID();
	    		insert into CONTACT_POINT (ACTIVE_FROM_DATE,ACTIVE_TO_DATE,BEST_TIME_TO_CONTACT_END_TIME,BEST_TIME_TO_CONTACT_START_TIME,CREATED_BY,CREATED_DATE,FOR_BUSINESS_USE,FOR_PERSONAL_USE,ID,NAME,PRIMARY_FLAG,PROFILE_FIRST_CREATED_DATE,PROFILE_LAST_UPDATED_DATE,PROFILE_OCCURRENCE_COUNT,UPDATED_BY,UPDATED_DATE) values (activeFromDate,activeToDate,bestTimeToContactEndTime,bestTimeToContactStartTime,createdBy,createdDate,forBusinessUse,forPersonalUse,id,contactPointName,primaryFlag,profileFirstCreatedDate,profileLastUpdatedDate,profileOccurrenceCount,updatedBy,updatedDate);
				insert into CONTACT_POINT_PARTY_JOIN (CONTACT_POINT_ID,PARTY_ID) values (id,partyId);
				insert into CONTACT_POINT_ADDRESS (ACTIVE_FROM_DATE,ACTIVE_TO_DATE,ADDRESS_LINE1,ADDRESS_LINE2,ADDRESS_LINE3,ADDRESS_LINE4,BEST_TIME_TO_CONTACT_END_TIME,BEST_TIME_TO_CONTACT_START_TIME,CITY_NAME,COUNTRY_NAME,CREATED_BY,CREATED_DATE,FOR_BUSINESS_USE,FOR_PERSONAL_USE,GEO_ACCURACY,GEO_LATITUDE,GEO_LONGITUDE,ID,IS_USED_FOR_BILLING,IS_USED_FOR_SHIPPING,NAME,POSTAL_CODE_TEXT,PRIMARY_FLAG,PROFILE_FIRST_CREATED_DATE,PROFILE_LAST_UPDATED_DATE,PROFILE_OCCURRENCE_COUNT,STATE_PROVINCE_NAME,UPDATED_BY,UPDATED_DATE) values (activeFromDate,activeToDate,addressLine1,addressLine2,addressLine3,addressLine4,bestTimeToContactEndTime,bestTimeToContactStartTime,cityName,countryName,createdBy,createdDate,forBusinessUse,forPersonalUse,geoAccuracy,geoLatitude,geoLongitude,id,isUsedForBilling,isUsedForShipping,contactPointName,postalCodeText,primaryFlag,profileFirstCreatedDate,profileLastUpdatedDate,profileOccurrenceCount,stateProvinceName,updatedBy,updatedDate);
				insert into CONTACT_POINT_ADDRESS_PARTY_JOIN (CONTACT_POINT_ADDRESS_ID,PARTY_ID) values (id,partyId);
				
				-- Add the External Id for this Contact Point Id	   
				SET externalIdType = (select ext.ID from EXTERNAL_ID_TYPE ext where ext.NAME='MDM');
				insert into EXTERNAL_ID (ID,EXTERNAL_ID,EXTERNAL_ID_TYPE,STATUS,CREATED_DATE,CREATED_BY,UPDATED_DATE,UPDATED_BY) values (externalIdTableId,id,externalIdType,'VALID',createdDate,createdBy,updatedDate,updatedBy);
				insert into EXTERNAL_ID_CONTACT_POINT_JOIN (CONTACT_POINT_ID,EXTERNAL_ID) values (id,externalIdTableId);
				-- Upsert the External Id for this Contact Point Id	   
		        IF (externalIds IS NOT NULL) THEN
					CALL ContactPoints_ExternalIds_Upsert(externalIds,id);
				END IF;
			
				SET contactPointType = JSON_EXTRACT(addressTxt,'$.contactPointType');
			 	REPEAT
			 		SET contactPointTypeTxt = JSON_UNQUOTE(JSON_EXTRACT(contactPointType, CONCAT("$[", cpTypeindx, "]")));
			 	    Call ContactPointType_Lookup (contactPointTypeTxt,@contactPointTypeId);
			  -- call log_msg(CONCAT("contactPointTypeId: ", @contactPointTypeId));
					insert into CONTACT_POINT_ADDRESS_CONTACT_POINT_TYPE_JOIN (CONTACT_POINT_ADDRESS_ID,CONTACT_POINT_TYPE_ID) values (id, @contactPointTypeId);
					insert into CONTACT_POINT_CONTACT_POINT_TYPE_JOIN (CONTACT_POINT_ID,CONTACT_POINT_TYPE_ID) values (id, @contactPointTypeId);
			 -- call log_msg("Completed Inserts: ");
					SET cpTypeindx = cpTypeindx + 1;
					UNTIL cpTypeindx = JSON_LENGTH(contactPointType)
				END REPEAT;
				SET cpTypeindx = 0;
	    	ELSE 
  				-- Handling of update if the ContactPoint Address already exists.
	    		SET id = id;
	    		Update CONTACT_POINT cp set cp.ACTIVE_FROM_DATE=activeFromDate,cp.ACTIVE_TO_DATE=activeToDate,cp.BEST_TIME_TO_CONTACT_END_TIME=bestTimeToContactEndTime,cp.BEST_TIME_TO_CONTACT_START_TIME=bestTimeToContactStartTime,cp.FOR_BUSINESS_USE=forBusinessUse,cp.FOR_PERSONAL_USE=forPersonalUse,cp.NAME=contactPointName,cp.PRIMARY_FLAG=primaryFlag,cp.PROFILE_FIRST_CREATED_DATE=profileFirstCreatedDate,cp.PROFILE_LAST_UPDATED_DATE=profileLastUpdatedDate,cp.PROFILE_OCCURRENCE_COUNT=profileOccurrenceCount,cp.UPDATED_BY=updatedBy,cp.UPDATED_DATE=updatedDate where cp.ID=id;
				Update CONTACT_POINT_ADDRESS cpa set cpa.ACTIVE_FROM_DATE=activeFromDate,cpa.ACTIVE_TO_DATE=activeToDate,cpa.ADDRESS_LINE1=addressLine1,cpa.ADDRESS_LINE2=addressLine2,cpa.ADDRESS_LINE3=addressLine3,cpa.ADDRESS_LINE4=addressLine4,cpa.BEST_TIME_TO_CONTACT_END_TIME=bestTimeToContactEndTime,cpa.BEST_TIME_TO_CONTACT_START_TIME=bestTimeToContactStartTime,cpa.CITY_NAME=cityName,cpa.COUNTRY_NAME=countryName,cpa.FOR_BUSINESS_USE=forBusinessUse,cpa.FOR_PERSONAL_USE=forPersonalUse,cpa.GEO_ACCURACY=geoAccuracy,cpa.GEO_LATITUDE=geoLatitude,cpa.GEO_LONGITUDE=geoLongitude,cpa.IS_USED_FOR_BILLING=isUsedForBilling,cpa.IS_USED_FOR_SHIPPING=isUsedForShipping,cpa.NAME=contactPointName,cpa.POSTAL_CODE_TEXT=postalCodeText,cpa.PRIMARY_FLAG=primaryFlag,cpa.PROFILE_FIRST_CREATED_DATE=profileFirstCreatedDate,cpa.PROFILE_LAST_UPDATED_DATE=profileLastUpdatedDate,cpa.PROFILE_OCCURRENCE_COUNT=profileOccurrenceCount,cpa.STATE_PROVINCE_NAME=stateProvinceName,cpa.UPDATED_BY=updatedBy,cpa.UPDATED_DATE=updatedDate where cpa.ID=id;
				SET rowsUpdate = (select ROW_COUNT());
	  		-- call log_msg(CONCAT("Updated Row Count for ContactPointAddress: ", rowsUpdate, " Id: ", id));
	  			IF (rowsUpdate = 0) THEN
	  				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid ContactPoint Id to update records';
	  			END IF;
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
			UPDATE  CONTACT_POINT_ADDRESS cpa SET cpa.PRIMARY_FLAG=0 WHERE  cpa.ID = primaryContactPointId;
			-- call log_msg(CONCAT("After update by primaryContactPointId: ", primaryContactPointId));
		END IF;
		-- If there are no records with primaryFlag set the first record in the list to have primaryFlag set as 1. This is overriding the default value set either by Insert/Update queries above
		IF (primaryFlagContactPointId IS NULL) THEN
			UPDATE  CONTACT_POINT cp SET cp.PRIMARY_FLAG=1 WHERE  cp.ID = primaryFlagNoFirstContactPointId;
			UPDATE  CONTACT_POINT_ADDRESS cpa SET cpa.PRIMARY_FLAG=1 WHERE  cpa.ID = primaryFlagNoFirstContactPointId;
			-- call log_msg(CONCAT("After update by primaryFlagNoFirstContactPointId: ", primaryFlagNoFirstContactPointId));
		END IF;
	
	COMMIT WORK;
END;
//