%dw 2.0
import * from dw::test::Asserts
---
payload must equalTo([
  {
    globalParty: "9b767db4-ca4c-43dd-8656-451b15cfd786",
    id: "29088538-dd2d-11ec-9ef1-02559fd41aa2",
    householdMemberCount: 3,
    householdDissolvedDate: "2019-08-15",
    householdFormedDate: "2009-01-15",
    partyType: "Household",
    noMergeReason: "none",
    name: "Michelle Schamberger Jr.",
    auditInfo: {
      createdBy: "mdm-customers-postman",
      createdDate: "2022-05-26T19:50:57.000Z",
      updatedBy: "fins-mdm-customers-sys-api",
      updatedDate: "2022-05-26T19:54:13.000Z",
      isDeleted: false
    }
  }
])