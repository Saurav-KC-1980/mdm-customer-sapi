/*
 * This Script is used to truncate Data from below tables. It drops the FOREIGN_KEY_CHECKS
 *  and then enables it back, once all the data is cleared.
 */

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE CONTACT_POINT_ADDRESS_CONTACT_POINT_TYPE_JOIN;
TRUNCATE CONTACT_POINT_ADDRESS_PARTY_JOIN;
TRUNCATE CONTACT_POINT_ADDRESS;

TRUNCATE CONTACT_POINT_EMAIL_CONTACT_POINT_TYPE_JOIN;
TRUNCATE CONTACT_POINT_EMAIL_PARTY_JOIN;
TRUNCATE CONTACT_POINT_EMAIL;

TRUNCATE CONTACT_POINT_PHONE_CONTACT_POINT_TYPE_JOIN;
TRUNCATE CONTACT_POINT_PHONE_PARTY_JOIN;
TRUNCATE CONTACT_POINT_PHONE;

TRUNCATE CONTACT_POINT_CONTACT_POINT_TYPE_JOIN;
TRUNCATE CONTACT_POINT_PARTY_JOIN;
TRUNCATE CONTACT_POINT_TYPE;
TRUNCATE CONTACT_POINT;

TRUNCATE EXTERNAL_ID_EXTERNAL_ID_TYPE_JOIN;
TRUNCATE EXTERNAL_ID_PARTY_JOIN;
TRUNCATE EXTERNAL_ID_PARTY_ROLE_JOIN;
TRUNCATE EXTERNAL_ID_TYPE;
TRUNCATE EXTERNAL_ID;

TRUNCATE PARTY_RELATED_PARTY_RELATED_PARTY_JOIN;
TRUNCATE PARTY_RELATED_PARTY_PARTY_JOIN;
TRUNCATE PARTY_RELATED_PARTY;
TRUNCATE PARTY_RELATIONSHIP_TYPE;

TRUNCATE CUSTOMER_PARTY_JOIN;
TRUNCATE PARTY_ROLE_PARTY_JOIN;
TRUNCATE CUSTOMER;
TRUNCATE PARTY_ROLE;
TRUNCATE HOUSEHOLD;
TRUNCATE INDIVIDUAL;
TRUNCATE ORGANIZATION;
TRUNCATE HOUSEHOLD;
TRUNCATE PARTY;

SET FOREIGN_KEY_CHECKS = 1;