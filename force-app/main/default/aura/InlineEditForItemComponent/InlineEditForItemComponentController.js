({
    myAction : function(component, event, helper) 
    { 
        component.set('v.columns', [
            {label: 'Name', fieldName: 'Name', type: 'text' ,  editable: true},
            {label: 'Price', fieldName: 'Price__c', type: 'Currency' ,  editable: true},
            {label: 'Opportunity', fieldName: 'Opportunity__r.Name', type: 'text' ,  editable: true},
            {label: 'Quantity', fieldName: 'Quantity__c', type: 'Number' ,  editable: true}
        ]);
        
        var itmList = component.get('c.getRelatedList');
        itmList.setParams
        ({
            recordId: component.get("v.recordId")
        });
        
        itmList.setCallback(this, function(data) 
                            {
                                component.set("v.ItemList", data.getReturnValue());
                            });
        $A.enqueueAction(itmList);
    },
    showOpportunity : function(component, event, helper) {
        var action = component.get('c.fetchOpportunityInfo');
        // Set up the callback
        var self = this;
        action.setCallback(this, function(actionResult) {
            component.set('v.oppOption', actionResult.getReturnValue());
        });
        $A.enqueueAction(action);
    },
    
    SaveUpdatedItems : function(component,event,helper) 
    {
        var UpdatedList = event.getParam('draftValues');        
        var UpdateItems = component.get("c.updateRelatedList");
        
        UpdateItems.setParams
        ({
            itmlist : UpdatedList
        });
        UpdateItems.setCallback(this, function(response) 
                                {
                                    var state = response.getState();
                                    if (state === 'SUCCESS')
                                    {
                                        $A.enqueueAction(component.get('c.myAction'));
                                        $A.get('e.force:refreshView').fire();
                                    }
                                    else{
                                        
                                    }
                                });
        $A.enqueueAction(UpdateItems);
    }
})