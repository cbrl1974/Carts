

    <cfset myDatabase = "datatail">
    <cfset isEnabledUpdateDB = false>
    <cfset controller = createObject("component", "controller.cartController").init(myDatabase,isEnabledUpdateDB) />
    <cfif isDefined('url.merchantid')>
        <cfset objMerchant = controller.getMerchant(url.merchantid)>
    </cfif>


   

<cfquery name="getTransactionOrders" datasource="datatail">
        select top 50 * from MerchantTransactionLog
        where merchant_id = <cfqueryparam cfsqltype="integer" value="#url.merchantid#">
        order by id desc
    </cfquery>

    
    <cfquery name="getOrders" datasource="datatail">
        select * from CustomerOrders
        where merchant_id = <cfqueryparam cfsqltype="integer" value="#url.merchantid#">
        and customerComments ! = '[***TEST TRANSACTION***]'
        order by id desc
    </cfquery>

    <cfquery name="getTransactionLogs" datasource="datatail">
        select top 50 * from merchantwebsiteeventlogs 
        where merchantid = <cfqueryparam cfsqltype="integer" value="#url.merchantid#">
        order by time desc
    </cfquery>

    <cfquery name="getTopTransactionOrders" datasource="datatail">
        select top 1 customerOrderid, creationTimeStamp from MerchantTransactionLog
        where merchant_id = <cfqueryparam cfsqltype="integer" value="#url.merchantid#">
        and customerOrderid is not null
        and requestSent not like '%tailbase.com%'
        order by customerOrderid desc
    </cfquery>

    <cfquery name="CustomerOrderEmailsHistory" datasource="datatail">
        select top 20 * from CustomerOrderEmailsHistory
        where orderid in (select customerOrderId from MerchantTransactionLog
        where merchant_id =<cfqueryparam cfsqltype="integer" value="#url.merchantid#">)
        order by id desc
    </cfquery>

    <cfset isMerchantActive = objMerchant.merchant.active eq 1>

    <cfif isMerchantActive>
        <h2 style="text-align:center">Merchant <cfoutput>#objMerchant.merchant.merchant# (#objMerchant.merchant.id#)</cfoutput> is Active</h2>
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

    <!--- <cfdump var = #getOrders#> --->
  
  

