<cfcomponent output="false" displayName="Cart Controller" extends="App.Controller">

	<cfset variables.Instance = {} />


    <cffunction name="init" access="public" returnType="cartController">
		<cfargument name="datasource" type="string" required="true">
		<cfargument name="enableUpdateDB" type="boolean" required="true">
		<cfset variables.Instance.service = createObject("component", "model.cartService").init(arguments.datasource,arguments.enableUpdateDB)>
		<cfreturn this>
	</cffunction>

	<cffunction name="getMerchant" access="public" returnType="struct" output="false">
		<cfargument name="merchantId" type="numeric" required="true">
		
		<cfset var viewbags = {}>
		
		
		<cfset viewbags.merchant = variables.Instance.service.getMerchant(arguments.merchantId)>

		<cfreturn viewbags>
	</cffunction>


</cfcomponent>