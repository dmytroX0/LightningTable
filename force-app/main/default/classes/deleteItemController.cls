public class deleteItemController {
    @Auraenabled
    public static void createItem(Item__c it){
        insert it; 
    }
    
    @Auraenabled
    public static List<Item__c> getItems(){
        return [Select Name, Price__c, Quantity__c From Item__c LIMIT 5];
    }
    @Auraenabled
    public static List<Opportunity> getRecord(){
        return [Select Name,id From Opportunity];
    }
    
    @AuraEnabled
    public static List<Item__c> deleteItem(String itmid) {
        if(itmid != null){
            Item__c delItem=[Select Id from Item__c where id=:itmid];
            delete delItem;
        }
        return [Select Name, Price__c, Quantity__c From Item__c LIMIT 5];
    }
}