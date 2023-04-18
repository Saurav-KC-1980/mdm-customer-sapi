/**
 * Update Individual Mapping for MDM System.  Maps CIM Indiviudal to payload 
 * which is used as input parameter in the update query of INDIVIDUAL table.
 * The fields in both CIM and MDM are identical.
 * PATCH payload is created by validating the Input Request payload with DB Record Payload.
 * Few of the DB fields will not be updated as they are not allowed.
 */
%dw 2.0
output application/java
/**
 * payloadRecordfromDB is the existing customer record in MDM system
 */
var payloadRecordfromDB = vars.individualDBRecord
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
---
{
	birthDate: (if(payload.birthDate?) payload.birthDate else payloadRecordfromDB.birthDate),
	birthPlace: (if(payload.birthPlace?) payload.birthPlace else payloadRecordfromDB.birthPlace),
	childrenCount: (if(payload.childrenCount?) payload.childrenCount else payloadRecordfromDB.childrenCount),
	consumerCreditScore: (if(payload.consumerCreditScore?) payload.consumerCreditScore else payloadRecordfromDB.consumerCreditScore),
	consumerCreditScoreProviderName: (if(payload.consumerCreditScoreProviderName?) payload.consumerCreditScoreProviderName else payloadRecordfromDB.consumerCreditScoreProviderName),
	convictionsCount: (if(payload.convictionsCount?) payload.convictionsCount else payloadRecordfromDB.convictionsCount),
	createdBy: p('app.name'),
	createdDate: now(),
	currentEmployerName: (if(payload.currentEmployerName?) payload.currentEmployerName else payloadRecordfromDB.currentEmployerName),
	deathDate: (if(payload.deathDate?) payload.deathDate else payloadRecordfromDB.deathDate),
	deathPlace: (if(payload.deathPlace?) payload.deathPlace else payloadRecordfromDB.deathPlace),
	dependentCount: (if(payload.dependentCount?) payload.dependentCount else payloadRecordfromDB.dependentCount),
	doExtractMyDataUpdateDate: (if(payload.doExtractMyDataUpdateDate?) payload.doExtractMyDataUpdateDate else payloadRecordfromDB.doExtractMyDataUpdateDate),
	doForgetMeFromUpdateDate: (if(payload.doForgetMeFromUpdateDate?) payload.doForgetMeFromUpdateDate else payloadRecordfromDB.doForgetMeFromUpdateDate),
	doNotMarketFromUpdateDate: (if(payload.doNotMarketFromUpdateDate?) payload.doNotMarketFromUpdateDate else payloadRecordfromDB.doNotMarketFromUpdateDate),
	doNotProcessFromUpdateDate: (if(payload.doNotProcessFromUpdateDate?) payload.doNotProcessFromUpdateDate else payloadRecordfromDB.doNotProcessFromUpdateDate),
	doNotProcessReason: (if(payload.doNotProcessReason?) payload.doNotProcessReason else payloadRecordfromDB.doNotProcessReason),
	doNotProfileFromUpdateDate: (if(payload.doNotProfileFromUpdateDate?) payload.doNotProfileFromUpdateDate else payloadRecordfromDB.doNotProfileFromUpdateDate),
	doNotTrackLocationUpdateDate: (if(payload.doNotTrackLocationUpdateDate?) payload.doNotTrackLocationUpdateDate else payloadRecordfromDB.doNotTrackLocationUpdateDate),
	doNotTrackUpdateDate: (if(payload.doNotTrackUpdateDate?) payload.doNotTrackUpdateDate else payloadRecordfromDB.doNotTrackUpdateDate),
	employedSinceDate: (if(payload.employedSinceDate?) payload.employedSinceDate else payloadRecordfromDB.employedSinceDate),
	ethnicity: (if(payload.ethnicity?) payload.ethnicity else payloadRecordfromDB.ethnicity),
	firstName: (if(payload.firstName?) payload.firstName else payloadRecordfromDB.firstName),
	gender: (if(payload.gender?) payload.gender else payloadRecordfromDB.gender),
	globalParty: (if(payload.globalParty?) payload.globalParty else payloadRecordfromDB.globalParty),
	hasAlcoholAbuseHistory: (if(payload.hasAlcoholAbuseHistory?) (if(payload.hasAlcoholAbuseHistory) 1 else 0)  else payloadRecordfromDB.hasAlcoholAbuseHistory),
	hasDrugAbuseHistory: (if(payload.hasDrugAbuseHistory?) (if(payload.hasDrugAbuseHistory) 1 else 0)  else payloadRecordfromDB.hasDrugAbuseHistory),
	highestEducationLevel: (if(payload.highestEducationLevel?) payload.highestEducationLevel  else payloadRecordfromDB.highestEducationLevel),
	hospitalizationsLast5YearsCount: (if(payload.hospitalizationsLast5YearsCount?) payload.hospitalizationsLast5YearsCount else payloadRecordfromDB.hospitalizationsLast5YearsCount),
	id: vars.individualId,
	influencerRating: (if(payload.influencerRating?) payload.influencerRating else payloadRecordfromDB.influencerRating),
	isAlcoholConsumer: (if(payload.isAlcoholConsumer?) (if(payload.isAlcoholConsumer) 1 else 0) else payloadRecordfromDB.isAlcoholConsumer),
	isDrugConsumer: (if(payload.isDrugConsumer?) (if(payload.isDrugConsumer) 1 else 0) else payloadRecordfromDB.isDrugConsumer),
	isGoodDriver: (if(payload.isGoodDriver?) (if(payload.isGoodDriver) 1 else 0) else payloadRecordfromDB.isGoodDriver),
	isGoodStudent: (if(payload.isGoodStudent?) (if(payload.isGoodStudent) 1 else 0)  else payloadRecordfromDB.isGoodStudent),
	isHighRiskHobby: (if(payload.isHighRiskHobby?) (if(payload.isHighRiskHobby) 1 else 0)  else payloadRecordfromDB.isHighRiskHobby),
	isHighRiskOccupation: (if(payload.isHighRiskOccupation?) (if(payload.isHighRiskOccupation) 1 else 0) else payloadRecordfromDB.isHighRiskOccupation),
	isHomeOwner: (if(payload.isHomeOwner?) (if(payload.isHomeOwner) 1 else 0)  else payloadRecordfromDB.isHomeOwner),
	isTobaccoConsume: (if(payload.isTobaccoConsume?) (if(payload.isTobaccoConsume) 1 else 0)  else payloadRecordfromDB.isTobaccoConsume),
	lastName: (if(payload.lastName?) payload.lastName else payloadRecordfromDB.lastName),
	mailingName: (if(payload.mailingName?) payload.mailingName else payloadRecordfromDB.mailingName),
	mainDietaryHabitType: (if(payload.mainDietaryHabitType?) payload.mainDietaryHabitType else payloadRecordfromDB.mainDietaryHabitType),
	mainDisabilityType: (if(payload.mainDisabilityType?) payload.mainDisabilityType else payloadRecordfromDB.mainDisabilityType),
	mainLifeAttitudeType: (if(payload.mainLifeAttitudeType?) payload.mainLifeAttitudeType else payloadRecordfromDB.mainLifeAttitudeType),
	mainLifeStyleType: (if(payload.mainLifeStyleType?) payload.mainLifeStyleType else payloadRecordfromDB.mainLifeStyleType),
	mainPersonalityType: (if(payload.mainPersonalityType?) payload.mainPersonalityType else payloadRecordfromDB.mainPersonalityType),
	mainPersonalValueType: (if(payload.mainPersonalValueType?) payload.mainPersonalValueType else payloadRecordfromDB.mainPersonalValueType),
	majorCitationCount: (if(payload.majorCitationCount?) payload.majorCitationCount else payloadRecordfromDB.majorCitationCount),
	maritalStatus: (if(payload.maritalStatus?) payload.maritalStatus else payloadRecordfromDB.maritalStatus),
	middleName: (if(payload.middleName?) payload.middleName else payloadRecordfromDB.middleName),
	militaryService: (if(payload.militaryService?) payload.militaryService else payloadRecordfromDB.militaryService),
	militaryStatus: (if(payload.militaryStatus?) payload.militaryStatus else payloadRecordfromDB.militaryStatus),
	minorCitationCount: (if(payload.minorCitationCount?) payload.minorCitationCount else payloadRecordfromDB.minorCitationCount),
	mothersMaidenName: (if(payload.mothersMaidenName?) payload.mothersMaidenName else payloadRecordfromDB.mothersMaidenName),
	nameSuffix: (if(payload.nameSuffix?) payload.nameSuffix else payloadRecordfromDB.nameSuffix),
	netWorth: (if(payload.netWorth?) payload.netWorth else payloadRecordfromDB.netWorth),
	noMergeReason: (if(payload.noMergeReason?) payload.noMergeReason else payloadRecordfromDB.noMergeReason),
	occupation: (if(payload.occupation?) payload.occupation else payloadRecordfromDB.occupation),
	occupationType: (if(payload.occupationType?) payload.occupationType else payloadRecordfromDB.occupationType),
	officialName: (if(payload.officialName?) payload.officialName else payloadRecordfromDB.officialName),
	orderingName: (if(payload.orderingName?) payload.orderingName else payloadRecordfromDB.orderingName),
	overAgeNumber: (if(payload.overAgeNumber?) payload.overAgeNumber else payloadRecordfromDB.overAgeNumber),
	partyType: (if(payload.partyType?) payload.partyType else payloadRecordfromDB.partyType),
	personHeight: (if(payload.personHeight?) payload.personHeight else payloadRecordfromDB.personHeight),
	personHeightUnitOfMeasure: (if(payload.personHeightUnitOfMeasure?) payload.personHeightUnitOfMeasure else payloadRecordfromDB.personHeightUnitOfMeasure),
	personLifeStage: (if(payload.personLifeStage?) payload.personLifeStage else payloadRecordfromDB.personLifeStage),
	personName: (if(payload.personName?) payload.personName else payloadRecordfromDB.personName),
	personWeight: (if(payload.personWeight?) payload.personWeight else payloadRecordfromDB.personWeight),
	personWeightUnitOfMeasure: (if(payload.personWeightUnitOfMeasure?) payload.personWeightUnitOfMeasure else payloadRecordfromDB.personWeightUnitOfMeasure),
	photoURL: (if(payload.photoURL?) payload.photoURL else payloadRecordfromDB.photoURL),
	preferredName: (if(payload.preferredName?) payload.preferredName else payloadRecordfromDB.preferredName),
	primaryHobby: (if(payload.primaryHobby?) payload.primaryHobby else payloadRecordfromDB.primaryHobby),
	religion: (if(payload.religion?) payload.religion else payloadRecordfromDB.religion),
	residenceCaptureMethod: (if(payload.residenceCaptureMethod?) payload.residenceCaptureMethod else payloadRecordfromDB.residenceCaptureMethod),
	residenceCountryName: (if(payload.residenceCountryName?) payload.residenceCountryName else payloadRecordfromDB.residenceCountryName),
	salutation: (if(payload.salutation?) payload.salutation else payloadRecordfromDB.salutation),
	secondLastName: (if(payload.secondLastName?) payload.secondLastName else payloadRecordfromDB.secondLastName),
	sendIndividualData: (if(payload.sendIndividualData?) (if(payload.sendIndividualData) 1 else 0)  else payloadRecordfromDB.sendIndividualData),
	shouldForget: (if(payload.shouldForget?) (if(payload.shouldForget) 1 else 0)  else payloadRecordfromDB.shouldForget),
	surgeriesLast5YearsCount: (if(payload.surgeriesLast5YearsCount?) payload.surgeriesLast5YearsCount else payloadRecordfromDB.surgeriesLast5YearsCount),
	taxBracketRange: (if(payload.taxBracketRange?) payload.taxBracketRange else payloadRecordfromDB.taxBracketRange),
	updatedBy: p('app.name'),
	updatedDate: now(),
	webSiteURL: (if(payload.webSiteURL?) payload.webSiteURL else payloadRecordfromDB.webSiteURL),
	weddingAnniversaryDate: (if(payload.weddingAnniversaryDate?) payload.weddingAnniversaryDate else payloadRecordfromDB.weddingAnniversaryDate),
	yearlyIncome: (if(payload.yearlyIncome?) payload.yearlyIncome else payloadRecordfromDB.yearlyIncome),
	yearlyIncomeRange: (if(payload.yearlyIncomeRange?) payload.yearlyIncomeRange else payloadRecordfromDB.yearlyIncomeRange)
}