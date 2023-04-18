/**
 * ExternalIds of a Customer added as a Location Header to a response
 */
%dw 2.0
output application/java
---
vars.outboundHeaders default {} ++ {
	Location : ("/customers/" ++ (vars.customerId as String) ++ "/externalIds" )
}