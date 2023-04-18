/**
 * Validate if the response of search queries based on search inputs 
 * and precedence yielded any records. If records of the first search query 
 * returned records, execution of other search queries will be skipped and the 
 * search response will not be cleared until all the queries are search queries 
 * are executed/skipped in order of precedence defined. The variable
 * holds the search results records that are to be returned.
 */
%dw 2.0
output application/java
---
if(sizeOf(payload)>0)
	flatten(vars.outputDBRecords + payload) 
else 
	vars.outputDBRecords