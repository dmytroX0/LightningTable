public class SH_ItemCreateAPI {
    //Write below clientId, clientSecret, username, password (combination of password and security token) from Org B (Target Org)
    private static String clientId = '3MVG9t0sl2P.pByrmQLTfUz6Kex4iO2W.KCniTlVfFf_3K2AGA5KGtToyMP6GcKR8wXIf2145Z3EHJ5d_0qHI';
    private static String clientSecret = '501DEE53BBFB745F3A1EA4A09C947369BB7A2E43165622D5A312C19F0E0BB86D';
    private static String username = 'dmytro.havrylenko@playful-wolf-jw7xjd.com';
    private static String password = 'Dimon.havruk985buXmMEQhrL6SSrT5PWldLtE4';
    
    public class resWrapper
    {
        public String id;
        public String access_token;
    }
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
    public String getRequestToken(SH_ItemCreateAPI item){
        String reqbody = 'grant_type=password'+'&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
        Http h1 = new Http();
        HttpRequest req = new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST');
        req.setEndpoint('https://playful-wolf-jw7xjd-dev-ed.my.salesforce.com/services/oauth2/token');
        HttpResponse res = h1.send(req);
        resWrapper response = (resWrapper)JSON.deserialize(res.getBody(),resWrapper.class);
        System.debug('response--->>>'+response);
        return response.access_token;
    }
    @future(callout=true)
    public static void createItemMethod(Set<id> itmIdSet){
        SH_itemCreateAPI itml = new SH_ItemCreateAPI();
        String accessToken;
        String JSNBody;
        accessToken = itml.getRequestToken(itml);
        List<Item__c> itmList = new List<Item__c>();
        if(accessToken != null) {
            //Set Endpoint URL Of the Target Org Webservice Class
            String endPoint = 'https://playful-wolf-jw7xjd-dev-ed.my.salesforce.com/services/apexrest/v1/itemRecordCreate/';  
            For(Item__c item:[Select id, Name, Price__c, Quantity__c From Item__c WHERE Id IN: itmIdSet]){
                itmList.add(item);
                if(itmList.size() > 0)
                {
                    ItemWrap itmObj = new ItemWrap(itmList[0].name, itmList[0].Price__c, itmList[0].Quantity__c );
                     JSNBody = JSON.serialize(itmObj);
                }  
                    Http h2 = new Http();
                    HttpRequest req1 = new HttpRequest();
                    req1.setHeader('Authorization','Bearer ' + accessToken);
                    req1.setHeader('Content-Type','application/json');
                    req1.setHeader('accept','application/json');
                    req1.setMethod('POST');
                    req1.setBody(JSNBody);
                    System.debug('body--->>'+JSNBody);
                    req1.setEndpoint(endPoint);
                    HttpResponse res1 = h2.send(req1);
                    
                }
            }
            
        }
    }