{
  "inboundAttachmentNames": [],
  "exceptionPayload": null,
  "inboundPropertyNames": [],
  "outboundAttachmentNames": [],
  "outboundPropertyNames": [],
  "payload": [
    "select DISTINCT pr.ID,pr.PARTY_ROLE_TYPE, p.ID PARTY_ID, p.GLOBAL_PARTY ,p.NO_MERGE_REASON ,p.PARTY_TYPE \nfrom PARTY_ROLE pr,PARTY p,PARTY_ROLE_PARTY_JOIN prpj where  prpj.PARTY_ID=p.ID and prpj.PARTY_ROLE_ID =pr.ID   limit 10 offset 0"
  ],
  "attributes": {
    "headers": {
      "authorization": "Basic ZTZiMzRkYTdjOTEyNGI4ZDkzOTYzYmRmNzYyMjNlNWI6YzA2MTM3MTdhODZjNDJCRDgwOGNEMkZhRUU1MzYyRDg=",
      "user-agent": "PostmanRuntime/7.26.10",
      "accept": "*/*",
      "postman-token": "a7c6f284-08b0-4cc1-9e37-a4ee49b51de3",
      "host": "localhost:8082",
      "accept-encoding": "gzip, deflate, br",
      "connection": "keep-alive"
    },
    "clientCertificate": null,
    "method": "GET",
    "scheme": "https",
    "queryParams": {
      "limit": "10",
      "offset": "0"
    },
    "requestUri": "/api/partyRoles?limit=10&offset=0",
    "queryString": "limit=10&offset=0",
    "version": "HTTP/1.1",
    "maskedRequestPath": "/partyRoles",
    "listenerPath": "/api/*",
    "relativePath": "/api/partyRoles",
    "localAddress": "/127.0.0.1:8082",
    "uriParams": {},
    "rawRequestUri": "/api/partyRoles?limit=10&offset=0",
    "rawRequestPath": "/api/partyRoles",
    "remoteAddress": "/127.0.0.1:62569",
    "requestPath": "/api/partyRoles"
  }
}