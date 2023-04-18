{
  "inboundAttachmentNames": [],
  "exceptionPayload": null,
  "inboundPropertyNames": [],
  "outboundAttachmentNames": [],
  "payload": [
    "Select * from HOUSEHOLD hh where hh.ID = '29088538-dd2d-11ec-9ef1-02559fd41aa2'  limit 10 offset 0",
    "Select DISTINCT hh.ID,hh.PARTY_TYPE,hh.GLOBAL_PARTY,hh.NO_MERGE_REASON, hh.CREATED_BY,hh.CREATED_DATE,\nhh.NAME,hh.HOUSEHOLD_MEMBER_COUNT, hh.HOUSEHOLD_FORMED_DATE,hh.HOUSEHOLD_DISSOLVED_DATE,hh.UPDATED_BY,hh.UPDATED_DATE  from HOUSEHOLD hh,PARTY p where hh.ID=p.ID and p.ID in \n(select DISTINCT eipj.PARTY_ID from EXTERNAL_ID_PARTY_JOIN eipj,EXTERNAL_ID ei,EXTERNAL_ID_TYPE eit \nwhere  ei.id = eipj.EXTERNAL_ID and  eit.ID = ei.EXTERNAL_ID_TYPE and \nei.EXTERNAL_ID= 'b5ec9180-debc-4201-91d5-4db9518f0287') limit 10 offset 0"
  ],
  "outboundPropertyNames": [],
  "attributes": {
    "headers": {
      "authorization": "Basic e3thY2NlbGVyYXRvcl9hcHBfY2xpZW50X2lkfX06e3thY2NlbGVyYXRvcl9hcHBfY2xpZW50X3NlY3JldH19",
      "user-agent": "PostmanRuntime/7.29.0",
      "accept": "*/*",
      "host": "localhost:8082",
      "accept-encoding": "gzip, deflate, br",
      "connection": "keep-alive"
    },
    "clientCertificate": null,
    "method": "GET",
    "scheme": "https",
    "queryParams": {
      "offset": "0",
      "limit": "10",
      "externalId": "b5ec9180-debc-4201-91d5-4db9518f0287",
      "householdId": "29088538-dd2d-11ec-9ef1-02559fd41aa2"
    },
    "requestUri": "/api/households?offset=0&limit=10&externalId=b5ec9180-debc-4201-91d5-4db9518f0287&householdId=29088538-dd2d-11ec-9ef1-02559fd41aa2",
    "queryString": "offset=0&limit=10&externalId=b5ec9180-debc-4201-91d5-4db9518f0287&householdId=29088538-dd2d-11ec-9ef1-02559fd41aa2",
    "version": "HTTP/1.1",
    "maskedRequestPath": "/households",
    "listenerPath": "/api/*",
    "localAddress": "/127.0.0.1:8082",
    "relativePath": "/api/households",
    "uriParams": {},
    "rawRequestUri": "/api/households?offset=0&limit=10&externalId=b5ec9180-debc-4201-91d5-4db9518f0287&householdId=29088538-dd2d-11ec-9ef1-02559fd41aa2",
    "rawRequestPath": "/api/households",
    "remoteAddress": "/127.0.0.1:65516",
    "requestPath": "/api/households"
  }
}