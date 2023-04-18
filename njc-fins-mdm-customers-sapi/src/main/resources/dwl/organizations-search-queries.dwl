/**
 * Dynamically constructs DB queries to retrieve organizations as per precedence 
 * order and filter results based on search criteria requested. 
 */
%dw 2.0
output application/java

var query = "select DISTINCT org.NAME,org.LEGAL_NAME,org.PARTY_TYPE,org.GLOBAL_PARTY,org.NO_MERGE_REASON,
org.ID,org.CREATED_DATE,org.CREATED_BY,org.UPDATED_DATE,org.UPDATED_BY,p.ID PARTY_ID " 

var otherParams = (" limit " ++ vars.limit ++" offset " ++ vars.offset)
---
[

//query for Individual Id	
("Select * from ORGANIZATION where ID = '" ++ vars.organizationId ++ "' "++ otherParams) if(vars.organizationId != null),
 
//query for ExternalId
(
query ++ " from ORGANIZATION org,PARTY p where org.ID=p.ID and p.ID in 
(select DISTINCT eipj.PARTY_ID from EXTERNAL_ID_PARTY_JOIN eipj,EXTERNAL_ID ei,EXTERNAL_ID_TYPE eit 
where  ei.id = eipj.EXTERNAL_ID and  eit.ID = ei.EXTERNAL_ID_TYPE and 
ei.EXTERNAL_ID= '" ++ vars.externalId ++ "')" ++ otherParams) if(vars.externalId != null),
	
//query for EmailAddress
(
query ++ "from ORGANIZATION org,PARTY p,CONTACT_POINT_EMAIL cpe, CONTACT_POINT_EMAIL_PARTY_JOIN cpepj 
where org.ID = p.ID and cpepj.PARTY_ID = p.ID and cpe.ID = cpepj.CONTACT_POINT_EMAIL_ID 
and cpe.EMAIL_ADDRESS= '" ++ vars.emailAddress ++ "' " ++ otherParams
)  if(vars.emailAddress != null),

//default query
("Select * from ORGANIZATION " ++ otherParams) if(vars.organizationId == null and vars.externalId == null and vars.emailAddress == null)
]