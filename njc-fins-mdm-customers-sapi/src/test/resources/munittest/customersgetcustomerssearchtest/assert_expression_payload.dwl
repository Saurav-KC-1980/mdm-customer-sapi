%dw 2.0
import * from dw::test::Asserts
---
payload must equalTo([
  {
    "id": "eb855d3e-918d-11eb-b4c8-0233bdd64096",
    "churnScore": 4031,
    "customerNumber": "1234446",
    "customerStatus": "Screened",
    "last24MonthsNewRevenueAmount": 9035,
    "originatingCustomerSource": "TV",
    "party": [
      "e05b8d22-918d-11eb-b4c8-0233bdd64096"
    ],
    "partyRoleType": "Customer",
    "prospectRating": "80% Sucess Rate",
    "totalContractedAmount": 15478,
    "totalLifeTimeValue": 48239,
    "auditInfo": {
      "createdBy": "accelerator-mdm-sys-api",
      "createdDate": "2021-03-30T20:58:58.000Z",
      "updatedBy": "accelerator-mdm-sys-api",
      "updatedDate": "2021-03-30T20:58:58.000Z",
      "isDeleted": false
    }
  },
  {
    "id": "eb855d3e-918d-11eb-b4c8-0233bdd64096",
    "churnScore": 4031,
    "customerNumber": "1234446",
    "customerStatus": "Screened",
    "last24MonthsNewRevenueAmount": 9035,
    "originatingCustomerSource": "TV",
    "party": [
      "e05b8d22-918d-11eb-b4c8-0233bdd64096"
    ],
    "partyRoleType": "Customer",
    "prospectRating": "80% Sucess Rate",
    "totalContractedAmount": 15478,
    "totalLifeTimeValue": 48239,
    "auditInfo": {
      "createdBy": "accelerator-mdm-sys-api",
      "createdDate": "2021-03-30T20:58:58.000Z",
      "updatedBy": "accelerator-mdm-sys-api",
      "updatedDate": "2021-03-30T20:58:58.000Z",
      "isDeleted": false
    }
  }
])