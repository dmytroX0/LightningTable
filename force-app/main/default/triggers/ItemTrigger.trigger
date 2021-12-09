trigger ItemTrigger on Item__c ( after insert, after update, after delete, after undelete ) {

    if( Trigger.isAfter ) {

        if( Trigger.isInsert ) {
            ItemTriggerHandler.updateCount( trigger.new, null );
        }
        else if( Trigger.isUpdate) {
            ItemTriggerHandler.updateCount( trigger.new, trigger.oldMap );
        }
        else if( Trigger.isUndelete) {
            ItemTriggerHandler.updateCount( trigger.new, null );
        }
        else if( Trigger.isDelete ) {
            ItemTriggerHandler.updateCount( trigger.old, null );
        }
    }
}