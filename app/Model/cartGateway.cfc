
    <cfcomponent output="false" displayName="Cart Gateway" extends="app.Gateway">
        <cfset variables.datasource = "datatail">

        <cffunction name="init" access="public" returnType="cartGateway">
            <cfargument name="datasource" type="string" required="true">
            <cfargument name="enableUpdateDB" type="boolean" required="true">
            <cfset SUPER.init(arguments.datasource,arguments.enableUpdateDB)>
            <cfreturn this>
        </cffunction>

    <cfset variables.dsn = "datatail">

	<cffunction name="getMerchant" access="public" returntype="query" output="false" hint="Get merchant info based on id">
        <cfargument name="merchantId" type="numeric" required="true">

        <cfset var data = "">
        <cfquery name="data" datasource="#variables.datasource#">
            select id,merchant, active
            from merchants
            where id = <cfqueryparam cfsqltype="integer" value="#arguments.merchantId#">
        </cfquery>
        <cfreturn data>
    </cffunction>

</cfcomponent>
