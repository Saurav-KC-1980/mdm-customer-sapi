/**
 * Dynamically constructs DB queries to retrieve customers as per precedence 
 * order and filter results based on search criteria requested. 
 */
%dw 2.0
output application/java

var query = "select cust.ID, pr.PARTY_ROLE_TYPE,prpj.PARTY_ID, p.PARTY_TYPE,
	(select i.PERSON_NAME from INDIVIDUAL i where i.ID = prpj.PARTY_ID) PERSON_NAME,
	(select org.NAME from ORGANIZATION org where org.ID = prpj.PARTY_ID) ORGANZIATION_NAME,
	(select cpe.ID EMAIL_ID from CONTACT_POINT_EMAIL cpe, CONTACT_POINT_EMAIL_PARTY_JOIN cpepj where cpepj.CONTACT_POINT_EMAIL_ID = cpe.ID and cpepj.PARTY_ID = p.ID and cpe.PRIMARY_FLAG = 1 limit 1) as EMAIL_ID,
	(select cpe.EMAIL_ADDRESS from CONTACT_POINT_EMAIL cpe, CONTACT_POINT_EMAIL_PARTY_JOIN cpepj where cpepj.CONTACT_POINT_EMAIL_ID = cpe.ID and cpepj.PARTY_ID = p.ID and cpe.PRIMARY_FLAG = 1 limit 1) as EMAIL_ADDRESS,
	(select cpe.ACTIVE_FROM_DATE EMAIL_ACTIVE_FROM_DATE from CONTACT_POINT_EMAIL cpe, CONTACT_POINT_EMAIL_PARTY_JOIN cpepj where cpepj.CONTACT_POINT_EMAIL_ID = cpe.ID and cpepj.PARTY_ID = p.ID and cpe.PRIMARY_FLAG = 1 limit 1) as EMAIL_ACTIVE_FROM,
	(select cpp.ID from CONTACT_POINT_PHONE cpp, CONTACT_POINT_PHONE_PARTY_JOIN cpppj where cpppj.CONTACT_POINT_PHONE_ID = cpp.ID and cpppj.PARTY_ID = p.ID and cpp.PRIMARY_FLAG = 1 limit 1) as PHONE_ID,
	(select cpp.TELEPHONE_NUMBER from CONTACT_POINT_PHONE cpp, CONTACT_POINT_PHONE_PARTY_JOIN cpppj where cpppj.CONTACT_POINT_PHONE_ID = cpp.ID and cpppj.PARTY_ID = p.ID and cpp.PRIMARY_FLAG = 1 limit 1) as TELEPHONE_NUMBER,
	(select cpp.ACTIVE_FROM_DATE PHONE_ACTIVE_FROM_DATE from CONTACT_POINT_PHONE cpp, CONTACT_POINT_PHONE_PARTY_JOIN cpppj where cpppj.CONTACT_POINT_PHONE_ID = cpp.ID and cpppj.PARTY_ID = p.ID and cpp.PRIMARY_FLAG = 1 limit 1) as PHONE_ACTIVE_FROM,
	cust.CHURN_SCORE,cust.CREATED_BY,cust.CREATED_DATE, cust.CUSTOMER_NUMBER, cust.CUSTOMER_SATISFACTION_SCORE, cust.CUSTOMER_STATUS,  
    cust.LAST12_MONTHS_SUPPORT_CALL_COUNT, cust.LAST24_MONTHS_NEW_REVENUE_AMOUNT, cust.LAST12_MONTHS_NEW_REVENUE_AMOUNT,  
    cust.MARKETING_EMAIL_RESPONSE_RATE, cust.NET_PROMOTER_SCORE, cust.ORIGINATING_CUSTOMER_SOURCE, cust.PROSPECT_RATING,  
    cust.TOTAL_BOOKINGS_AMOUNT, cust.TOTAL_CONTRACTED_AMOUNT, cust.TOTAL_LIFE_TIME_VALUE, cust.TOTAL_PROFIT_CONTRIBUTION_AMOUNT, 
	cust.UPDATED_BY, cust.UPDATED_DATE
from CUSTOMER cust
JOIN CUSTOMER_PARTY_JOIN cpj ON cpj.CUSTOMER_ID = cust.ID
JOIN PARTY_ROLE_PARTY_JOIN prpj ON  prpj.PARTY_ID = cpj.PARTY_ID and prpj.PARTY_ROLE_ID = cpj.CUSTOMER_ID
JOIN PARTY_ROLE pr ON pr.ID = prpj.PARTY_ROLE_ID
JOIN PARTY p ON p.ID=prpj.PARTY_ID  " 

var otherParams = (" limit " ++ vars.limit ++" offset " ++ vars.offset)
---
[
//query for Customer Id	
(query ++ " and cust.ID = '"
 ++ vars.customerId ++ "' "++ otherParams) if(vars.customerId != null),
 
//query for externalId
(query ++ "
and cust.ID in (select pr.ID from EXTERNAL_ID_PARTY_ROLE_JOIN eipj,EXTERNAL_ID ei,EXTERNAL_ID_TYPE eit, PARTY_ROLE pr 
where eipj.PARTY_ROLE_ID  = pr.ID  and ei.id = eipj.EXTERNAL_ID and eit.ID = ei.EXTERNAL_ID_TYPE  
and ei.EXTERNAL_ID= '" ++ vars.externalId ++ "')" ++ otherParams) if(vars.externalId != null),


//query for email address
("select 
	cust.ID,p.PARTY_TYPE,pr.PARTY_ROLE_TYPE,prpj.PARTY_ID, 
	(select i.PERSON_NAME from INDIVIDUAL i where i.ID = prpj.PARTY_ID) PERSON_NAME,
	(select org.NAME from ORGANIZATION org where org.ID = prpj.PARTY_ID) ORGANZIATION_NAME,
	email.EMAIL_ID,email.EMAIL_ACTIVE_FROM_DATE,email.EMAIL_ADDRESS,
	(select cpp.ID from CONTACT_POINT_PHONE cpp, CONTACT_POINT_PHONE_PARTY_JOIN cpppj where cpppj.CONTACT_POINT_PHONE_ID = cpp.ID and cpppj.PARTY_ID = p.ID and cpp.PRIMARY_FLAG = 1 limit 1) as PHONE_ID,
	(select cpp.TELEPHONE_NUMBER from CONTACT_POINT_PHONE cpp, CONTACT_POINT_PHONE_PARTY_JOIN cpppj where cpppj.CONTACT_POINT_PHONE_ID = cpp.ID and cpppj.PARTY_ID = p.ID and cpp.PRIMARY_FLAG = 1 limit 1) as TELEPHONE_NUMBER,
	(select cpp.ACTIVE_FROM_DATE from CONTACT_POINT_PHONE cpp, CONTACT_POINT_PHONE_PARTY_JOIN cpppj where cpppj.CONTACT_POINT_PHONE_ID = cpp.ID and cpppj.PARTY_ID = p.ID and cpp.PRIMARY_FLAG = 1 limit 1) as PHONE_ACTIVE_FROM,
	cust.CHURN_SCORE,cust.CREATED_BY,cust.CREATED_DATE, cust.CUSTOMER_NUMBER, cust.CUSTOMER_SATISFACTION_SCORE, cust.CUSTOMER_STATUS,  
    cust.LAST12_MONTHS_SUPPORT_CALL_COUNT, cust.LAST24_MONTHS_NEW_REVENUE_AMOUNT, cust.LAST12_MONTHS_NEW_REVENUE_AMOUNT,  
    cust.MARKETING_EMAIL_RESPONSE_RATE, cust.NET_PROMOTER_SCORE, cust.ORIGINATING_CUSTOMER_SOURCE, cust.PROSPECT_RATING,  
    cust.TOTAL_BOOKINGS_AMOUNT, cust.TOTAL_CONTRACTED_AMOUNT, cust.TOTAL_LIFE_TIME_VALUE, cust.TOTAL_PROFIT_CONTRIBUTION_AMOUNT, 
	cust.UPDATED_BY, cust.UPDATED_DATE
from CUSTOMER cust
JOIN CUSTOMER_PARTY_JOIN cpj ON cpj.CUSTOMER_ID = cust.ID
JOIN PARTY_ROLE_PARTY_JOIN prpj ON  prpj.PARTY_ID = cpj.PARTY_ID and prpj.PARTY_ROLE_ID = cpj.CUSTOMER_ID
JOIN PARTY_ROLE pr ON pr.ID = prpj.PARTY_ROLE_ID
JOIN PARTY p ON p.ID=prpj.PARTY_ID  
JOIN (select cpe.ID EMAIL_ID, cpe.ACTIVE_FROM_DATE EMAIL_ACTIVE_FROM_DATE,cpe.EMAIL_ADDRESS,cpepj.PARTY_ID from CONTACT_POINT_EMAIL cpe, CONTACT_POINT_EMAIL_PARTY_JOIN cpepj where cpepj.CONTACT_POINT_EMAIL_ID = cpe.ID and cpe.PRIMARY_FLAG = 1  ) 
	as email ON email.PARTY_ID = p.ID and  email.EMAIL_ADDRESS= '" ++ vars.emailAddress ++ "' " ++ otherParams
)  if(vars.emailAddress != null),



(query ++ otherParams
) if(vars.customerId == null and vars.externalId == null and vars.emailAddress == null) 
]