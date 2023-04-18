-- This Stored Procedure is to insert Customer Object and its
-- dependency tables. It takes a JSON Array of Customer objects
-- and creates them in MDM DB by generating an UUID.
DELIMITER //
CREATE PROCEDURE Customers_Create (customersRequestJSON JSON,OUT customerId VARCHAR(36))
BEGIN
	DECLARE churnScore INT;
	DECLARE createdBy VARCHAR(500) default null;
	DECLARE createdDate DATETIME;
	DECLARE customerNumber VARCHAR(500) default null;
	DECLARE customerSatisfactionScore INT;
	DECLARE customerStatus VARCHAR(500) default null;
	DECLARE globalParty VARCHAR(500) default null;
	DECLARE id VARCHAR(36) default null;
	DECLARE last12MonthsNewRevenueAmount INT;
	DECLARE last12MonthsSupportCallCount INT;
	DECLARE last24MonthsNewRevenueAmount INT;
	DECLARE marketingEmailResponseRate INT;
	DECLARE netPromoterScore INT;
	DECLARE noMergeReason VARCHAR(500) default null;
	DECLARE originatingCustomerSource VARCHAR(500) default null;
	DECLARE party JSON;
	DECLARE partyId VARCHAR(36) default null;
--	DECLARE partyRole JSON;
--	DECLARE partyRoleId VARCHAR(36) default null;
	DECLARE partyRoleType VARCHAR(500) default null;
--	DECLARE partyType VARCHAR(500) default null;
	DECLARE prospectRating VARCHAR(500) default null;
	DECLARE totalBookingsAmount INT;
	DECLARE totalContractedAmount INT;
	DECLARE totalLifeTimeValue INT;
	DECLARE totalProfitContributionAmount INT;
	DECLARE updatedBy VARCHAR(500) default null;
	DECLARE updatedDate DATETIME;
	
--	DECLARE externalIDObj JSON;
	DECLARE externalIdTableId VARCHAR(36);
--	DECLARE externalId VARCHAR(500) default null;
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
	--	SET partyRoleId = id;
		SET partyId = JSON_UNQUOTE(JSON_EXTRACT(customersRequestJSON,'$.partyId'));
    -- call log_msg(CONCAT("partyId: ", partyId));
    -- call log_msg(CONCAT("id: ", id));
		SET churnScore = JSON_EXTRACT(customersRequestJSON,'$.churnScore');
		SET customerNumber = JSON_UNQUOTE(JSON_EXTRACT(customersRequestJSON,'$.customerNumber'));
		SET customerSatisfactionScore = JSON_EXTRACT(customersRequestJSON,'$.customerSatisfactionScore');
		SET customerStatus = JSON_UNQUOTE(JSON_EXTRACT(customersRequestJSON,'$.customerStatus'));
		SET globalParty = JSON_UNQUOTE(JSON_EXTRACT(customersRequestJSON,'$.globalParty'));
		SET last12MonthsNewRevenueAmount = JSON_EXTRACT(customersRequestJSON,'$.last12MonthsNewRevenueAmount');
		SET last12MonthsSupportCallCount = JSON_EXTRACT(customersRequestJSON,'$.last12MonthsSupportCallCount');
		SET last24MonthsNewRevenueAmount = JSON_EXTRACT(customersRequestJSON,'$.last24MonthsNewRevenueAmount');
		SET marketingEmailResponseRate = JSON_EXTRACT(customersRequestJSON,'$.marketingEmailResponseRate');
		SET netPromoterScore = JSON_EXTRACT(customersRequestJSON,'$.netPromoterScore');
		SET noMergeReason = JSON_UNQUOTE(JSON_EXTRACT(customersRequestJSON,'$.noMergeReason'));
		SET originatingCustomerSource = JSON_UNQUOTE(JSON_EXTRACT(customersRequestJSON,'$.originatingCustomerSource'));
		SET partyRoleType = JSON_UNQUOTE(JSON_EXTRACT(customersRequestJSON,'$.partyRoleType'));
	--	SET partyType = JSON_UNQUOTE(JSON_EXTRACT(customersRequestJSON,'$.partyType'));
		SET prospectRating = JSON_UNQUOTE(JSON_EXTRACT(customersRequestJSON,'$.prospectRating'));
		SET totalBookingsAmount = JSON_EXTRACT(customersRequestJSON,'$.totalBookingsAmount');
		SET totalContractedAmount = JSON_EXTRACT(customersRequestJSON,'$.totalContractedAmount');
		SET totalLifeTimeValue = JSON_EXTRACT(customersRequestJSON,'$.totalLifeTimeValue');
		SET totalProfitContributionAmount = JSON_EXTRACT(customersRequestJSON,'$.totalProfitContributionAmount');
		
	--  SET externalId = JSON_UNQUOTE(JSON_EXTRACT(customersRequestJSON,'$.externalId'));
	--  SET externalIdType = JSON_UNQUOTE(JSON_EXTRACT(customersRequestJSON,'$.externalIdType'));
	--  SET externalIdStatus = JSON_UNQUOTE(JSON_EXTRACT(customersRequestJSON,'$.externalIdStatus'));
		
		SET createdBy = JSON_UNQUOTE(JSON_EXTRACT(customersRequestJSON,'$.createdBy'));
		SET createdDate = NOW() ;
	-- call log_msg(CONCAT("createdBy: ", createdBy));
		SET updatedBy = JSON_UNQUOTE(JSON_EXTRACT(customersRequestJSON,'$.updatedBy'));
		SET updatedDate = NOW() ;
		

		-- insert into PARTY (ID,PARTY_TYPE,GLOBAL_PARTY,NO_MERGE_REASON,CREATED_BY,CREATED_DATE,UPDATED_BY,UPDATED_DATE) values (id,partyType,globalParty,noMergeReason,createdBy,createdDate,updatedBy,updatedDate);
	-- call log_msg("after party ");	
		insert into CUSTOMER (CHURN_SCORE,CREATED_BY,CREATED_DATE,CUSTOMER_NUMBER,CUSTOMER_SATISFACTION_SCORE,CUSTOMER_STATUS,ID,LAST12_MONTHS_SUPPORT_CALL_COUNT,LAST24_MONTHS_NEW_REVENUE_AMOUNT,LAST12_MONTHS_NEW_REVENUE_AMOUNT,MARKETING_EMAIL_RESPONSE_RATE,NET_PROMOTER_SCORE,ORIGINATING_CUSTOMER_SOURCE,PARTY_ROLE_TYPE,PROSPECT_RATING,TOTAL_BOOKINGS_AMOUNT,TOTAL_CONTRACTED_AMOUNT,TOTAL_LIFE_TIME_VALUE,TOTAL_PROFIT_CONTRIBUTION_AMOUNT,UPDATED_BY,UPDATED_DATE) values ( 
		churnScore,createdBy,createdDate,customerNumber,customerSatisfactionScore,customerStatus,id,last12MonthsNewRevenueAmount,last12MonthsSupportCallCount,last24MonthsNewRevenueAmount,marketingEmailResponseRate,netPromoterScore,originatingCustomerSource,partyRoleType,prospectRating,totalBookingsAmount,totalContractedAmount,totalLifeTimeValue,totalProfitContributionAmount,updatedBy,updatedDate);
	-- call log_msg("after customer ");
		insert into PARTY_ROLE (ID,PARTY_ROLE_TYPE,CREATED_BY,CREATED_DATE,UPDATED_BY,UPDATED_DATE) values (id,partyRoleType,createdBy,createdDate,updatedBy,updatedDate);
	-- call log_msg("after partyRole ");
		insert into CUSTOMER_PARTY_JOIN (CUSTOMER_ID,PARTY_ID) values (id,partyId);
		insert into PARTY_ROLE_PARTY_JOIN (PARTY_ROLE_ID,PARTY_ID) values (id,partyId);
	-- set customerid as default external id in MDM	
		SET externalIdType = (select ext.ID from EXTERNAL_ID_TYPE ext where ext.NAME='MDM');
		insert into EXTERNAL_ID (ID,EXTERNAL_ID,EXTERNAL_ID_TYPE,STATUS,CREATED_BY,CREATED_DATE,UPDATED_BY,UPDATED_DATE) values (externalIdTableId,id,externalIdType,'VALID',createdBy,createdDate,updatedBy,updatedDate);
		insert into EXTERNAL_ID_PARTY_ROLE_JOIN (EXTERNAL_ID,PARTY_ROLE_ID) values (externalIdTableId,id);
	-- call log_msg("after EXTERNAL_ID_PARTY_ROLE_JOIN ");
	set customerId = id;	
  COMMIT WORK;
END;
//