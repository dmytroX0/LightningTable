public with sharing class ItemWebService {
 
    public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;
 
 public class ItemWrap{
        public string case_region;
        public String wName;
        public Decimal wPrice;
        public Decimal wQuantity;
        public ItemWrap(String name,Decimal Price, Decimal Quantity)
        {
            this.wName = name;
            this.wPrice = Price;
            this.wQuantity = Quantity;
        } 
    }
    @future(callout=true)
    public static void addItem(Set<id> itmIdSet) {
        String JSNBody;
        List<Item__c> itmList = new List<Item__c>();
        for(Item__c item:[Select id, Name, Price__c, Quantity__c From Item__c WHERE Id IN: itmIdSet]){
                itmList.add(item);
                if(itmList.size() > 0)
                {
                    ItemWrap itmObj = new ItemWrap(itmList[0].name, itmList[0].Price__c, itmList[0].Quantity__c );
                     JSNBody = JSON.serialize(itmObj);
                }
        }
        
        request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('callout:SalesforceItem/services/apexrest/v1/itemRecordCreate/');
        request.setHeader('Content-Type', 'application/json');
		request.setBody('{"name":"mighty moose"}');
        system.debug(request);
 
        response = http.send(request); 
 		System.debug(response);
        System.debug(response.getBody());
       
    }
}