-- This Stored Procedure is to insert Organizations Object and its
-- dependency tables. It takes a JSON  Organization object
-- and creates them in MDM DB by generating an UUID.
DELIMITER //
CREATE PROCEDURE Organizations_Create (organizationRequestJSON JSON,OUT organizationId VARCHAR(36))
BEGIN
	DECLARE createdBy VARCHAR(500) default null;
	DECLARE createdDate DATETIME default null;
	DECLARE name VARCHAR(500) default null;
	DECLARE legalName VARCHAR(500) default null;
	DECLARE globalParty VARCHAR(500) default null;
	DECLARE id VARCHAR(36) default null;
	DECLARE noMergeReason VARCHAR(500) default null;
	DECLARE partyType VARCHAR(50) default null;
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

	  SET id = UUID();
	  SET externalIdTableId = UUID();
	  SET name =  JSON_UNQUOTE(JSON_EXTRACT(organizationRequestJSON,'$.name'));
	  SET globalParty =  JSON_UNQUOTE(JSON_EXTRACT(organizationRequestJSON,'$.globalParty'));
	  SET legalName =  JSON_UNQUOTE(JSON_EXTRACT(organizationRequestJSON,'$.legalName'));
	  SET noMergeReason =  JSON_UNQUOTE(JSON_EXTRACT(organizationRequestJSON,'$.noMergeReason'));
	  SET partyType =  JSON_UNQUOTE(JSON_EXTRACT(organizationRequestJSON,'$.partyType'));
	  SET primaryAccount = JSON_UNQUOTE(JSON_EXTRACT(organizationRequestJSON,'$.primaryAccount'));
	
	  SET createdBy = JSON_UNQUOTE(JSON_EXTRACT(organizationRequestJSON,'$.createdBy'));
	  SET createdDate = NOW() ;
	-- call log_msg(CONCAT("createdBy: ", createdBy));
	  SET updatedBy = JSON_UNQUOTE(JSON_EXTRACT(organizationRequestJSON,'$.updatedBy'));
	  SET updatedDate = NOW() ;


	  insert into PARTY (ID,PARTY_TYPE,GLOBAL_PARTY,NO_MERGE_REASON,CREATED_BY,CREATED_DATE,UPDATED_BY,UPDATED_DATE) values (id,partyType,globalParty,noMergeReason,createdBy,createdDate,updatedBy,updatedDate);
	-- call log_msg("after party ");
		insert into ORGANIZATION (NAME,LEGAL_NAME,ID,PARTY_TYPE,GLOBAL_PARTY,NO_MERGE_REASON,CREATED_BY,CREATED_DATE,UPDATED_BY,UPDATED_DATE) values 
		(name,legalName,id,partyType,globalParty,noMergeReason,createdBy,createdDate,updatedBy,updatedDate);

		SET externalIdType = (select ext.ID from EXTERNAL_ID_TYPE ext where ext.NAME='MDM');
	-- Add the External Id for this Organization Id	
		insert into EXTERNAL_ID (ID,EXTERNAL_ID,EXTERNAL_ID_TYPE,STATUS,CREATED_BY,CREATED_DATE,UPDATED_BY,UPDATED_DATE) values (externalIdTableId,id,externalIdType,'VALID',createdBy,createdDate,updatedBy,updatedDate);
		insert into EXTERNAL_ID_PARTY_JOIN (EXTERNAL_ID,PARTY_ID) values (externalIdTableId,id);
	-- call log_msg("after EXTERNAL_ID_PARTY_JOIN ");
		SET organizationId = id;
  COMMIT WORK;
END;
//