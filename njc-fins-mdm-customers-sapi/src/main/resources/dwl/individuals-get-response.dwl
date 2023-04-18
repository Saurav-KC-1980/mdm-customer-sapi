/**
 *  Search and Retrieve of Individual Mappings for MDM System 
 */
%dw 2.0
output application/json skipNullOn="everywhere"
fun formatDate(dateformats) = if (dateformats !=null) (dateformats as String {format: "uuuu-MM-dd"})  else null
---
/**
 * Maps MDM Individual as in DB to CIM Individual
 * @table CIM,MDM DB,Description
 * @row birthDate,BIRTH_DATE,Birth date of the individual
 * @row birthPlace,BIRTH_PLACE,Birth place of the individual
 * @row childrenCount,CHILDREN_COUNT,No. of children for the individual
 * @row consumerCreditScore,CONSUMER_CREDIT_SCORE,Consumer credit score of the individual
 * @row consumerCreditScoreProviderName,CONSUMER_CREDIT_SCORE_PROVIDER_NAME,Consumer credit score Provider related to the individual
 * @row convictionsCount,CONVICTIONS_COUNT,Count of convictions related to the individual
 * @row createdBy,CREATED_BY,Identifies the system or user which created the individual - default as property app.name
 * @row createdOn,CREATED_ON,Identifies the date on which the individual was created - default as sysdate
 * @row currentEmployerName,CURRENT_EMPLOYER_NAME,Current employer name of the individual
 * @row deathDate,DEATH_DATE,Death date of the individual (if applicable)
 * @row deathPlace,DEATH_PLACE,Death place of the individual
 * @row dependentCount,DEPENDENT_COUNT,No. of dependents related to the individual
 * @row doExtractMyDataUpdateDate,DO_EXTRACT_MY_DATA_UPDATE_DATE,Update date to extract data related to the individual
 * @row doForgetMeFromUpdateDate,DO_FORGET_ME_FROM_UPDATE_DATE,Update date to forget the individual
 * @row doNotMarketFromUpdateDate,DO_NOT_MARKET_FROM_UPDATE_DATE,Update date to market the individual
 * @row doNotProcessFromUpdateDate,DO_NOT_PROCESS_FROM_UPDATE_DATE,Update date to not process the individual
 * @row doNotProcessReason,DO_NOT_PROCESS_REASON,Reason to not process the individual
 * @row doNotProfileFromUpdateDate,DO_NOT_PROFILE_FROM_UPDATE_DATE,Update date to not profile the individual
 * @row doNotTrackLocationUpdateDate,DO_NOT_TRACK_LOCATION_UPDATE_DATE,Update date to not track the location of the individual
 * @row doNotTrackUpdateDate,DO_NOT_TRACK_UPDATE_DATE,Update date to not track the individual
 * @row employedSinceDate,EMPLOYED_SINCE_DATE,Employed since date of the individual
 * @row ethnicity,ETHNICITY,Ethnicity of the individual
 * @row firstName,FIRST_NAME,First name of the individual
 * @row gender,GENDER,Gender of the individual
 * @row globalParty,GLOBAL_PARTY,Global Party of the the individual
 * @row hasAlcoholAbuseHistory,HAS_ALCOHOL_ABUSE_HISTORY,Flag to mark alcohol abuse history
 * @row hasDrugAbuseHistory,HAS_DRUG_ABUSE_HISTORY,Flag to mark drug abuse history
 * @row highestEducationLevel,HIGHEST_EDUCATION_LEVEL,Highest education level of the individual
 * @row hospitalizationsLast5YearsCount,HOSPITALIZATIONS_LAST5_YEARS_COUNT,No. of hospitalization in last 5 years
 * @row id,ID,Unique Id to identify the individual
 * @row influencerRating,INFLUENCER_RATING,Influence rating of the individual
 * @row isAlcoholConsumer,IS_ALCOHOL_CONSUMER,Flag to mark as alcohol consumer
 * @row isDrugConsumer,IS_DRUG_CONSUMER,Flag to mark as drug consumer
 * @row isGoodDriver,IS_GOOD_DRIVER,Flag to mark as a good driver
 * @row isGoodStudent,IS_GOOD_STUDENT,Flag to mark as a good student
 * @row isHighRiskHobby,IS_HIGH_RISK_HOBBY,Flag to highlight individual has high risk hobby
 * @row isHighRiskOccupation,IS_HIGH_RISK_OCCUPATION,Flag to highlight individual has high risk occupation
 * @row isHomeOwner,IS_HOME_OWNER,Flag to mark as a home owner
 * @row isTobaccoConsume,IS_TOBACCO_CONSUME,Flag to mark individual consumes tobacco
 * @row lastName,LAST_NAME,Last name of the individual
 * @row mailingName,MAILING_NAME,Mailing name of the individual
 * @row mainDietaryHabitType,MAIN_DIETARY_HABIT_TYPE,Main dietary habit type of the individual
 * @row mainDisabilityType,MAIN_DISABILITY_TYPE,Main disability habit type of the individual
 * @row mainLifeAttitudeType,MAIN_LIFE_ATTITUDE_TYPE,Main life attitude type of the individual
 * @row mainLifeStyleType,MAIN_LIFE_STYLE_TYPE,Main life style type of the individual
 * @row mainPersonalityType,MAIN_PERSONAL_VALUE_TYPE,Main personality type of the individual
 * @row mainPersonalValueType,MAIN_PERSONALITY_TYPE,Main personal value type of the individual
 * @row majorCitationCount,MAJOR_CITATION_COUNT,No. of citations related to the individual
 * @row maritalStatus,MARITAL_STATUS,Marital status of the individual
 * @row middleName,MIDDLE_NAME,Middle name of the individual
 * @row militaryService,MILITARY_SERVICE,Military service of the individual
 * @row militaryStatus,MILITARY_STATUS,Military status of the individual
 * @row minorCitationCount,MINOR_CITATION_COUNT,No. of minor citations related to the individual
 * @row mothersMaidenName,MOTHERS_MAIDEN_NAME,Mothers maiden name of the individual
 * @row nameSuffix,NAME_SUFFIX,Name suffix of the individual
 * @row netWorth,NET_WORTH,Networth of the individual
 * @row noMergeReason,NO_MERGE_REASON, Reason to not merge the individual
 * @row occupation,OCCUPATION,Occupation of the individual
 * @row occupationType,OCCUPATION_TYPE,Occupation type of the individual
 * @row officialName,OFFICIAL_NAME,Official name of the individual
 * @row orderingName,ORDERING_NAME,Ordering name of the individual
 * @row overAgeNumber,OVER_AGE_NUMBER,Overage number of the individual
 * @row partyType,PARTY_TYPE,Party type of the individual
 * @row personHeight,PERSON_HEIGHT,Person height of the individual
 * @row personHeightUnitOfMeasure,PERSON_HEIGHT_UNIT_OF_MEASURE,Unit of measure used to measure person height of the individual
 * @row personLifeStage,PERSON_LIFE_STAGE,Person life stage of the individual
 * @row personName,PERSON_NAME,Person name of the individual
 * @row personWeight,PERSON_WEIGHT,Person weight of the individual
 * @row personWeightUnitOfMeasure,PERSON_WEIGHT_UNIT_OF_MEASURE,Unit of measure used to measure person weight of the individual
 * @row photoURL,PHOTO_URL,URL to the photo of the individual
 * @row preferredName,PREFERRED_NAME,Preferred name of the individual
 * @row primaryHobby,PRIMARY_HOBBY,Primary hobby of the individual
 * @row religion,RELIGION,Religion of the individual
 * @row residenceCaptureMethod,RESIDENCE_CAPTURE_METHOD,Residence capture method of the individual
 * @row residenceCountryName,RESIDENCE_COUNTRY_NAME,Country of residence of the individual
 * @row salutation,SALUTATION,Salutation of the individual
 * @row secondLastName,SECOND_LAST_NAME,Second last name of the individual
 * @row sendIndividualData,SEND_INDIVIDUAL_DATA,Flag to mark if individual data can be sent related to the individual
 * @row shouldForget,SHOULD_FORGET,Flag to forget the individual
 * @row surgeriesLast5YearsCount,SURGERIES_LAST5_YEARS_COUNT,No. of surgeries in last 5 years related to the individual
 * @row taxBracketRange,TAX_BRACKET_RANGE,Tax bracket range of the individual
 * @row updatedBy,UPDATED_BY,Identifies the system or user which updated the individual - default as property app.name
 * @row updatedOn,UPDATED_ON,Identifies the date on which the individual was updated - default as sysdate
 * @row webSiteURL,WEB_SITE_URL,URL of the website related to the individual
 * @row weddingAnniversaryDate,WEDDING_ANNIVERSARY_DATE,Wedding anniversary date of the individual
 * @row yearlyIncome,YEARLY_INCOME,Yearly income of the individual
 * @row yearlyIncomeRange,YEARLY_INCOME_RANGE,Yearly income range of the individual
 */
(payload map (item, index) ->
{
	globalParty: item.GLOBAL_PARTY,
	partyType: item.PARTY_TYPE, 
	noMergeReason: item.NO_MERGE_REASON,
	birthDate: formatDate(item.BIRTH_DATE),
	birthPlace: item.BIRTH_PLACE,
	childrenCount: item.CHILDREN_COUNT,
	consumerCreditScore: item.CONSUMER_CREDIT_SCORE ,
	consumerCreditScoreProviderName: item.CONSUMER_CREDIT_SCORE_PROVIDER_NAME ,
	convictionsCount: item.CONVICTIONS_COUNT ,
	currentEmployerName: item.CURRENT_EMPLOYER_NAME,
	deathDate: formatDate(item.DEATH_DATE),
	deathPlace: item.DEATH_PLACE,
	dependentCount: item.DEPENDENT_COUNT ,
	doExtractMyDataUpdateDate: formatDate(item.DO_EXTRACT_MY_DATA_UPDATE_DATE ),
	doForgetMeFromUpdateDate: formatDate(item.DO_FORGET_ME_FROM_UPDATE_DATE ),
	doNotMarketFromUpdateDate: formatDate(item.DO_NOT_MARKET_FROM_UPDATE_DATE),
	doNotProcessFromUpdateDate: formatDate(item.DO_NOT_PROCESS_FROM_UPDATE_DATE),
	doNotProcessReason: item.DO_NOT_PROCESS_REASON,
	doNotProfileFromUpdateDate: formatDate(item.DO_NOT_PROFILE_FROM_UPDATE_DATE),
	doNotTrackLocationUpdateDate: formatDate(item.DO_NOT_TRACK_LOCATION_UPDATE_DATE),
	doNotTrackUpdateDate: formatDate(item.DO_NOT_TRACK_UPDATE_DATE),
	employedSinceDate: formatDate(item.EMPLOYED_SINCE_DATE),
	ethnicity: item.ETHNICITY,
	(externalIds: vars.individualsExternalIds) if (vars.individualsExternalIds != null and !(isEmpty(vars.individualsExternalIds))),
	firstName: item.FIRST_NAME,
	gender: item.GENDER,
	hasAlcoholAbuseHistory: item.HAS_ALCOHOL_ABUSE_HISTORY,
	hasDrugAbuseHistory: item.HAS_DRUG_ABUSE_HISTORY,
	highestEducationLevel: item.HIGHEST_EDUCATION_LEVEL,
	hospitalizationsLast5YearsCount: item.HOSPITALIZATIONS_LAST5_YEARS_COUNT ,
	id: item.ID,
	influencerRating: item.INFLUENCER_RATING ,
	isAlcoholConsumer: item.IS_ALCOHOL_CONSUMER ,
	isDrugConsumer: item.IS_DRUG_CONSUMER ,
	isGoodDriver: item.IS_GOOD_DRIVER ,
	isGoodStudent: item.IS_GOOD_STUDENT ,
	isHighRiskHobby: item.IS_HIGH_RISK_HOBBY ,
	isHighRiskOccupation: item.IS_HIGH_RISK_OCCUPATION ,
	isHomeOwner: item.IS_HOME_OWNER ,
	isTobaccoConsume: item.IS_TOBACCO_CONSUME,
	lastName: item.LAST_NAME,
	mailingName: item.MAILING_NAME,
	mainDietaryHabitType: item.MAIN_DIETARY_HABIT_TYPE,
	mainDisabilityType: item.MAIN_DISABILITY_TYPE,
	mainLifeAttitudeType: item.MAIN_LIFE_ATTITUDE_TYPE,
	mainLifeStyleType: item.MAIN_LIFE_STYLE_TYPE,
	mainPersonalityType: item.MAIN_PERSONAL_VALUE_TYPE,
	mainPersonalValueType: item.MAIN_PERSONALITY_TYPE,
	majorCitationCount: item.MAJOR_CITATION_COUNT ,
	maritalStatus: item.MARITAL_STATUS,
	middleName: item.MIDDLE_NAME,
	militaryService: item.MILITARY_SERVICE,
	militaryStatus: item.MILITARY_STATUS,
	minorCitationCount: item.MINOR_CITATION_COUNT ,
	mothersMaidenName: item.MOTHERS_MAIDEN_NAME,
	nameSuffix: item.NAME_SUFFIX,
	netWorth: item.NET_WORTH ,
	occupation: item.OCCUPATION,
	occupationType: item.OCCUPATION_TYPE,
	officialName: item.OFFICIAL_NAME,
	orderingName: item.ORDERING_NAME,
	overAgeNumber: item.OVER_AGE_NUMBER ,
	personHeight: item.PERSON_HEIGHT,
	personHeightUnitOfMeasure: item.PERSON_HEIGHT_UNIT_OF_MEASURE,
	personLifeStage: item.PERSON_LIFE_STAGE,
	personName: item.PERSON_NAME,
	personWeight: item.PERSON_WEIGHT ,
	personWeightUnitOfMeasure: item.PERSON_WEIGHT_UNIT_OF_MEASURE,
	photoURL: item.PHOTO_URL,
	preferredName: item.PREFERRED_NAME,
	primaryHobby: item.PRIMARY_HOBBY,
	religion: item.RELIGION,
	residenceCaptureMethod: item.RESIDENCE_CAPTURE_METHOD,
	residenceCountryName: item.RESIDENCE_COUNTRY_NAME,
	salutation: item.SALUTATION,
	secondLastName: item.SECOND_LAST_NAME,
	sendIndividualData: item.SEND_INDIVIDUAL_DATA ,
	shouldForget: item.SHOULD_FORGET ,
	surgeriesLast5YearsCount: item.SURGERIES_LAST5_YEARS_COUNT ,
	taxBracketRange: item.TAX_BRACKET_RANGE,
	webSiteURL: item.WEB_SITE_URL,
	weddingAnniversaryDate: formatDate(item.WEDDING_ANNIVERSARY_DATE),
	yearlyIncome: item.YEARLY_INCOME,
	yearlyIncomeRange: item.YEARLY_INCOME_RANGE,
	auditInfo: {
		createdBy: item.CREATED_BY,
		createdDate: item.CREATED_DATE  as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
		updatedBy: item.UPDATED_BY,
		updatedDate: item.UPDATED_DATE  as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
		isDeleted:  item.isDeleted default false
	}
})