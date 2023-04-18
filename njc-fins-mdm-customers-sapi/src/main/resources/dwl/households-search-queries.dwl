/**
 * Dynamically constructs DB queries to retrieve households as per precedence 
 * order and filter results based on search criteria requested. 
 */
%dw 2.0
output application/java

var query = "Select DISTINCT hh.ID,hh.PARTY_TYPE,hh.GLOBAL_PARTY,hh.NO_MERGE_REASON, hh.CREATED_BY,hh.CREATED_DATE,
hh.NAME,hh.HOUSEHOLD_MEMBER_COUNT, hh.HOUSEHOLD_FORMED_DATE,hh.HOUSEHOLD_DISSOLVED_DATE,hh.UPDATED_BY,hh.UPDATED_DATE " 

var otherParams = (" limit " ++ vars.limit ++" offset " ++ vars.offset)
---
[

//query for householdId	
("Select * from HOUSEHOLD hh where hh.ID = '" ++ vars.householdId ++ "' "++ otherParams) if(vars.householdId != null),
 
//query for externalId
(
query ++ " from HOUSEHOLD hh,PARTY p where hh.ID=p.ID and p.ID in 
(select DISTINCT eipj.PARTY_ID from EXTERNAL_ID_PARTY_JOIN eipj,EXTERNAL_ID ei,EXTERNAL_ID_TYPE eit 
where  ei.id = eipj.EXTERNAL_ID and  eit.ID = ei.EXTERNAL_ID_TYPE and 
ei.EXTERNAL_ID= '" ++ vars.externalId ++ "')" ++ otherParams) if(vars.externalId != null),
	
//default query
("Select * from HOUSEHOLD " ++ otherParams) if(vars.householdId == null and vars.externalId == null)
]