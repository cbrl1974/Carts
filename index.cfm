
<cfif structKeyExists(url, "mID" )>

    <cfset cartCheck = createObject("component", "cartGateway/myOrders")>
    <cfset objMerchant = cartCheck.getMerchant(url.mID)>


    <cfquery name="getTransactionOrders" datasource="datatail">
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
    </cfquery>

    <cfset isMerchantActive = objMerchant.active eq 1>

    <cfif isMerchantActive>
        <h2 style="text-align:center">Merchant <cfoutput>#objMerchant.merchant# (#url.mID#)</cfoutput> is Active</h2>
    <cfelse>
        <h2 style="color:Red;text-align:center">Merchant is Not Active</h2>
    </cfif>

    <cfif getTopTransactionOrders.recordCount GT 0>
        <h2 style="text-align:center">Last Order registered was on <cfoutput>#dateFormat(getTopTransactionOrders.creationTimeStamp, "yyyy-mm-dd")#</cfoutput></h2>
        <cfif DateDiff("d", getTopTransactionOrders.creationTimeStamp, now()) GT 6>
            <h2 style="color:red;text-align:center">No orders for 7 days???. Last Order was on <cfoutput>#dateFormat(getTopTransactionOrders.creationTimeStamp, "yyyy-mm-dd")#</cfoutput></h2>
        </cfif>
    <cfelse>
        <h2 style="color:Red;text-align:center">Review the settings. Something must be wrong</h2>
    </cfif>

    <cfdump var = #getOrders#>
  
  

</cfif>