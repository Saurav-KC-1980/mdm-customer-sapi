/**
 * Create Individual Mapping for MDM System. Maps CIM Individual to JSON which 
 * is used by stored procedure sp_Individuals_Create.
 * The fields in both CIM and JSON are identical.
 */
%dw 2.0
output application/json skipNullOn="everywhere"
---
/**
 * Maps CIM Individual to MDM Individual as in DB
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
{
	birthDate: payload.birthDate,
	birthPlace: payload.birthPlace,
	childrenCount: payload.childrenCount,
	consumerCreditScore: payload.consumerCreditScore,
	consumerCreditScoreProviderName: payload.consumerCreditScoreProviderName,
	convictionsCount: payload.convictionsCount,
	currentEmployerName: payload.currentEmployerName,
	createdDate: payload.auditInfo.createdDate default now(),
	createdBy: payload.auditInfo.createdBy default p('app.name'),
	deathDate: payload.deathDate ,
	deathPlace: payload.deathPlace,
	dependentCount: payload.dependentCount,
	(doExtractMyDataUpdateDate: payload.doExtractMyDataUpdateDate as Date) if(!isEmpty(payload.doExtractMyDataUpdateDate)),
	(doForgetMeFromUpdateDate: payload.doForgetMeFromUpdateDate as Date) if(!isEmpty(payload.doForgetMeFromUpdateDate)),
	(doNotMarketFromUpdateDate: payload.doNotMarketFromUpdateDate as Date) if(!isEmpty(payload.doNotMarketFromUpdateDate)),
	(doNotProcessFromUpdateDate: payload.doNotProcessFromUpdateDate as Date) if(!isEmpty(payload.doNotProcessFromUpdateDate)),
	doNotProcessReason: payload.doNotProcessReason,
	(doNotProfileFromUpdateDate: payload.doNotProfileFromUpdateDate as Date) if(!isEmpty(payload.doNotProfileFromUpdateDate)),
	(doNotTrackLocationUpdateDate: payload.doNotTrackLocationUpdateDate as Date) if(!isEmpty(payload.doNotTrackLocationUpdateDate)),
	(doNotTrackUpdateDate: payload.doNotTrackUpdateDate as Date) if(!isEmpty(payload.doNotTrackUpdateDate)),
	employedSinceDate: payload.employedSinceDate,
	ethnicity: payload.ethnicity,
	firstName: payload.firstName,
	gender: payload.gender,
	(hasAlcoholAbuseHistory: if(payload.hasAlcoholAbuseHistory) 1 else 0) if(!isEmpty(payload.hasAlcoholAbuseHistory)),
	(hasDrugAbuseHistory: if(payload.hasDrugAbuseHistory) 1 else 0) if(!isEmpty(payload.hasDrugAbuseHistory)) ,
	highestEducationLevel: payload.highestEducationLevel,
	hospitalizationsLast5YearsCount: payload.hospitalizationsLast5YearsCount,
	globalParty: payload.globalParty,
	id: payload.id , 
	influencerRating: payload.influencerRating,
	(isAlcoholConsumer: if(payload.isAlcoholConsumer) 1 else 0) if(!isEmpty(payload.isAlcoholConsumer)),
	(isDrugConsumer: if(payload.isDrugConsumer) 1 else 0) if(!isEmpty(payload.isDrugConsumer)),
	(isGoodDriver: if(payload.isGoodDriver) 1 else 0) if(!isEmpty(payload.isGoodDriver)),
	(isGoodStudent: if(payload.isGoodStudent) 1 else 0) if(!isEmpty(payload.isGoodStudent)) ,
	(isHighRiskHobby: if(payload.isHighRiskHobby) 1 else 0) if(!isEmpty(payload.isHighRiskHobby)),
	(isHighRiskOccupation: if(payload.isHighRiskOccupation) 0 else  1) if(!isEmpty(payload.isHighRiskOccupation)) ,
	(isHomeOwner: if(payload.isHomeOwner) 1 else 0) if(!isEmpty(payload.isHomeOwner)) ,
	(isTobaccoConsume: if(payload.isTobaccoConsume) 1 else 0) if(!isEmpty(payload.isTobaccoConsume)) ,
	lastName: payload.lastName,
	mailingName: payload.mailingName,
	mainDietaryHabitType: payload.mainDietaryHabitType,
	mainDisabilityType: payload.mainDisabilityType,
	mainLifeAttitudeType: payload.mainLifeAttitudeType,
	mainLifeStyleType: payload.mainLifeStyleType,
	mainPersonalityType: payload.mainPersonalityType,
	mainPersonalValueType: payload.mainPersonalValueType,
	majorCitationCount: payload.majorCitationCount ,
	maritalStatus: payload.maritalStatus,
	middleName: payload.middleName,
	militaryService: payload.militaryService,
	militaryStatus: payload.militaryStatus,
	minorCitationCount: payload.minorCitationCount,
	mothersMaidenName: payload.mothersMaidenName,
	nameSuffix: payload.nameSuffix,
	netWorth: payload.netWorth,
	noMergeReason: payload.noMergeReason,
	occupation: payload.occupation,
	occupationType: payload.occupationType,
	officialName: payload.officialName,
	orderingName: payload.orderingName,
	overAgeNumber: payload.overAgeNumber,
	partyType: 	payload.partyType default "Individual",
	personHeight: payload.personHeight,
	personHeightUnitOfMeasure: payload.personHeightUnitOfMeasure,
	personLifeStage: payload.personLifeStage,
	personName: payload.personName,
	personWeight: payload.personWeight,
	personWeightUnitOfMeasure: payload.personWeightUnitOfMeasure,
	photoURL: payload.photoURL,
	preferredName: payload.preferredName,
	primaryHobby: payload.primaryHobby,
	religion: payload.religion,
	residenceCaptureMethod: payload.residenceCaptureMethod,
	residenceCountryName: payload.residenceCountryName,
	salutation: payload.salutation,
	secondLastName: payload.secondLastName,
	(sendIndividualData: if(payload.sendIndividualData) 1 else 0) if(!isEmpty(payload.sendIndividualData)) ,
	(shouldForget: if(payload.shouldForget) 1 else 0) if(!isEmpty(payload.shouldForget)) ,
	surgeriesLast5YearsCount: payload.surgeriesLast5YearsCount,
	taxBracketRange	: payload.taxBracketRange,
	updatedBy:   payload.auditInfo.updatedBy default p('app.name'),
	updatedDate:   payload.auditInfo.updatedDate default now(), 
	webSiteURL: payload.webSiteURL,
	weddingAnniversaryDate: payload.weddingAnniversaryDate,
	yearlyIncome: payload.yearlyIncome,
	yearlyIncomeRange: payload.yearlyIncomeRange
}