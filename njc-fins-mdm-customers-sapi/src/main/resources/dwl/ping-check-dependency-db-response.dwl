%dw 2.0
output application/java
---
[{
	"name": vars.sysCheckHost,
	"status": vars.backendSystemStatus
}]