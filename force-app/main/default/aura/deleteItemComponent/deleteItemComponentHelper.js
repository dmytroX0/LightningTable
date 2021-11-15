({
    ItemList : function(component, event) {
        var action = component.get('c.getItems'); //Calling apex class method
        action.setCallback(this, function(response) {
            //Whatever result get  setting on that attribute which is mentioned in component
            component.set('v.Items',response.getReturnValue());
        });
        $A.enqueueAction(action);
    },
    OpportunityList : function(component, event) {
        var action = component.get('c.getRecord'); //Calling apex class method
        action.setCallback(this, function(response) {
            //Whatever result get  setting on that attribute which is mentioned in component
            component.set('c.Opportunity',response.getReturnValue());
        });
        $A.enqueueAction(action);
    },
    deleteOpportunity : function(component, event) {
        var action = component.get('c.deleteItem'); //Calling Apex Method
        action.setParams({itmid:event.target.id}); // Passing the Contact Record Id
        action.setCallback(this, function(response) {
            component.set('v.Items',response.getReturnValue());
        });
        $A.enqueueAction(action);
    },
})