-- Test to validate that invocation of Stored Procedure to upsert external ids
-- with same payload multiple times does not introduce duplicate records
-- Replace the Party Role Id 08338b10-5f7d-11ed-adae-0e4f614e32e2 in the below 
-- queries with a valid Party Role Id and validate if the number of records
-- returned by the Select query is more than 1.

select ei.ID,ei.STATUS,ei.EXTERNAL_ID_TYPE,ei.EXTERNAL_ID,eiprj.EXTERNAL_ID,eit.NAME,ei.EXTERNAL_ID_TYPE,eiprj.PARTY_ROLE_ID  from EXTERNAL_ID ei, EXTERNAL_ID_TYPE eit , EXTERNAL_ID_PARTY_ROLE_JOIN eiprj where eit.NAME = 'MDM' and eiprj.PARTY_ROLE_ID = '08338b10-5f7d-11ed-adae-0e4f614e32e2'  and eiprj.EXTERNAL_ID = ei.ID and eit.ID = ei.EXTERNAL_ID_TYPE

call PartyRole_ExternalIds_Upsert('[
    {
        "id": null,
        "externalId": "test-external_cd1",
        "externalIdType": [
            "MDM"
        ],
        "status": "VALID",
        "statusLastChangedDate": "2022-10-06T19:30:35.000Z",
		  "createdBy": "system",
		  "updatedBy": "system"
    }
]','08338b10-5f7d-11ed-adae-0e4f614e32e2');

select ei.ID,ei.STATUS,ei.EXTERNAL_ID_TYPE,ei.EXTERNAL_ID,eiprj.EXTERNAL_ID,eit.NAME,ei.EXTERNAL_ID_TYPE,eiprj.PARTY_ROLE_ID  from EXTERNAL_ID ei, EXTERNAL_ID_TYPE eit , EXTERNAL_ID_PARTY_ROLE_JOIN eiprj where eit.NAME = 'MDM' and eiprj.PARTY_ROLE_ID = '08338b10-5f7d-11ed-adae-0e4f614e32e2'  and eiprj.EXTERNAL_ID = ei.ID and eit.ID = ei.EXTERNAL_ID_TYPE


call PartyRole_ExternalIds_Upsert('[
    {
        "id": null,
        "externalId": "test-external_cd1",
        "externalIdType": [
            "MDM"
        ],
        "status": "VALID",
        "statusLastChangedDate": "2022-10-06T19:30:35.000Z",
		  "createdBy": "system",
		  "updatedBy": "system"
    }
]','08338b10-5f7d-11ed-adae-0e4f614e32e2');

select ei.ID,ei.STATUS,ei.EXTERNAL_ID_TYPE,ei.EXTERNAL_ID,eiprj.EXTERNAL_ID,eit.NAME,ei.EXTERNAL_ID_TYPE,eiprj.PARTY_ROLE_ID  from EXTERNAL_ID ei, EXTERNAL_ID_TYPE eit , EXTERNAL_ID_PARTY_ROLE_JOIN eiprj where eit.NAME = 'MDM' and eiprj.PARTY_ROLE_ID = '08338b10-5f7d-11ed-adae-0e4f614e32e2'  and eiprj.EXTERNAL_ID = ei.ID and eit.ID = ei.EXTERNAL_ID_TYPE
