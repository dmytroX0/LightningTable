({
	packItem : function(component, event, helper) {
		component.set('v.Item.Packed__c',true);
        event.getSource().set('v.disabled',true);
	}
})