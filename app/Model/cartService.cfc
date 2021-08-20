<cfcomponent output="false" displayName="Cart Service" extends="app.Service">

	<cffunction name="init" access="public" returnType="cartService">
		<cfargument name="datasource" type="string" required="true">
		<cfargument name="enableUpdateDB" type="boolean" required="true">
		<cfset var gateway = createObject("component", "cartGateway").init(arguments.datasource,arguments.enableUpdateDB)>
		<cfset SUPER.init(gateway)>
		<cfreturn this>
	</cffunction>

	<cffunction name="getMerchant" access="public" returnType="query" output="false">
		<cfargument name="merchantId" type="array" required="true">
		<cfreturn VARIABLES.Instance.gateway.getMerchant()>
	</cffunction>

</cfcomponent>
