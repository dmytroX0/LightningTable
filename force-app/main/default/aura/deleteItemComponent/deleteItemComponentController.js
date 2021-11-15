(
    {
        OnLoadRecord : function(component, event, helper) {
            helper.ItemList(component, event);
        },
        doInit : function(component, event, helper) {
            var Opportunity = component.get('c.Opportunity');
        },
        submitfunction : function(component, event, helper) {
            var itm = component.get('v.itm');
            var a = component.get('c.createItem');
            a.setParams({'it':itm});
            a.setCallback(this,function(r){
                component.set('v.itm',r.getReturnValue());
            });
            $A.enqueueAction(a);
        },    
        deleteRecord : function(component, event, helper) {
            if(confirm('Are you sure?'))
                helper.deleteOpportunity(component, event);
        }
    }
)