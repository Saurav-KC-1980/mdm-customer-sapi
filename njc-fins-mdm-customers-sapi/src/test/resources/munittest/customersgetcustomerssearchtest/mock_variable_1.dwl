{
  "inboundAttachmentNames": [],
  "exceptionPayload": null,
  "inboundPropertyNames": [],
  "outboundAttachmentNames": [],
  "outboundPropertyNames": [],
  "payload": [
    "select cust.CHURN_SCORE, cust.CREATED_BY, cust.CREATED_DATE, cust.CUSTOMER_NUMBER, \ncust.CUSTOMER_SATISFACTION_SCORE, cust.CUSTOMER_STATUS, cust.ID, cust.LAST12_MONTHS_SUPPORT_CALL_COUNT, \ncust.LAST24_MONTHS_NEW_REVENUE_AMOUNT, cust.LAST12_MONTHS_NEW_REVENUE_AMOUNT, cust.MARKETING_EMAIL_RESPONSE_RATE, \ncust.NET_PROMOTER_SCORE, cust.ORIGINATING_CUSTOMER_SOURCE, cust.PROSPECT_RATING, cust.TOTAL_BOOKINGS_AMOUNT,\ncust.TOTAL_CONTRACTED_AMOUNT, cust.TOTAL_LIFE_TIME_VALUE, cust.TOTAL_PROFIT_CONTRIBUTION_AMOUNT, \ncust.UPDATED_BY, cust.UPDATED_DATE , pr.PARTY_ROLE_TYPE, prpj.PARTY_ID  from CUSTOMER cust, CUSTOMER_PARTY_JOIN cpj ,PARTY_ROLE_PARTY_JOIN prpj ,PARTY_ROLE pr  \n where  cpj.CUSTOMER_ID = cust.ID and prpj.PARTY_ID = cpj.PARTY_ID and pr.ID = cust.ID\nand cust.ID in (select pr.ID from EXTERNAL_ID_PARTY_ROLE_JOIN eipj,EXTERNAL_ID ei,EXTERNAL_ID_TYPE eit, PARTY_ROLE pr \nwhere eipj.PARTY_ROLE_ID  = pr.ID  and ei.id = eipj.EXTERNAL_ID and eit.ID = ei.EXTERNAL_ID_TYPE and \nei.EXTERNAL_ID= 'NLMAPES1GOT') limit 20 offset 0",
    "select cust.CHURN_SCORE, cust.CREATED_BY, cust.CREATED_DATE, cust.CUSTOMER_NUMBER, \ncust.CUSTOMER_SATISFACTION_SCORE, cust.CUSTOMER_STATUS, cust.ID, cust.LAST12_MONTHS_SUPPORT_CALL_COUNT, \ncust.LAST24_MONTHS_NEW_REVENUE_AMOUNT, cust.LAST12_MONTHS_NEW_REVENUE_AMOUNT, cust.MARKETING_EMAIL_RESPONSE_RATE, \ncust.NET_PROMOTER_SCORE, cust.ORIGINATING_CUSTOMER_SOURCE, cust.PROSPECT_RATING, cust.TOTAL_BOOKINGS_AMOUNT,\ncust.TOTAL_CONTRACTED_AMOUNT, cust.TOTAL_LIFE_TIME_VALUE, cust.TOTAL_PROFIT_CONTRIBUTION_AMOUNT, \ncust.UPDATED_BY, cust.UPDATED_DATE , pr.PARTY_ROLE_TYPE, prpj.PARTY_ID  from CUSTOMER cust, CUSTOMER_PARTY_JOIN cpj ,PARTY_ROLE_PARTY_JOIN prpj ,PARTY_ROLE pr,CONTACT_POINT_EMAIL cpe,\nCONTACT_POINT_EMAIL_PARTY_JOIN cpepj where  cpj.CUSTOMER_ID = cust.ID and prpj.PARTY_ID = cpj.PARTY_ID and pr.ID = cust.ID\nand cpepj.PARTY_ID = prpj.PARTY_ID and cpepj.CONTACT_POINT_EMAIL_ID = cpe.ID and \ncpe.EMAIL_ADDRESS = 'test1@testsalesforce.com'  limit 20 offset 0"
  ],
  "attributes": {
    "headers": {
      "authorization": "Basic ZTZiMzRkYTdjOTEyNGI4ZDkzOTYzYmRmNzYyMjNlNWI6YzA2MTM3MTdhODZjNDJCRDgwOGNEMkZhRUU1MzYyRDg=",
      "content-type": "application/json",
      "user-agent": "PostmanRuntime/7.26.10",
      "accept": "*/*",
      "host": "localhost:8082",
      "accept-encoding": "gzip, deflate, br",
      "connection": "keep-alive",
      "content-length": "1388"
    },
    "clientCertificate": null,
    "method": "GET",
    "scheme": "https",
    "queryParams": {
      "offset": "0",
      "emailAddress": "test1@testsalesforce.com",
      "externalId": "NLMAPES1GOT",
      "limit": "20"
    },
    "requestUri": "/api/customers?offset=0&emailAddress=test1@testsalesforce.com&externalId=NLMAPES1GOT",
    "queryString": "offset=0&emailAddress=test1@testsalesforce.com&externalId=NLMAPES1GOT&limit=20",
    "version": "HTTP/1.1",
    "maskedRequestPath": "/customers",
    "listenerPath": "/api/*",
    "relativePath": "/api/customers",
    "localAddress": "/127.0.0.1:8082",
    "uriParams": {},
    "rawRequestUri": "/api/customers?offset=0&emailAddress=test1@testsalesforce.com&externalId=NLMAPES1GOT",
    "rawRequestPath": "/api/customers",
    "remoteAddress": "/127.0.0.1:49853",
    "requestPath": "/api/customers"
  }
}