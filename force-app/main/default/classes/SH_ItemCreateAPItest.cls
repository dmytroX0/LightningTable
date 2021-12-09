@isTest
public class SH_ItemCreateAPItest {
    
    @isTest
    static void testGetPositive() {
        String requestJson = '{"attributes": {"type": "Item__c"},"Price__c": "23","Quantity__c":"12"}';
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestURI = '/services/apexrest/Item';
        RestContext.request.httpMethod = 'POST';
        RestContext.request.requestBody = Blob.valueOf(requestJson);
        Test.startTest();

        Test.stopTest();
        
        // Assert
        Integer itemCount = [SELECT COUNT() FROM Item__c];
        System.assertEquals(1, itemCount);
        System.assertEquals(201, RestContext.response.statusCode);
        
        
    }
}