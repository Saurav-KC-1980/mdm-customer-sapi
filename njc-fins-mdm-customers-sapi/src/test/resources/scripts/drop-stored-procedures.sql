/*
 * Drop stored procedures for FINS MDM Customers database 
 */

DROP PROCEDURE IF EXISTS ContactPointAddress_Upsert;
DROP PROCEDURE IF EXISTS ContactPointEmail_Upsert;
DROP PROCEDURE IF EXISTS ContactPointPhone_Upsert;
DROP PROCEDURE IF EXISTS ContactPointType_Lookup;

DROP PROCEDURE IF EXISTS Customers_Create;
DROP PROCEDURE IF EXISTS Individuals_Create;
DROP PROCEDURE IF EXISTS Organizations_Create;
DROP PROCEDURE IF EXISTS Households_Upsert;
DROP PROCEDURE IF EXISTS Parties_ExternalIds_Upsert;
DROP PROCEDURE IF EXISTS Parties_RelatedParties_Upsert;
DROP PROCEDURE IF EXISTS PartyRole_ExternalIds_Upsert;
