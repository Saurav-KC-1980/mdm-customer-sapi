/**
 * Dynamically constructs DB queries to retrieve parties as per precedence 
 * order and filter results based on search criteria requested. 
 */
%dw 2.0
output application/java
var query = "select DISTINCT p.ID, p.GLOBAL_PARTY ,p.NO_MERGE_REASON ,p.PARTY_TYPE from PARTY p "
var partyWhereClause = if (vars.partyType != null) ("  p.PARTY_TYPE= '" ++ vars.partyType ++ "' ") else ""
var externalIdTypeWhereClause = if (vars.externalIdType != null) (" ,EXTERNAL_ID ei ,EXTERNAL_ID_PARTY_JOIN eipj,EXTERNAL_ID_TYPE eit where p.ID=eipj.PARTY_ID and  ei.EXTERNAL_ID_TYPE = eit.ID and eit.NAME= '" ++ vars.externalIdType ++ "' " ) else ""
var externalIdTypeClause = if (vars.externalIdType != null) (" and  ei.EXTERNAL_ID_TYPE = eit.ID and eit.NAME= '" ++ vars.externalIdType ++ "' " ) else ""
var otherParams =  (
	( 
	if ((vars.emailAddress != null) and (vars.partyType != null or vars.externalIdType != null))
		(partyWhereClause)
	else if((vars.externalId != null) and (vars.partyType != null or vars.externalIdType != null))
		(externalIdTypeClause ++ " and " ++ partyWhereClause)
	else if (vars.partyType != null and vars.externalIdType != null) 
		   (externalIdTypeWhereClause ++ " and " ++ partyWhereClause)
	else if (vars.partyType != null)	
		(" where " ++ partyWhereClause) 
	else if (vars.externalIdType != null)
		(externalIdTypeWhereClause)
	else 
		""
	) ++ " limit " ++ vars.limit ++" offset " ++ vars.offset
)
---
[
//query for PartyId	
(query ++ " where  p.ID= '" ++ vars.partyId ++ "' "++ otherParams) if(vars.partyId != null),
 
//query for ExternalId
(query ++ " ,EXTERNAL_ID ei ,EXTERNAL_ID_PARTY_JOIN eipj,EXTERNAL_ID_TYPE eit where ei.EXTERNAL_ID_TYPE = eit.ID  and p.ID=eipj.PARTY_ID and eipj.EXTERNAL_ID=ei.ID and ei.EXTERNAL_ID = '" ++ vars.externalId ++ "' " ++ otherParams) if(vars.externalId != null) ,


//query for EmailAddress when filter externalIdType is present
(query ++ " , CONTACT_POINT_EMAIL cpe ,CONTACT_POINT_EMAIL_PARTY_JOIN cpepj" ++ externalIdTypeWhereClause ++ " and p.ID=cpepj.PARTY_ID and cpe.ID = cpepj.CONTACT_POINT_EMAIL_ID and 
cpe.EMAIL_ADDRESS = '" ++ vars.emailAddress ++ "' " ++ otherParams)  if(vars.emailAddress != null and vars.externalIdType != null),

//query for EmailAddress
(query ++ " , CONTACT_POINT_EMAIL cpe ,CONTACT_POINT_EMAIL_PARTY_JOIN cpepj where p.ID=cpepj.PARTY_ID and cpe.ID = cpepj.CONTACT_POINT_EMAIL_ID and 
cpe.EMAIL_ADDRESS = '" ++ vars.emailAddress ++ "' " ++ otherParams)  if(vars.emailAddress != null),

//default query
(query ++ otherParams) if(vars.partyId == null and vars.externalId == null and vars.emailAddress == null)
]