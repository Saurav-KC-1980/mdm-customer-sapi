/**
 * Dynamically constructs DB queries to retrieve individuals as per precedence 
 * order and filter results based on search criteria requested. 
 */
%dw 2.0
output application/java

var query = "select DISTINCT indv.BIRTH_DATE,indv.BIRTH_PLACE,indv.CHILDREN_COUNT,indv.CONSUMER_CREDIT_SCORE,
indv.CONSUMER_CREDIT_SCORE_PROVIDER_NAME,indv.CONVICTIONS_COUNT,indv.CREATED_BY,indv.CREATED_DATE,
indv.CURRENT_EMPLOYER_NAME,indv.DEATH_DATE,indv.DEATH_PLACE,indv.DEPENDENT_COUNT,indv.DO_EXTRACT_MY_DATA_UPDATE_DATE,
indv.DO_FORGET_ME_FROM_UPDATE_DATE,indv.DO_NOT_MARKET_FROM_UPDATE_DATE,indv.DO_NOT_PROCESS_FROM_UPDATE_DATE,indv.DO_NOT_PROCESS_REASON,
indv.DO_NOT_PROFILE_FROM_UPDATE_DATE,indv.DO_NOT_TRACK_LOCATION_UPDATE_DATE,indv.DO_NOT_TRACK_UPDATE_DATE,indv.EMPLOYED_SINCE_DATE,
indv.ETHNICITY,indv.FIRST_NAME,indv.GENDER,indv.GLOBAL_PARTY,indv.HAS_ALCOHOL_ABUSE_HISTORY,indv.HAS_DRUG_ABUSE_HISTORY,
indv.HIGHEST_EDUCATION_LEVEL,indv.HOSPITALIZATIONS_LAST5_YEARS_COUNT,indv.ID,indv.INFLUENCER_RATING,indv.IS_ALCOHOL_CONSUMER,
indv.IS_DRUG_CONSUMER,indv.IS_GOOD_DRIVER,indv.IS_GOOD_STUDENT,indv.IS_HIGH_RISK_HOBBY,indv.IS_HIGH_RISK_OCCUPATION,
indv.IS_HOME_OWNER,indv.IS_TOBACCO_CONSUME,indv.LAST_NAME,indv.MAILING_NAME,indv.MAIN_DIETARY_HABIT_TYPE,
indv.MAIN_DISABILITY_TYPE,indv.MAIN_LIFE_ATTITUDE_TYPE,indv.MAIN_LIFE_STYLE_TYPE,indv.MAIN_PERSONAL_VALUE_TYPE,
indv.MAIN_PERSONALITY_TYPE,indv.MAJOR_CITATION_COUNT,indv.MARITAL_STATUS,indv.MIDDLE_NAME,indv.MILITARY_SERVICE,
indv.MILITARY_STATUS,indv.MINOR_CITATION_COUNT,indv.MOTHERS_MAIDEN_NAME,indv.NAME_SUFFIX,indv.NET_WORTH,
indv.NO_MERGE_REASON,indv.OCCUPATION,indv.OCCUPATION_TYPE,indv.OFFICIAL_NAME,indv.ORDERING_NAME,
indv.OVER_AGE_NUMBER,indv.PARTY_TYPE,indv.PERSON_HEIGHT,indv.PERSON_HEIGHT_UNIT_OF_MEASURE,indv.PERSON_LIFE_STAGE,
indv.PERSON_NAME,indv.PERSON_WEIGHT,indv.PERSON_WEIGHT_UNIT_OF_MEASURE,indv.PHOTO_URL,indv.PREFERRED_NAME,
indv.PRIMARY_HOBBY,indv.RELIGION,indv.RESIDENCE_CAPTURE_METHOD,indv.RESIDENCE_COUNTRY_NAME,indv.SALUTATION,indv.SECOND_LAST_NAME,
indv.SEND_INDIVIDUAL_DATA,indv.SHOULD_FORGET,indv.SURGERIES_LAST5_YEARS_COUNT,indv.TAX_BRACKET_RANGE,indv.UPDATED_BY,
indv.UPDATED_DATE,indv.WEB_SITE_URL,indv.WEDDING_ANNIVERSARY_DATE,indv.YEARLY_INCOME,indv.YEARLY_INCOME_RANGE " 

var otherParams = (" limit " ++ vars.limit ++" offset " ++ vars.offset)
---
[

//query for Individual Id	
("Select * from INDIVIDUAL where ID = '" ++ vars.individualId ++ "' "++ otherParams) if(vars.individualId != null),
 
//query for ExternalId
(
query ++ " from INDIVIDUAL indv,PARTY p where indv.ID=p.ID and p.ID in 
(select DISTINCT eipj.PARTY_ID from EXTERNAL_ID_PARTY_JOIN eipj,EXTERNAL_ID ei,EXTERNAL_ID_TYPE eit 
where  ei.id = eipj.EXTERNAL_ID and  eit.ID = ei.EXTERNAL_ID_TYPE and 
ei.EXTERNAL_ID= '" ++ vars.externalId ++ "')" ++ otherParams) if(vars.externalId != null),
	
//query for EmailAddress
(
query ++ "from INDIVIDUAL indv,PARTY p,CONTACT_POINT_EMAIL cpe, CONTACT_POINT_EMAIL_PARTY_JOIN cpepj 
where indv.ID = p.ID and cpepj.PARTY_ID = p.ID and cpe.ID = cpepj.CONTACT_POINT_EMAIL_ID 
and cpe.EMAIL_ADDRESS= '" ++ vars.emailAddress ++ "' " ++ otherParams
)  if(vars.emailAddress != null),

//default query
("Select * from INDIVIDUAL " ++ otherParams) if(vars.individualId == null and vars.externalId == null and vars.emailAddress == null)
]