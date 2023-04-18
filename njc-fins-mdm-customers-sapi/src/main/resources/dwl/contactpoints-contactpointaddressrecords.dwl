/**
 *  Filters payload to only have ContactPoints of ContactPointType - ContactPointAddress
 */
%dw 2.0
output application/java
---
payload filter ($.contactPointType contains("ContactPointAddress"))