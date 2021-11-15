public class TriggerHandler {
    public void AfterCreate(List<Opportunity> opp){
        List<Item__c> itmList=new List<Item__c>();
        for(Opportunity obj:opp){ 
            Item__c itm=new Item__c();
            itm.Name='Test'; 
            itm.Price__c=10;
            itm.Quantity__c=1000;
            //itm.Opportunity__c =  
            itmList.add(itm); 
        }
       // if(itmList.size() < opp.Number_of_allowed_items__c){
            //insert itmList;
        //}
    }
}