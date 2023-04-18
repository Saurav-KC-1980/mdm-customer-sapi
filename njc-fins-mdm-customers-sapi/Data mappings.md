This document provides information generated from the DataWeave scripts included in the project, such as function definitions, variable definitions, and data mapping tables.

| Module | Description |
| :---- | :---- |
| [contactpointsaddress-storedprocedure-request](#contactpointsaddress-storedprocedure-request) | ContactPointAddress Create/Update Mapping for MDM System | 
| [contactpointsemail-storedprocedure-request](#contactpointsemail-storedprocedure-request) | ContactPointEmail Create/Update Mapping for MDM System | 
| [contactpointsphone-storedprocedure-request](#contactpointsphone-storedprocedure-request) | ContactPointPhone Create/Update Mapping for MDM System | 
| [contactpoints-get-response](#contactpoints-get-response) | ContactPoint Retrieve Mapping for MDM System | 
| [get-contactpoints-externalids-response](#get-contactpoints-externalids-response) | ExternalIds Query Mapping for MDM System | 
| [customers-post-payload](#customers-post-payload) | Customer Create Mapping for MDM System | 
| [customers-patch-payload](#customers-patch-payload) | Customer Update Mapping for MDM System. Checks are done to see if the value * exists in DB, and only updated is the incoming request has a not null value. * Some of the fields cannot be updated and they are ignored. | 
| [customers-get-response](#customers-get-response) | Customer Retrieve Mapping for MDM System | 
| [customers-search-response](#customers-search-response) | Customer Search Mapping for MDM System | 
| [post-externalids-payload](#post-externalids-payload) | ExternalIds Upsert Mapping for MDM System | 
| [get-externalids-response](#get-externalids-response) | ExternalIds Query Mapping for MDM System | 
| [partyroles-get-response](#partyroles-get-response) | PartyRoles Retrieve Mapping for MDM System | 
| [get-related-parties-response](#get-related-parties-response) | RelatedParties Retrieve Mapping for MDM System | 
| [put-related-parties-payload](#put-related-parties-payload) | RelatedParties Upsert Mapping for MDM System | 
| [parties-get-response](#parties-get-response) | Parties Query Mapping for MDM System | 
| [parties-related-parties-externalids](#parties-related-parties-externalids) | ExternalIds Query Mapping for MDM System | 
| [individuals-post-payload](#individuals-post-payload) | Create Individual Mapping for MDM System. Maps CIM Individual to JSON which * is used by stored procedure sp_Individuals_Create. * The fields in both CIM and JSON are identical. | 
| [individuals-patch-payload](#individuals-patch-payload) | Update Individual Mapping for MDM System. Maps CIM Indiviudal to payload * which is used as input parameter in the update query of INDIVIDUAL table. * The fields in both CIM and MDM are identical. * PATCH payload is created by validating the Input Request payload with DB Record Payload. * Few of the DB fields will not be updated as they are not allowed. | 
| [individuals-get-response](#individuals-get-response) | Search and Retrieve of Individual Mappings for MDM System | 
| [organizations-post-payload](#organizations-post-payload) | Create organization Mapping for MDM System. * Maps CIM organization to JSON which is used by stored procedure sp_Organizations_Create. * The fields in both CIM and JSON are identical. | 
| [organizations-patch-payload](#organizations-patch-payload) | Create Organization Mapping for MDM System * Maps CIM Organization to payload which is used as input parameter in the update query of ORGANIZATION table. * The fields in both CIM and MDM are identical. * PATCH payload is created by validating the Input Request payload with DB Record Payload. | 
| [organizations-get-response](#organizations-get-response) | Retrieve Organization Mapping for MDM System | 
| [households-post-payload](#households-post-payload) | Create Household Mapping for MDM System. Maps CIM Household to payload which * is used as input parameter to insert into Household table. The fields in both * CIM and MDM are identical. | 
| [households-patch-payload](#households-patch-payload) | Mapping for MDM System to Update Household. Maps CIM Household to payload * which is used as input parameter in the update Household table. The fields in * both CIM and MDM are identical. PATCH payload is created by validating the * Input Request payload with DB Record Payload. | 
| [households-get-response](#households-get-response) | Retrieve and Search Household Mapping for MDM System | 

# contactpointsaddress-storedprocedure-request

ContactPointAddress Create/Update Mapping for MDM System
> Source: `./src/main/resources/dwl/contactpointsaddress-storedprocedure-request.dwl`

([back to top](#))

# contactpointsemail-storedprocedure-request

ContactPointEmail Create/Update Mapping for MDM System
> Source: `./src/main/resources/dwl/contactpointsemail-storedprocedure-request.dwl`

([back to top](#))

# contactpointsphone-storedprocedure-request

ContactPointPhone Create/Update Mapping for MDM System
> Source: `./src/main/resources/dwl/contactpointsphone-storedprocedure-request.dwl`

([back to top](#))

# contactpoints-get-response

ContactPoint Retrieve Mapping for MDM System
> Source: `./src/main/resources/dwl/contactpoints-get-response.dwl`

([back to top](#))

# get-contactpoints-externalids-response

ExternalIds Query Mapping for MDM System
> Source: `./src/main/resources/dwl/get-contactpoints-externalids-response.dwl`

## Variables

__var__ `outputPayload`  

outputPayload variable is the maps the result of select query on MDM EXTERNAL_ID table.
 * @table Var,MDM, Description
 * @row id, id,The id of the entry in MDM system
 * @row externalId, externalId,A unique identifier assigned to the customer in another system
 * @row externalIdType, externalIdType,Identifies the system that owns or otherwise recognises this unique identifier
 * @row status, status,Indicates whether this identifier is currently valid or not
 * @row statusLastChangedDate, statusLastChangedDate,Date and time of the last change in status

([back to top](#))

# customers-post-payload

Customer Create Mapping for MDM System
> Source: `./src/main/resources/dwl/customers-post-payload.dwl`

([back to top](#))

# customers-patch-payload

Customer Update Mapping for MDM System.  Checks are done to see if the value 
 * exists in DB, and only updated is the incoming request has a not null value.
 * Some of the fields cannot be updated and they are ignored.
> Source: `./src/main/resources/dwl/customers-patch-payload.dwl`

## Variables

__var__ `payloadRecordfromDB`  

payloadRecordfromDB is the existing customer record in MDM system

([back to top](#))

# customers-get-response

Customer Retrieve Mapping for MDM System
> Source: `./src/main/resources/dwl/customers-get-response.dwl`

([back to top](#))

# customers-search-response

Customer Search Mapping for MDM System
> Source: `./src/main/resources/dwl/customers-search-response.dwl`

([back to top](#))

# post-externalids-payload

ExternalIds Upsert Mapping for MDM System
> Source: `./src/main/resources/dwl/post-externalids-payload.dwl`

([back to top](#))

# get-externalids-response

ExternalIds Query Mapping for MDM System
> Source: `./src/main/resources/dwl/get-externalids-response.dwl`

## Variables

__var__ `outputPayload`  

outputPayload variable is the maps the result of select query on MDM EXTERNAL_ID table.
 * @table Var,MDM, Description
 * @row id, id,The id of the entry in MDM system
 * @row externalId, externalId,A unique identifier assigned to the customer in another system
 * @row externalIdType, externalIdType,Identifies the system that owns or otherwise recognises this unique identifier
 * @row status, status,Indicates whether this identifier is currently valid or not
 * @row statusLastChangedDate, statusLastChangedDate,Date and time of the last change in status

([back to top](#))

# partyroles-get-response

PartyRoles Retrieve Mapping for MDM System
> Source: `./src/main/resources/dwl/partyroles-get-response.dwl`

([back to top](#))

# get-related-parties-response

RelatedParties Retrieve Mapping for MDM System
> Source: `./src/main/resources/dwl/get-related-parties-response.dwl`

## Functions

__fun__ `formatDate (dateformats)`

Maps MDM DB to CIM Json which is used by other process API's * @table CIM,MDM DB,Description * @row id, ID,The id of the entry in MDM system * @row relatedFromDate, RELATED_FROM_DATE,Related From Date with the Party * @row relatedToDate, RELATED_TO_DATE,Related To Date with the Party * @row relatedParty, PARTY_RELATED_PARTY_ID,Indicates the Party that its related to * @row partyRelationshipType, PARTY_RELATION_TYPE.NAME, Pre-defined relation ship between parties


([back to top](#))

# put-related-parties-payload

RelatedParties Upsert Mapping for MDM System
> Source: `./src/main/resources/dwl/put-related-parties-payload.dwl`

([back to top](#))

# parties-get-response

Parties Query Mapping for MDM System
> Source: `./src/main/resources/dwl/parties-get-response.dwl`

([back to top](#))

# parties-related-parties-externalids

ExternalIds Query Mapping for MDM System
> Source: `./src/main/resources/dwl/parties-related-parties-externalids.dwl`

([back to top](#))

# individuals-post-payload

Create Individual Mapping for MDM System. Maps CIM Individual to JSON which 
 * is used by stored procedure sp_Individuals_Create.
 * The fields in both CIM and JSON are identical.
> Source: `./src/main/resources/dwl/individuals-post-payload.dwl`

([back to top](#))

# individuals-patch-payload

Update Individual Mapping for MDM System.  Maps CIM Indiviudal to payload 
 * which is used as input parameter in the update query of INDIVIDUAL table.
 * The fields in both CIM and MDM are identical.
 * PATCH payload is created by validating the Input Request payload with DB Record Payload.
 * Few of the DB fields will not be updated as they are not allowed.
> Source: `./src/main/resources/dwl/individuals-patch-payload.dwl`

## Variables

__var__ `payloadRecordfromDB`  

payloadRecordfromDB is the existing customer record in MDM system

([back to top](#))

# individuals-get-response

Search and Retrieve of Individual Mappings for MDM System
> Source: `./src/main/resources/dwl/individuals-get-response.dwl`

([back to top](#))

# organizations-post-payload

Create organization Mapping for MDM System.
 * Maps CIM organization to JSON which is used by stored procedure sp_Organizations_Create.
 * The fields in both CIM and JSON are identical.
> Source: `./src/main/resources/dwl/organizations-post-payload.dwl`

([back to top](#))

# organizations-patch-payload

Create Organization Mapping for MDM System 
 * Maps CIM Organization to payload which is used as input parameter in the update query of ORGANIZATION table.
 * The fields in both CIM and MDM are identical.
 * PATCH payload is created by validating the Input Request payload with DB Record Payload.
> Source: `./src/main/resources/dwl/organizations-patch-payload.dwl`

## Variables

__var__ `payloadRecordfromDB`  

payloadRecordfromDB is the existing customer record in MDM system

([back to top](#))

# organizations-get-response

Retrieve Organization Mapping for MDM System
> Source: `./src/main/resources/dwl/organizations-get-response.dwl`

([back to top](#))

# households-post-payload

Create Household Mapping for MDM System. Maps CIM Household to payload which 
 * is used as input parameter to insert into Household table. The fields in both 
 * CIM and MDM are identical.
> Source: `./src/main/resources/dwl/households-post-payload.dwl`

([back to top](#))

# households-patch-payload

Mapping for MDM System to Update Household. Maps CIM Household to payload 
 * which is used as input parameter in the update Household table. The fields in
 * both CIM and MDM are identical. PATCH payload is created by validating the 
 * Input Request payload with DB Record Payload.
> Source: `./src/main/resources/dwl/households-patch-payload.dwl`

## Variables

__var__ `payloadRecordfromDB`  

payloadRecordfromDB is the existing customer record in MDM system

([back to top](#))

# households-get-response

Retrieve and Search Household Mapping for MDM System
> Source: `./src/main/resources/dwl/households-get-response.dwl`

([back to top](#))

