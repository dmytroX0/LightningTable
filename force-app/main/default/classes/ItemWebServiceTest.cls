@isTest
private class ItemWebServiceTest{
    @testSetup
    public static void setupData() {
        Item__c itm = new Item__c();
        itm.name = 'mighty moose';
        insert itm;
    }
    @isTest 
    static void testPostCallout() {
        Item__c item = [Select id, Name From Item__c WHERE name = 'mighty moose'];
        set<id> itmIdSet = new set<id>();
        itmIdSet.add(Item.id); 
        Test.startTest();
        	Test.setMock(HttpCalloutMock.class, new ItemsHttpCalloutMock());
        	ItemWebService.addItem(itmIdSet);
        Test.stopTest();
    }
}