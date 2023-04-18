/**
 *  Customer Create Mapping for MDM System 
 */
%dw 2.0
output application/json skipNullOn="everywhere"
---
/**
  * Maps CIM Customer to JSON which is used by stored procedure - sp_Customers_Create
  * @table JSON used by the stored procedure,CIM,Description
  * @row churnScore,churnScore,The churn score of the customer
  * @row customerNumber,customerNumber,The Customer Number to be stored in MDM
  * @row customerSatisfactionScore,customerSatisfactionScore,The customer satisfaction score
  * @row customerStatus,customerStatus,The status of the customer
  * @row id,id,The id of the customer
  * @row last12MonthsNewRevenueAmount,last12MonthsNewRevenueAmount,The last 12 months new revenue amount of the customer
  * @row last12MonthsSupportCallCount,last12MonthsSupportCallCount,The last 12 months support call count made by the customer
  * @row last24MonthsNewRevenueAmount,last24MonthsNewRevenueAmount,The last 24 months new revenue amount of the customer
  * @row marketingEmailResponseRate,marketingEmailResponseRate,Marketing email response rate of the customer
  * @row netPromoterScore,netPromoterScore,The net promoter score of the customer
  * @row originatingCustomerSource,originatingCustomerSource,The originating source of the customer
  * @row prospectRating,prospectRating,The prospect rating of the customer
  * @row totalBookingsAmount,totalBookingsAmount,The total bookings amount made by the customer
  * @row totalContractedAmount,totalContractedAmount,The total contracted amount 
  * @row totalLifeTimeValue,totalLifeTimeValue,The total lifetime value of the customer
  * @row totalProfitContributionAmount,totalProfitContributionAmount,The total profit contribution amount by the customer
  * @row partyId,party[0],The id of the individual as party
  * @row partyRoleType,partyRoleType,"Customer",The type of party role - default as Customer
  * @row createdDate,auditInfo.createdDate,Identifies the system or user which created the entity - default as current timestamp
  * @row createdBy,auditInfo.createdBy,Timestamp of when the entity was created - default as current timestamp
  * @row updatedBy,auditInfo.updatedBy,Identifies the system or user which last updated the entity - default as property app.name 
  * @row updatedDate,auditInfo.updatedDate,Timestamp of when the entity was last updated - default as current timestamp
  */
{
	churnScore: payload.churnScore,
	customerNumber: payload.customerNumber,
	customerSatisfactionScore: payload.customerSatisfactionScore,
	customerStatus: payload.customerStatus,
	id: payload.id,
	last12MonthsNewRevenueAmount: payload.last12MonthsNewRevenueAmount,
	last12MonthsSupportCallCount: payload.last12MonthsSupportCallCount,
	last24MonthsNewRevenueAmount: payload.last24MonthsNewRevenueAmount,
	marketingEmailResponseRate: payload.marketingEmailResponseRate,
	netPromoterScore: payload.netPromoterScore,
	originatingCustomerSource:  payload.originatingCustomerSource,
	prospectRating: payload.prospectRating,
	totalBookingsAmount:  payload.totalBookingsAmount,
	totalContractedAmount: payload.totalContractedAmount,
	totalLifeTimeValue:  payload.totalLifeTimeValue,
	totalProfitContributionAmount: payload.totalProfitContributionAmount,
	partyId: payload.party[0],
	partyRoleType: payload.partyRoleType default "Customer",
	createdDate: payload.auditInfo.createdDate default now(),
	createdBy: payload.auditInfo.createdBy default p('app.name'),
	updatedBy: payload.auditInfo.updatedBy default p('app.name'),
	updatedDate: payload.auditInfo.updatedDate default now()
	
}