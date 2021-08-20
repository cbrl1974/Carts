<cfcomponent output="false" displayName="Check Cart Order local" hint="Check if a cart is working well on local">

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



 <!--- <cfquery name="getTransactionOrders" datasource="datatail">
     select top 50 * from MerchantTransactionLog
     where merchant_id = <cfqueryparam cfsqltype="integer" value="#url.mID#">
     order by id desc
 </cfquery>

 <cfquery name="getOrders" datasource="datatail">
     select * from CustomerOrders
     where merchant_id = <cfqueryparam cfsqltype="integer" value="#url.mID#">
     and customerComments ! = '[***TEST TRANSACTION***]'
     order by id desc
 </cfquery>

 <cfquery name="getTransactionLogs" datasource="datatail">
     select top 50 * from merchantwebsiteeventlogs 
     where merchantid = <cfqueryparam cfsqltype="integer" value="#url.mID#">
     order by time desc
 </cfquery>

 <cfquery name="getTopTransactionOrders" datasource="datatail">
     select top 1 customerOrderid, creationTimeStamp from MerchantTransactionLog
     where merchant_id = <cfqueryparam cfsqltype="integer" value="#url.mID#">
     and customerOrderid is not null
     and requestSent not like '%tailbase.com%'
     order by customerOrderid desc
 </cfquery>

 <cfquery name="CustomerOrderEmailsHistory" datasource="datatail">
     select top 20 * from CustomerOrderEmailsHistory
     where orderid in (select customerOrderId from MerchantTransactionLog
     where merchant_id =<cfqueryparam cfsqltype="integer" value="#url.mID#">)
     order by id desc
 </cfquery> --->

</cfcomponent>
