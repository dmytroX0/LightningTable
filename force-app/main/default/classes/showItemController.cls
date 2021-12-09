public with sharing class showItemController { 
    @AuraEnabled(Cacheable=true)
    public static List <Item__c> getAllItems() {
        return [SELECT Id, Name, Price__c, Quantity__c 
            FROM Item__c ORDER BY CreatedDate DESC];
    }
}