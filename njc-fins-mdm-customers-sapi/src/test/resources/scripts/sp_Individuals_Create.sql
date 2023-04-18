-- This Stored Procedure is to insert Individuals Object and its
-- dependency tables. It takes a JSON Array of Individuals objects
-- and creates them in MDM DB by generating an UUID.
DELIMITER //
CREATE PROCEDURE Individuals_Create (individualRequestJSON JSON,OUT individualId VARCHAR(36))
BEGIN
	DECLARE birthDate DATE default null;
	DECLARE birthPlace VARCHAR(500) default null;
	DECLARE childrenCount INT ;
	DECLARE consumerCreditScore INT ;
	DECLARE consumerCreditScoreProviderName VARCHAR(500) default null;
	DECLARE convictionsCount INT ;
	DECLARE createdBy VARCHAR(500) default null;
	DECLARE createdDate DATETIME default null;
	DECLARE currentEmployerName VARCHAR(50) default null;
	DECLARE deathDate DATE default null;
	DECLARE deathPlace VARCHAR(500) default null;
	DECLARE dependentCount INT ;
	DECLARE doExtractMyDataUpdateDate DATE default null;
	DECLARE doForgetMeFromUpdateDate DATE default null;
	DECLARE doNotMarketFromUpdateDate DATE default null;
	DECLARE doNotProcessFromUpdateDate DATE default null;
	DECLARE doNotProcessReason VARCHAR(500) default null;
	DECLARE doNotProfileFromUpdateDate DATE default null;
	DECLARE doNotTrackLocationUpdateDate DATE default null;
	DECLARE doNotTrackUpdateDate DATE default null;
	DECLARE employedSinceDate DATE default null;
	DECLARE ethnicity VARCHAR(500) default null;
	DECLARE firstName VARCHAR(500) default null;
	DECLARE gender VARCHAR(50) default null;
	DECLARE globalParty VARCHAR(500) default null;
	DECLARE hasAlcoholAbuseHistory TINYINT ;
	DECLARE hasDrugAbuseHistory TINYINT ;
	DECLARE highestEducationLevel VARCHAR(500) default null;
	DECLARE hospitalizationsLast5YearsCount INT ;
	DECLARE id VARCHAR(36) default null;
	DECLARE influencerRating INT ;
	DECLARE isAlcoholConsumer TINYINT ;
	DECLARE isDrugConsumer TINYINT ;
	DECLARE isGoodDriver TINYINT ;
	DECLARE isGoodStudent TINYINT ;
	DECLARE isHighRiskHobby TINYINT ;
	DECLARE isHighRiskOccupation TINYINT ;
	DECLARE isHomeOwner TINYINT ;
	DECLARE isTobaccoConsume TINYINT ;
	DECLARE lastName VARCHAR(500) default null;
	DECLARE mailingName VARCHAR(500) default null;
	DECLARE mainDietaryHabitType VARCHAR(50) default null;
	DECLARE mainDisabilityType VARCHAR(50) default null;
	DECLARE mainLifeAttitudeType VARCHAR(50) default null;
	DECLARE mainLifeStyleType VARCHAR(50) default null;
	DECLARE mainPersonalityType VARCHAR(50) default null;
	DECLARE mainPersonalValueType VARCHAR(50) default null;
	DECLARE majorCitationCount INT ;
	DECLARE maritalStatus VARCHAR(50) default null;
	DECLARE middleName VARCHAR(500) default null;
	DECLARE militaryService VARCHAR(50) default null;
	DECLARE militaryStatus VARCHAR(50) default null;
	DECLARE minorCitationCount INT ;
	DECLARE mothersMaidenName VARCHAR(500) default null;
	DECLARE nameSuffix VARCHAR(50) default null;
	DECLARE netWorth INT ;
	DECLARE noMergeReason VARCHAR(500) default null;
	DECLARE occupation VARCHAR(500) default null;
	DECLARE occupationType VARCHAR(50) default null;
	DECLARE officialName VARCHAR(500) default null;
	DECLARE orderingName VARCHAR(500) default null;
	DECLARE overAgeNumber INT ;
	DECLARE partyType VARCHAR(50) default null;
	DECLARE personHeight INT ;
	DECLARE personHeightUnitOfMeasure VARCHAR(50) default null;
	DECLARE personLifeStage VARCHAR(50) default null;
	DECLARE personName VARCHAR(500) default null;
	DECLARE personWeight INT ;
	DECLARE personWeightUnitOfMeasure VARCHAR(50) default null;
	DECLARE photoURL VARCHAR(500) default null;
	DECLARE preferredName VARCHAR(500) default null;
	DECLARE primaryHobby VARCHAR(50) default null;
	DECLARE religion VARCHAR(50) default null;
	DECLARE residenceCaptureMethod VARCHAR(50) default null;
	DECLARE residenceCountryName VARCHAR(500) default null;
	DECLARE salutation VARCHAR(50) default null;
	DECLARE secondLastName VARCHAR(500) default null;
	DECLARE sendIndividualData TINYINT ;
	DECLARE shouldForget TINYINT ;
	DECLARE surgeriesLast5YearsCount INT ;
	DECLARE taxBracketRange VARCHAR(500) default null;
	DECLARE updatedBy VARCHAR(500) default null;
	DECLARE updatedDate DATETIME default null;
	DECLARE webSiteURL VARCHAR(500) default null;
	DECLARE weddingAnniversaryDate DATE default null;
	DECLARE yearlyIncome INT ;
	DECLARE yearlyIncomeRange VARCHAR(50) default null;
	DECLARE externalIdTableId VARCHAR(36) ;
--  DECLARE externalId VARCHAR(500) default null;
--  DECLARE externalIdStatus VARCHAR(500) default null;
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

	  SET id = UUID();
	  SET externalIdTableId = UUID();
	  SET birthPlace = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.birthPlace'));
	  SET childrenCount = JSON_EXTRACT(individualRequestJSON,'$.childrenCount');
	  SET consumerCreditScore = JSON_EXTRACT(individualRequestJSON,'$.consumerCreditScore');
	  SET consumerCreditScoreProviderName =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.consumerCreditScoreProviderName'));
	  SET convictionsCount = JSON_EXTRACT(individualRequestJSON,'$.convictionsCount');
	  SET currentEmployerName = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.currentEmployerName'));
	-- call log_msg(CONCAT("currentEmployerName: ", currentEmployerName));
	  SET deathPlace =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.deathPlace'));
	  SET dependentCount = JSON_EXTRACT(individualRequestJSON,'$.dependentCount');
	  SET doNotProcessReason = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.doNotProcessReason'));
	  SET doNotProfileFromUpdateDate = JSON_EXTRACT(individualRequestJSON,'$.doNotProfileFromUpdateDate');
	  SET ethnicity =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.ethnicity'));
	  SET firstName =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.firstName'));
	  SET gender = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.gender'));
	  SET globalParty =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.globalParty'));
	  SET hasAlcoholAbuseHistory = JSON_EXTRACT(individualRequestJSON,'$.hasAlcoholAbuseHistory');
	  SET hasDrugAbuseHistory = JSON_EXTRACT(individualRequestJSON,'$.hasDrugAbuseHistory');
	  SET highestEducationLevel =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.highestEducationLevel'));
	  SET hospitalizationsLast5YearsCount = JSON_EXTRACT(individualRequestJSON,'$.hospitalizationsLast5YearsCount');
	  SET influencerRating = JSON_EXTRACT(individualRequestJSON,'$.influencerRating');
	  SET isAlcoholConsumer = JSON_EXTRACT(individualRequestJSON,'$.isAlcoholConsumer');
	  SET isDrugConsumer = JSON_EXTRACT(individualRequestJSON,'$.isDrugConsumer');
	  SET isGoodDriver = JSON_EXTRACT(individualRequestJSON,'$.isGoodDriver');
	  SET isGoodStudent = JSON_EXTRACT(individualRequestJSON,'$.isGoodStudent');
	  SET isHighRiskHobby = JSON_EXTRACT(individualRequestJSON,'$.isHighRiskHobby');
	  SET isHighRiskOccupation = JSON_EXTRACT(individualRequestJSON,'$.isHighRiskOccupation');
	  SET isHomeOwner = JSON_EXTRACT(individualRequestJSON,'$.isHomeOwner');
	  SET isTobaccoConsume = JSON_EXTRACT(individualRequestJSON,'$.isTobaccoConsume');
	  SET lastName =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.lastName'));
	  SET mailingName =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.mailingName'));
	  SET mainDietaryHabitType = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.mainDietaryHabitType'));
	  SET mainDisabilityType =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.mainDisabilityType'));
	  SET mainLifeAttitudeType =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.mainLifeAttitudeType'));
	  SET mainLifeStyleType =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.mainLifeStyleType'));
	  SET mainPersonalityType =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.mainPersonalityType'));
	  SET mainPersonalValueType =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.mainPersonalValueType'));
	  SET majorCitationCount =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.majorCitationCount'));
	  SET maritalStatus =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.maritalStatus'));
	  SET middleName =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.middleName'));
	  SET militaryService =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.militaryService'));
	  SET militaryStatus =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.militaryStatus'));
	  SET minorCitationCount =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.minorCitationCount'));
	  SET mothersMaidenName =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.mothersMaidenName'));
	  SET nameSuffix =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.nameSuffix'));
	  SET netWorth = JSON_EXTRACT(individualRequestJSON,'$.netWorth');
	  SET noMergeReason =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.noMergeReason'));
	  SET occupation =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.occupation'));
	  SET occupationType =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.occupationType'));
	-- call log_msg(CONCAT("occupationType: ", occupationType));
	  SET officialName =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.officialName'));
	  SET orderingName =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.orderingName'));
	  SET overAgeNumber = JSON_EXTRACT(individualRequestJSON,'$.overAgeNumber');
	  SET partyType =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.partyType'));
	  SET personHeight = JSON_EXTRACT(individualRequestJSON,'$.personHeight');
	  SET personHeightUnitOfMeasure =  JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.personHeightUnitOfMeasure'));
	  SET personLifeStage = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.personLifeStage'));
	  SET personName = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.personName'));
	  SET personWeight = JSON_EXTRACT(individualRequestJSON,'$.personWeight');
	  SET personWeightUnitOfMeasure = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.personWeightUnitOfMeasure'));
	  SET photoURL = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.photoURL'));
	-- call log_msg(CONCAT("photoURL: ", photoURL));
	  SET preferredName = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.preferredName'));
	  SET primaryHobby = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.primaryHobby'));
	  SET religion = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.religion'));
	  SET residenceCaptureMethod = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.residenceCaptureMethod'));
	  SET residenceCountryName = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.residenceCountryName'));
	  SET salutation = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.salutation'));
	  SET secondLastName = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.secondLastName'));
	  SET sendIndividualData = JSON_EXTRACT(individualRequestJSON,'$.sendIndividualData');
	  SET shouldForget = JSON_EXTRACT(individualRequestJSON,'$.shouldForget');
	  SET surgeriesLast5YearsCount = JSON_EXTRACT(individualRequestJSON,'$.surgeriesLast5YearsCount');
	  SET taxBracketRange = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.taxBracketRange'));
	-- call log_msg(CONCAT("taxBracketRange: ", taxBracketRange));

	  SET webSiteURL = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.webSiteURL'));
	  SET yearlyIncome = JSON_EXTRACT(individualRequestJSON,'$.yearlyIncome');
	  SET yearlyIncomeRange = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.yearlyIncomeRange'));
	 
	-- call log_msg(CONCAT("yearlyIncomeRange: ", yearlyIncomeRange));

	--  SET externalId = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.externalId'));
	--  SET externalIdType = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.externalIdType'));
	--  SET externalIdStatus = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.externalIdStatus'));


		IF(JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.birthDate')) IS NOT NULL) THEN
		    select CAST(JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.birthDate')) as DATE) into birthDate;
		END IF;
	-- call log_msg(CONCAT("birthDate: ", birthDate));

		IF(JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.deathDate')) IS NOT NULL) THEN
		    select CAST(JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.deathDate')) as DATE) into deathDate;
		END IF;
	-- call log_msg(CONCAT("deathDate: ", deathDate));
		IF(JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.doExtractMyDataUpdateDate')) IS NOT NULL) THEN
		    select CAST(JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.doExtractMyDataUpdateDate')) as DATE) into doExtractMyDataUpdateDate;
		END IF;
	-- call log_msg(CONCAT("doExtractMyDataUpdateDate: ", doExtractMyDataUpdateDate));

		IF(JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.doForgetMeFromUpdateDate')) IS NOT NULL) THEN
		  select CAST(JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.doForgetMeFromUpdateDate')) as DATE) into doForgetMeFromUpdateDate;
		END IF;
	-- call log_msg(CONCAT("doForgetMeFromUpdateDate: ", doForgetMeFromUpdateDate));

		IF(JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.doNotMarketFromUpdateDate')) IS NOT NULL) THEN
		  select CAST(JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.doNotMarketFromUpdateDate')) as DATE) into doNotMarketFromUpdateDate;
		END IF;
	-- call log_msg(CONCAT("doNotMarketFromUpdateDate: ", doNotMarketFromUpdateDate));

		IF(JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.doNotProcessFromUpdateDate')) IS NOT NULL) THEN
		  select CAST(JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.doNotProcessFromUpdateDate')) as DATE) into doNotProcessFromUpdateDate;
		END IF;
	-- call log_msg(CONCAT("doNotProcessFromUpdateDate: ", doNotProcessFromUpdateDate));

		IF(JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.doNotProfileFromUpdateDate')) IS NOT NULL) THEN
		    select CAST(JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.doNotProfileFromUpdateDate')) as DATE) into doNotProfileFromUpdateDate;
		END IF;
	-- call log_msg(CONCAT("doNotProfileFromUpdateDate: ", doNotProfileFromUpdateDate));

		IF(JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.doNotTrackLocationUpdateDate')) IS NOT NULL) THEN
		    select CAST(JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.doNotTrackLocationUpdateDate')) as DATE) into doNotTrackLocationUpdateDate;
		END IF;
	 -- call log_msg(CONCAT("doNotTrackLocationUpdateDate: ", doNotTrackLocationUpdateDate));

		IF(JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.doNotTrackUpdateDate')) IS NOT NULL) THEN
		    select CAST(JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.doNotTrackUpdateDate')) as DATE) into doNotTrackUpdateDate;
		END IF;
	 -- call log_msg(CONCAT("doNotTrackUpdateDate: ", doNotTrackUpdateDate));

		IF(JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.employedSinceDate')) IS NOT NULL) THEN
		  select CAST(JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.employedSinceDate')) as DATE) into employedSinceDate;
		END IF;
	-- call log_msg(CONCAT("employedSinceDate: ", employedSinceDate));

		IF(JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.weddingAnniversaryDate')) IS NOT NULL) THEN
		  select CAST(JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.weddingAnniversaryDate')) as DATE) into weddingAnniversaryDate;
		END IF;
	-- call log_msg(CONCAT("weddingAnniversaryDate: ", weddingAnniversaryDate));

		SET createdBy = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.createdBy'));
		SET createdDate = NOW() ;
	-- call log_msg(CONCAT("createdBy: ", createdBy));
		SET updatedBy = JSON_UNQUOTE(JSON_EXTRACT(individualRequestJSON,'$.updatedBy'));
		SET updatedDate = NOW() ;


		insert into PARTY (ID,PARTY_TYPE,GLOBAL_PARTY,NO_MERGE_REASON,CREATED_BY,CREATED_DATE,UPDATED_BY,UPDATED_DATE) values (id,partyType,globalParty,noMergeReason,createdBy,createdDate,updatedBy,updatedDate);
	-- call log_msg("after party ");
		insert into INDIVIDUAL (BIRTH_DATE,BIRTH_PLACE,CHILDREN_COUNT,CONSUMER_CREDIT_SCORE,CONSUMER_CREDIT_SCORE_PROVIDER_NAME,CONVICTIONS_COUNT,CREATED_BY,CREATED_DATE,CURRENT_EMPLOYER_NAME,DEATH_DATE,DEATH_PLACE,DEPENDENT_COUNT,DO_EXTRACT_MY_DATA_UPDATE_DATE,DO_FORGET_ME_FROM_UPDATE_DATE,DO_NOT_MARKET_FROM_UPDATE_DATE,DO_NOT_PROCESS_FROM_UPDATE_DATE,DO_NOT_PROCESS_REASON,DO_NOT_PROFILE_FROM_UPDATE_DATE,DO_NOT_TRACK_LOCATION_UPDATE_DATE,DO_NOT_TRACK_UPDATE_DATE,EMPLOYED_SINCE_DATE,ETHNICITY,FIRST_NAME,GENDER,GLOBAL_PARTY,HAS_ALCOHOL_ABUSE_HISTORY,HAS_DRUG_ABUSE_HISTORY,HIGHEST_EDUCATION_LEVEL,HOSPITALIZATIONS_LAST5_YEARS_COUNT,ID,INFLUENCER_RATING,IS_ALCOHOL_CONSUMER,IS_DRUG_CONSUMER,IS_GOOD_DRIVER,IS_GOOD_STUDENT,IS_HIGH_RISK_HOBBY,IS_HIGH_RISK_OCCUPATION,IS_HOME_OWNER,IS_TOBACCO_CONSUME,LAST_NAME,MAILING_NAME,MAIN_DIETARY_HABIT_TYPE,MAIN_DISABILITY_TYPE,MAIN_LIFE_ATTITUDE_TYPE,MAIN_LIFE_STYLE_TYPE,MAIN_PERSONAL_VALUE_TYPE,MAIN_PERSONALITY_TYPE,MAJOR_CITATION_COUNT,MARITAL_STATUS,MIDDLE_NAME,MILITARY_SERVICE,MILITARY_STATUS,MINOR_CITATION_COUNT,MOTHERS_MAIDEN_NAME,NAME_SUFFIX,NET_WORTH,NO_MERGE_REASON,OCCUPATION,OCCUPATION_TYPE,OFFICIAL_NAME,ORDERING_NAME,OVER_AGE_NUMBER,PARTY_TYPE,PERSON_HEIGHT,PERSON_HEIGHT_UNIT_OF_MEASURE,PERSON_LIFE_STAGE,PERSON_NAME,PERSON_WEIGHT,PERSON_WEIGHT_UNIT_OF_MEASURE,PHOTO_URL,PREFERRED_NAME,PRIMARY_HOBBY,RELIGION,RESIDENCE_CAPTURE_METHOD,RESIDENCE_COUNTRY_NAME,SALUTATION,SECOND_LAST_NAME,SEND_INDIVIDUAL_DATA,SHOULD_FORGET,SURGERIES_LAST5_YEARS_COUNT,TAX_BRACKET_RANGE,UPDATED_BY,UPDATED_DATE,WEB_SITE_URL,WEDDING_ANNIVERSARY_DATE,YEARLY_INCOME,YEARLY_INCOME_RANGE) values (
		birthDate,birthPlace,childrenCount,consumerCreditScore,consumerCreditScoreProviderName,convictionsCount,createdBy,createdDate,currentEmployerName,deathDate,deathPlace,dependentCount,doExtractMyDataUpdateDate,doForgetMeFromUpdateDate,doNotMarketFromUpdateDate,doNotProcessFromUpdateDate,doNotProcessReason,doNotProfileFromUpdateDate,doNotTrackLocationUpdateDate,doNotTrackUpdateDate,employedSinceDate,ethnicity,firstName,gender,globalParty,hasAlcoholAbuseHistory,hasDrugAbuseHistory,highestEducationLevel,hospitalizationsLast5YearsCount,id,influencerRating,isAlcoholConsumer,isDrugConsumer,isGoodDriver,isGoodStudent,isHighRiskHobby,isHighRiskOccupation,isHomeOwner,isTobaccoConsume,lastName,mailingName,mainDietaryHabitType,mainDisabilityType,mainLifeAttitudeType,mainLifeStyleType,mainPersonalityType,mainPersonalValueType,majorCitationCount,maritalStatus,middleName,militaryService,militaryStatus,minorCitationCount,mothersMaidenName,nameSuffix,netWorth,noMergeReason,occupation,occupationType,officialName,orderingName,overAgeNumber,partyType,personHeight,personHeightUnitOfMeasure,personLifeStage,personName,personWeight,personWeightUnitOfMeasure,photoURL,preferredName,primaryHobby,religion,residenceCaptureMethod,residenceCountryName,salutation,secondLastName,sendIndividualData,shouldForget,surgeriesLast5YearsCount,taxBracketRange,updatedBy,updatedDate,webSiteURL,weddingAnniversaryDate,yearlyIncome,yearlyIncomeRange);
	-- call log_msg("after individual ");
		SET externalIdType = (select ext.ID from EXTERNAL_ID_TYPE ext where ext.NAME='MDM');
	-- Add the External Id for this Indiviual Id	
		insert into EXTERNAL_ID (ID,EXTERNAL_ID,EXTERNAL_ID_TYPE,STATUS,CREATED_BY,CREATED_DATE,UPDATED_BY,UPDATED_DATE) values (externalIdTableId,id,externalIdType,'VALID',createdBy,createdDate,updatedBy,updatedDate);
		insert into EXTERNAL_ID_PARTY_JOIN (EXTERNAL_ID,PARTY_ID) values (externalIdTableId,id);
	-- call log_msg("after EXTERNAL_ID_PARTY_JOIN ");
		SET individualId = id;
  COMMIT WORK;
END;
//