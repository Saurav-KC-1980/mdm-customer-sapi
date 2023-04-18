{
  "inboundAttachmentNames": [],
  "exceptionPayload": null,
  "inboundPropertyNames": [],
  "outboundAttachmentNames": [],
  "payload": [
    "select DISTINCT org.NAME,org.LEGAL_NAME,org.PARTY_TYPE,org.GLOBAL_PARTY,org.NO_MERGE_REASON,\norg.ID,org.CREATED_DATE,org.CREATED_BY,org.UPDATED_DATE,org.UPDATED_BY,p.ID PARTY_ID  from ORGANIZATION org,PARTY p where org.ID=p.ID and p.ID in \n(select DISTINCT eipj.PARTY_ID from EXTERNAL_ID_PARTY_JOIN eipj,EXTERNAL_ID ei,EXTERNAL_ID_TYPE eit \nwhere  ei.id = eipj.EXTERNAL_ID and  eit.ID = ei.EXTERNAL_ID_TYPE and \nei.EXTERNAL_ID= '03459c64-e40f-11eb-b8a7-0233bdd64096') limit 10 offset 0"
  ],
  "outboundPropertyNames": [],
  "attributes": {
    "headers": {
      "authorization": "Basic ZTZiMzRkYTdjOTEyNGI4ZDkzOTYzYmRmNzYyMjNlNWI6YzA2MTM3MTdhODZjNDJCRDgwOGNEMkZhRUU1MzYyRDg=",
      "user-agent": "PostmanRuntime/7.28.0",
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
      "externalId": "03459c64-e40f-11eb-b8a7-0233bdd64096"
    },
    "requestUri": "/api/organizations?offset=0&limit=10&externalId=03459c64-e40f-11eb-b8a7-0233bdd64096",
    "queryString": "offset=0&limit=10&externalId=03459c64-e40f-11eb-b8a7-0233bdd64096",
    "version": "HTTP/1.1",
    "maskedRequestPath": "/organizations",
    "listenerPath": "/api/*",
    "relativePath": "/api/organizations",
    "localAddress": "/127.0.0.1:8082",
    "uriParams": {},
    "rawRequestUri": "/api/organizations?offset=0&limit=10&externalId=03459c64-e40f-11eb-b8a7-0233bdd64096",
    "rawRequestPath": "/api/organizations",
    "remoteAddress": "/127.0.0.1:55548",
    "requestPath": "/api/organizations"
  }
}