/**
 * Organization Id added as a Location Header to a response
 */
%dw 2.0
output application/java
---
vars.outboundHeaders default {} ++ {
	Location : ("/organizations/" ++ (payload.organizationId as String))
}
