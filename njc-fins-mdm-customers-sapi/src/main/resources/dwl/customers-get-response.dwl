/**
 *  Customer Retrieve Mapping for MDM System 
 */
%dw 2.0
output application/json skipNullOn="everywhere"
fun formatDate(dateformats) = if (dateformats !=null) (dateformats as String {format: "uuuu-MM-dd"})  else null
---
/**
 * Maps MDM Customer to CIM Customer format
 * @table CIM,MDM,Description
 * @row id,ID,The id of the customer in MDM system
 * @row churnScore,CHURN_SCORE,The churn score of the customer
 * @row customerNumber,CUSTOMER_NUMBER,The Customer Number in MDM
 * @row customerSatisfactionScore,CUSTOMER_SATISFACTION_SCORE,The customer satisfaction score
 * @row customerStatus,CUSTOMER_STATUS,The status of the customer in MDM system
 * @row last12MonthsNewRevenueAmount,LAST12_MONTHS_NEW_REVENUE_AMOUNT,The last 12 months new revenue amount of the customer
 * @row last12MonthsSupportCallCount,LAST12_MONTHS_SUPPORT_CALL_COUNT,The last 12 months support call count made by the customer
 * @row last24MonthsNewRevenueAmount,LAST24_MONTHS_NEW_REVENUE_AMOUNT,The last 24 months new revenue amount of the customer
 * @row marketingEmailResponseRate,MARKETING_EMAIL_RESPONSE_RATE,Marketing email response rate of the customer
 * @row netPromoterScore,NET_PROMOTER_SCORE,The net promoter score of the customer
 * @row originatingCustomerSource,ORIGINATING_CUSTOMER_SOURCE,The originating source of the customer
 * @row party,[ if(vars.individualRecord != null) (vars.individualRecord) else PARTY_ID ],The id of the individual as party
 * @row partyRoleType,PARTY_ROLE_TYPE,The type of party role - default as Customer
 * @row prospectRating,PROSPECT_RATING,The prospect rating of the customer
 * @row totalBookingsAmount,TOTAL_BOOKINGS_AMOUNT,The total bookings amount made by the customer
 * @row totalContractedAmount,TOTAL_CONTRACTED_AMOUNT,The total contracted amount 
 * @row totalLifeTimeValue,TOTAL_LIFE_TIME_VALUE,The total lifetime value of the customer
 * @row totalProfitContributionAmount,TOTAL_PROFIT_CONTRIBUTION_AMOUNT,The total profit contribution amount by the customer
 * @row externalIds, vars.customerExternalIds,The externalIds of the customer that are stored in MDM
 * @row auditInfo.createdBy,CREATED_BY,Identifies the system or user which created the customer
 * @row auditInfo.createdDate,CREATED_DATETimestamp of when the customer was created - default as current timestamp
 * @row auditInfo.updatedBy,UPDATED_BY,Identifies the system or user which last updated the customer
 * @row auditInfo.updatedDate,UPDATED_DATE,Timestamp of when the entity was last updated
 * @row auditInfo.isDeleted,isDeleted,Indicates whether or not the customer has been soft-deleted - default as false
 */
payload map (item, index) -> {
		id: item.ID,
		churnScore: item.CHURN_SCORE,
		customerNumber: item.CUSTOMER_NUMBER,
		customerSatisfactionScore: item.CUSTOMER_SATISFACTION_SCORE,
		customerStatus: item.CUSTOMER_STATUS,
		last12MonthsNewRevenueAmount: item.LAST12_MONTHS_NEW_REVENUE_AMOUNT,
		last12MonthsSupportCallCount: item.LAST12_MONTHS_SUPPORT_CALL_COUNT,
		last24MonthsNewRevenueAmount: item.LAST24_MONTHS_NEW_REVENUE_AMOUNT,
		marketingEmailResponseRate: item.MARKETING_EMAIL_RESPONSE_RATE,
		netPromoterScore: item.NET_PROMOTER_SCORE,
		originatingCustomerSource: item.ORIGINATING_CUSTOMER_SOURCE,
		party: [ if(vars.partyRecord != null) (vars.partyRecord) else item.PARTY_ID ],
		partyRoleType: item.PARTY_ROLE_TYPE,
		prospectRating: item.PROSPECT_RATING,
		totalBookingsAmount: item.TOTAL_BOOKINGS_AMOUNT,
		totalContractedAmount: item.TOTAL_CONTRACTED_AMOUNT,
		totalLifeTimeValue: item.TOTAL_LIFE_TIME_VALUE,
		totalProfitContributionAmount: item.TOTAL_PROFIT_CONTRIBUTION_AMOUNT,
		(externalIds: vars.customerExternalIds) if (vars.customerExternalIds !=null and !(isEmpty(vars.customerExternalIds))),
		auditInfo: {
			createdBy: item.CREATED_BY,
			createdDate: item.CREATED_DATE  as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
			updatedBy: item.UPDATED_BY,
			updatedDate: item.UPDATED_DATE  as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
			isDeleted: item.isDeleted default false
		}
	
}
