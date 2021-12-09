public class ItemTriggerHandler {
    public static void updateCount( List<Item__c> listItems, Map<Id,Item__c> mapOldItems ) {

        Set<Id> setOpportunityId = new Set<Id>();
        if( mapOldItems == null || mapOldItems.isEmpty() ) {
            for( Item__c objitm : listItems ) {
                if( objitm.Opportunity__c != null ) {
                    setOpportunityId.add( objitm.Opportunity__c);
                }
            }
        }
        else if( mapOldItems != null && !mapOldItems.isEmpty()) {
            for( Item__c objitm : listItems ) { 
                system.debug('1st if');
                system.debug(mapOldItems);
                system.debug(listItems);
                
                    system.debug(mapOldItems.get( objitm.Id ).Opportunity__c);
            
                if( objitm.Opportunity__c != null 
                && mapOldItems.get( objitm.id ).Opportunity__c != objitm.Opportunity__c ) {
                    system.debug('entered 1st if');
                    setOpportunityId.add( objitm.Opportunity__c );
                    if( mapOldItems.get( objitm.id ).Opportunity__c != null ) {
                        system.debug('entered 2nd if');
                        setOpportunityId.add( mapOldItems.get( objitm.Id ).Opportunity__c );
                    }
                }
                else if( objitm.Opportunity__c == null && mapOldItems.get( objitm.Id ).Opportunity__c != objitm.Opportunity__c ) {
                    system.debug('entered 3rd if');
                    setOpportunityId.add( mapOldItems.get( objitm.Id ).Opportunity__c);
                }
            }
        }
        if( !setOpportunityId.isEmpty() ) {
            List<Opportunity> listOpportunity = new List<Opportunity>();
            System.debug('entered if');
            system.debug(setOpportunityId);
            for( Opportunity objOpp : [ SELECT 
                                        Id, CurrentItemsQuantity__c,AllowedItems__c
                                        , ( SELECT Id FROM Items__r)
                                    	FROM
                                        Opportunity
                                    	WHERE
                                        Id In : setOpportunityId ] ) {
                objOpp.CurrentItemsQuantity__c = objOpp.Items__r != null && ( !objOpp.Items__r.isempty() ) ? objOpp.Items__r.size() : 0;
                listOpportunity.add( objOpp );
            if (objOpp.CurrentItemsQuantity__c > objOpp.AllowedItems__c){
                                                objOpp.addError('No more Items is allowed');
                                            }
            }

            if( !listOpportunity.isEmpty() ) {
                update listOpportunity;
            }
        }
    }
}