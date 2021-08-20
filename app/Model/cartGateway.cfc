<cfcomponent output="false" displayName="Check Cart Order local" hint="Check if a cart is working well on local">

    <cfcomponent output="false" displayName="Rebates Gateway" extends="app.Gateway">

        <cffunction name="init" access="public" returnType="cartGateway">
            <cfargument name="datasource" type="string" required="true">
            <cfargument name="enableUpdateDB" type="boolean" required="true">
            <cfset SUPER.init(arguments.datasource,arguments.enableUpdateDB)>
            <cfreturn this>
        </cffunction>

    <cfset variables.dsn = "datatail">

	<cffunction name="getMerchant" access="public" returntype="query" output="false" hint="Get merchant info based on id">
        <cfargument name="mID" type="numeric" required="true">

        <cfquery name="data" datasource="#variables.dsn#">
            select merchant, active
            from merchants
            where id = <cfqueryparam cfsqltype="integer" value="#arguments.mID#">
        </cfquery>
        <cfreturn data>
    </cffunction>
    
</cfcomponent>
