<cfcomponent output="false" displayName="Cart Controller" extends="App.Controller">

    <cffunction name="init" access="public" returnType="cartController">
		<cfargument name="datasource" type="string" required="true">
		<cfargument name="enableUpdateDB" type="boolean" required="true">
		<cfset var service = createObject("component", "model.cartService").init(arguments.datasource,arguments.enableUpdateDB)>
		<cfreturn this>
	</cffunction>

	<cffunction name="getMerchant" access="public" returnType="struct" output="false">
		<cfset viewbags.applicationName = VARIABLES.Instance.appName>		

		<cfset var merchantId = "">
		<cfif isDefined("url.merchantId")>
			<cfset var merchantId = url.merchantId>
		</cfif>

		<cfset merchant = VARIABLES.Instance.service.getMerchant()>

		<cfreturn merchant>
	</cffunction>


</cfcomponent>