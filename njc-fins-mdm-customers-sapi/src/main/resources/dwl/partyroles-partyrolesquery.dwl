/**
 * Dynamically constructs DB queries to retrieve partyroles as per precedence 
 * order and filter results based on search criteria requested. 
 */
%dw 2.0
output application/java
var query = "select DISTINCT pr.ID,pr.PARTY_ROLE_TYPE, p.ID PARTY_ID, p.GLOBAL_PARTY ,p.NO_MERGE_REASON ,p.PARTY_TYPE 
from PARTY_ROLE pr,PARTY p,PARTY_ROLE_PARTY_JOIN prpj where  prpj.PARTY_ID=p.ID and prpj.PARTY_ROLE_ID =pr.ID  "

//filter by partyRoleType
var partyRoleTypeWhereClasue = if(vars.partyRoleType != null) ( " and pr.PARTY_ROLE_TYPE= '" ++ vars.partyRoleType ++ "' " ) else ""
//filter by externalIdType
var externalIdTypeWhereClause =  if (vars.externalIdType != null) (" and pr.ID in (select DISTINCT pr.ID from EXTERNAL_ID_PARTY_ROLE_JOIN eipj,EXTERNAL_ID ei,EXTERNAL_ID_TYPE eit, 
PARTY_ROLE pr where eipj.PARTY_ROLE_ID  = pr.ID and ei.id = eipj.EXTERNAL_ID and  ei.EXTERNAL_ID_TYPE = eit.ID  
and eit.NAME= '" ++ vars.externalIdType ++ "')" ) else ""
// filter by partyId
var partyWhereClause = if(vars.partyId != null) (" and p.ID= '" ++ vars.partyId ++ "' ") else ""

var otherParams = ( 
 (partyWhereClause ++ partyRoleTypeWhereClasue ++ externalIdTypeWhereClause)
 ++ (" limit " ++ vars.limit ++" offset " ++ vars.offset))
---
[
//query for partyRoleId
(query ++ "and prpj.PARTY_ROLE_ID= '" ++ vars.partyRoleId ++ "' " ++ otherParams) if(vars.partyRoleId != null),

//query for externalID
(query ++ "and pr.ID in (select DiSTINCT pr.ID from EXTERNAL_ID_PARTY_ROLE_JOIN eipj,EXTERNAL_ID ei,EXTERNAL_ID_TYPE eit, 
PARTY_ROLE pr where eipj.PARTY_ROLE_ID  = pr.ID and ei.id = eipj.EXTERNAL_ID and  eit.ID = ei.EXTERNAL_ID_TYPE 
and ei.EXTERNAL_ID= '" ++ vars.externalId ++ "')" ++  otherParams) if (vars.externalId != null),

//default query to return all 
(query ++ otherParams) if(vars.partyRoleId == null and vars.externalId == null)
]