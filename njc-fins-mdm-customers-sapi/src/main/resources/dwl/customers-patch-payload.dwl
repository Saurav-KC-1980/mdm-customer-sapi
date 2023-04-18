/**
 * Customer Update Mapping for MDM System.  Checks are done to see if the value 
 * exists in DB, and only updated is the incoming request has a not null value.
 * Some of the fields cannot be updated and they are ignored.
 */
%dw 2.0
output application/java
/**
 * payloadRecordfromDB is the existing customer record in MDM system
 */
var payloadRecordfromDB =  vars.customerDBRecord
---
/**
 * Maps CIM Customer to MDM Customer JSON used to update MDM
 * PATCH payload is created by validating the Input Request payload with DB Record Payload.
 * @table MDM,CIM,Description
 * @row id,vars.customerId,The id of the customer in MDM
 * @row churnScore,if(CHURN_SCORE?) CHURN_SCORE else payloadRecordfromDB.churnScore,The churn score of the customer
 * @row createdBy,p('app.name'),Identifies the system or user which created the entity - default as property app.name
 * @row createdDate,now(),Timestamp of when the entity was created - default as current timestamp
 * @row customerNumber,if(CUSTOMER_NUMBER?) CUSTOMER_NUMBER else payloadRecordfromDB.customerNumber,The Customer Number to be stored in MDM
 * @row customerSatisfactionScore,if(CUSTOMER_SATISFACTION_SCORE?) CUSTOMER_SATISFACTION_SCORE else payloadRecordfromDB.customerSatisfactionScore,The customer satisfaction score
 * @row customerStatus,if(CUSTOMER_STATUS?) CUSTOMER_STATUS else payloadRecordfromDB.customerStatus,The status of the customer
 * @row last12MonthsNewRevenueAmount,if(LAST12_MONTHS_NEW_REVENUE_AMOUNT?) LAST12_MONTHS_NEW_REVENUE_AMOUNT else payloadRecordfromDB.last12MonthsNewRevenueAmount,The last 12 months new revenue amount of the customer
 * @row last12MonthsSupportCallCount, if(LAST12_MONTHS_SUPPORT_CALL_COUNT?) LAST12_MONTHS_SUPPORT_CALL_COUNT else payloadRecordfromDB.last12MonthsSupportCallCount,The last 12 months support call count made by the customer
 * @row last24MonthsNewRevenueAmount: if(LAST24_MONTHS_NEW_REVENUE_AMOUNT?) LAST24_MONTHS_NEW_REVENUE_AMOUNT else payloadRecordfromDB.last24MonthsNewRevenueAmount,The last 24 months new revenue amount of the customer
 * @row marketingEmailResponseRate,if(MARKETING_EMAIL_RESPONSE_RATE?) MARKETING_EMAIL_RESPONSE_RATE else payloadRecordfromDB.marketingEmailResponseRate,Marketing email response rate of the customer
 * @row netPromoterScore,if(NET_PROMOTER_SCORE?) NET_PROMOTER_SCORE else payloadRecordfromDB.netPromoterScore,The net promoter score of the customer
 * @row originatingCustomerSource,if(ORIGINATING_CUSTOMER_SOURCE?) ORIGINATING_CUSTOMER_SOURCE else payloadRecordfromDB.originatingCustomerSource,The originating source of the customer
 * @row prospectRating,if(PROSPECT_RATING?) PROSPECT_RATING else payloadRecordfromDB.prospectRating,The prospect rating of the customer
 * @row totalBookingsAmount,if(TOTAL_BOOKINGS_AMOUNT?) TOTAL_BOOKINGS_AMOUNT else payloadRecordfromDB.totalBookingsAmount,The total bookings amount made by the customer
 * @row totalContractedAmount,if(TOTAL_CONTRACTED_AMOUNT?) TOTAL_CONTRACTED_AMOUNT else payloadRecordfromDB.totalContractedAmount,The total contracted amount 
 * @row totalLifeTimeValue,if(TOTAL_LIFE_TIME_VALUE?) TOTAL_LIFE_TIME_VALUE else payloadRecordfromDB.totalLifeTimeValue,The total lifetime value of the customer
 * @row totalProfitContributionAmount,if(TOTAL_PROFIT_CONTRIBUTION_AMOUNT?) TOTAL_PROFIT_CONTRIBUTION_AMOUNT else payloadRecordfromDB.totalProfitContributionAmount,The total profit contribution amount by the customer
 * @row updatedBy,p('app.name'),Identifies the system or user which last updated the entity - default as property app.name
 * @row updatedDate,now(),Timestamp of when the entity was last updated - default as current timestamp
 * @row partyId,if(party?) party[0] else payloadRecordfromDB.party[0],The id of the individual as party
 * @row partyRoleType,if(PARTY_ROLE_TYPE?) PARTY_ROLE_TYPE else payloadRecordfromDB.partyRoleTypeThe type of party role - default as Customer
 * 
 */
{
	id:  vars.customerId,
	churnScore: if(payload.churnScore?) payload.churnScore else payloadRecordfromDB.churnScore,
	createdBy: p('app.name'),
	createdDate: now(),
	customerNumber: if(payload.customerNumber?) payload.customerNumber else payloadRecordfromDB.customerNumber,
	customerSatisfactionScore: if(payload.customerSatisfactionScore?) payload.customerSatisfactionScore else payloadRecordfromDB.customerSatisfactionScore,
	customerStatus: if(payload.customerStatus?) payload.customerStatus else payloadRecordfromDB.customerStatus,
	last12MonthsNewRevenueAmount: if(payload.last12MonthsNewRevenueAmount?) payload.last12MonthsNewRevenueAmount else payloadRecordfromDB.last12MonthsNewRevenueAmount,
	last12MonthsSupportCallCount:  if(payload.last12MonthsSupportCallCount?) payload.last12MonthsSupportCallCount else payloadRecordfromDB.last12MonthsSupportCallCount, 
	last24MonthsNewRevenueAmount: if(payload.last24MonthsNewRevenueAmount?) payload.last24MonthsNewRevenueAmount else payloadRecordfromDB.last24MonthsNewRevenueAmount,
	marketingEmailResponseRate: if(payload.marketingEmailResponseRate?) payload.marketingEmailResponseRate else payloadRecordfromDB.marketingEmailResponseRate,
	netPromoterScore: if(payload.netPromoterScore?) payload.netPromoterScore else payloadRecordfromDB.netPromoterScore,
	originatingCustomerSource: if(payload.originatingCustomerSource?) payload.originatingCustomerSource else payloadRecordfromDB.originatingCustomerSource,
	prospectRating: if(payload.prospectRating?) payload.prospectRating else payloadRecordfromDB.prospectRating,
	totalBookingsAmount: if(payload.totalBookingsAmount?) payload.totalBookingsAmount else payloadRecordfromDB.totalBookingsAmount,
	totalContractedAmount: if(payload.totalContractedAmount?) payload.totalContractedAmount else payloadRecordfromDB.totalContractedAmount,
	totalLifeTimeValue: if(payload.totalLifeTimeValue?) payload.totalLifeTimeValue else payloadRecordfromDB.totalLifeTimeValue,
	totalProfitContributionAmount:  if(payload.totalProfitContributionAmount?) payload.totalProfitContributionAmount else payloadRecordfromDB.totalProfitContributionAmount,
	updatedBy: p('app.name'),
	updatedDate: now(),
	partyId: if(payload.party?) payload.party[0] else payloadRecordfromDB.party[0],
	partyRoleType: if(payload.partyRoleType?) payload.partyRoleType else payloadRecordfromDB.partyRoleType

}


