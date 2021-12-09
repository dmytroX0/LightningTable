public class InlineEditForItemController {
        @AuraEnabled
    public static List<Opportunity> fetchOpportunityInfo(){
        List<Opportunity> showOpp = [SELECT Id,Name FROM Opportunity];
        return showOpp; 
    }
    @AuraEnabled
    public static list<Item__c> getRelatedList(Id recordId)
    {
        
        List<Item__c> itmlist = [Select id,Name,Price__c,Quantity__c, Opportunity__r.Name, Opportunity__c from Item__c where Opportunity__c =: recordId ];
        return itmlist;
    }
    
    @AuraEnabled
    public static void updateRelatedList(List<Item__c> itmlist){
        if(itmlist!= null && itmlist.size()>0)
        {
            update itmlist;
        }
    } 
}