/**
 *  Customer Search Mapping for MDM System 
 */
%dw 2.0
output application/json skipNullOn="everywhere"
fun formatDate(dateformats) = if (dateformats !=null) (dateformats as String {format: "uuuu-MM-dd"})  else null
---
/**
 * Maps MDM Customer to CIM Customer format
 * @table CIM,MDM,Description
 * @row id, ID,The id of the customer in MDM system
 * @row churnScore, CHURN_SCORE,The churn score of the customer
 * @row customerNumber, CUSTOMER_NUMBER,The Customer Number in MDM
 * @row customerSatisfactionScore, CUSTOMER_SATISFACTION_SCORE,The customer satisfaction score
 * @row customerStatus, CUSTOMER_STATUS,The status of the customer in MDM system
 * @row last12MonthsNewRevenueAmount, LAST12_MONTHS_NEW_REVENUE_AMOUNT,The last 12 months new revenue amount of the customer
 * @row last12MonthsSupportCallCount, LAST12_MONTHS_SUPPORT_CALL_COUNT,The last 12 months support call count made by the customer
 * @row last24MonthsNewRevenueAmount, LAST24_MONTHS_NEW_REVENUE_AMOUNT,The last 24 months new revenue amount of the customer
 * @row marketingEmailResponseRate, MARKETING_EMAIL_RESPONSE_RATE,Marketing email response rate of the customer
 * @row netPromoterScore, NET_PROMOTER_SCORE,The net promoter score of the customer
 * @row originatingCustomerSource, ORIGINATING_CUSTOMER_SOURCE,The originating source of the customer
 * @row party[0], , ,The individual information as party
 * @row id,if(vars.individualRecord != null) (vars.individualRecord) else PARTY_ID,The id of the individual
 * @row partyType ,PARTY_TYPE,The party type
 * @row personName ,PERSON_NAME,The person name of the individual
 * @row contactPoints [0],
 * @row contactPointType,['ContactPointEmail'],The contactpoint type Email
 * @row id,EMAIL_ID,The id of the contactpoint stored in MDM
 * @row activeFromDate,EMAIL_ACTIVE_FROM_DATE,The date from which the email address is active
 * @row emailAddress,EMAIL_ADDRESSThe emailaddress of the individual stored in MDM
 * @row contactPoints [1],
 * @row contactPointType,['ContactPointPhone'],The contactpoint type Phone
 * @row id,PHONE_ID,The id of the contactpoint stored in MDM
 * @row activeFromDate,PHONE_ACTIVE_FROM_DATE,The date from which the Phone is active
 * @row formattedNationalPhoneNumber,FORMATTED_NATIONAL_PHONE_NUMBER,The formatted national phone number of the individual stored in MDM
 * @row telephoneNumber,TELEPHONE_NUMBERThe telephone number of the individual stored in MDM
 * @row partyRoleType, PARTY_ROLE_TYPE,The type of party role - default as Customer
 * @row prospectRating, PROSPECT_RATING,The prospect rating of the customer
 * @row totalBookingsAmount, TOTAL_BOOKINGS_AMOUNT,The total bookings amount made by the customer
 * @row totalContractedAmount, TOTAL_CONTRACTED_AMOUNT,The total contracted amount 
 * @row totalLifeTimeValue, TOTAL_LIFE_TIME_VALUE,The total lifetime value of the customer
 * @row totalProfitContributionAmount, TOTAL_PROFIT_CONTRIBUTION_AMOUNT,The total profit contribution amount by the customer
 * @row (externalIds ,vars.customerExternalIds) if (vars.customerExternalIds !=null and !(isEmpty(vars.customerExternalIds))),The external Ids of the customer that are stored in MDM
 * @row auditInfo.createdBy,CREATED_BY,Identifies the system or user which created the entity
 * @row auditInfo.createdDate,CREATED_DATE ,Timestamp of when the entity was created 
 * @row auditInfo.updatedBy,UPDATED_BY,Identifies the system or user which last updated the entity
 * @row auditInfo.updatedDate,UPDATED_DATE,Timestamp of when the entity was last updated
 * @row auditInfo.isDeleted,isDeleted default false,Indicates whether or not the entity has been soft-deleted - default as false
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
		party:  [ 
			{
				id: item.PARTY_ID,
				partyType : item.PARTY_TYPE,
				(personName : item.PERSON_NAME) if (item.PARTY_TYPE == "Individual"),
				(name: item.ORGANZIATION_NAME) if (item.PARTY_TYPE=="Organization"),
				contactPoints: [
					({
						 contactPointType: ['ContactPointEmail'],
		        		 id: item.EMAIL_ID,
		        		 activeFromDate: item.EMAIL_ACTIVE_FROM_DATE default (now() as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"}),
		        		 emailAddress: item.EMAIL_ADDRESS
					}) if(item.EMAIL_ADDRESS != null),
					({
						 contactPointType: ['ContactPointPhone'],
		        		 id: item.PHONE_ID,
		        		 activeFromDate: item.PHONE_ACTIVE_FROM_DATE default (now() as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"}),
		        		 formattedNationalPhoneNumber: item.FORMATTED_NATIONAL_PHONE_NUMBER,
		        		 telephoneNumber: item.TELEPHONE_NUMBER
					}) if(item.TELEPHONE_NUMBER != null)
				]
			}
		],
		partyRoleType: item.PARTY_ROLE_TYPE,
		prospectRating: item.PROSPECT_RATING,
		totalBookingsAmount: item.TOTAL_BOOKINGS_AMOUNT,
		totalContractedAmount: item.TOTAL_CONTRACTED_AMOUNT,
		totalLifeTimeValue: item.TOTAL_LIFE_TIME_VALUE,
		totalProfitContributionAmount: item.TOTAL_PROFIT_CONTRIBUTION_AMOUNT,
		(externalIds : vars.customerExternalIds) if (vars.customerExternalIds !=null and !(isEmpty(vars.customerExternalIds))),
		auditInfo: {
			createdBy: item.CREATED_BY,
			createdDate: item.CREATED_DATE  as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
			updatedBy: item.UPDATED_BY,
			updatedDate: item.UPDATED_DATE  as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
			isDeleted: item.isDeleted default false
		}
	
}
