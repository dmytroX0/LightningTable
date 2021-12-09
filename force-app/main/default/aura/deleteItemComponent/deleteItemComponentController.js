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
          newPopup : function(component, event, helper){
        var cmpTarget = component.find('Modalbox1');
        var cmpBack = component.find('Modalbackdrop');
        $A.util.addClass(cmpTarget, 'slds-fade-in-open');
        $A.util.addClass(cmpBack, 'slds-backdrop--open');
    },
            inlineEditDescription : function(component,event,helper){   
        component.set("v.EditName", true); 
        setTimeout(function(){ 
            component.find("Nameinput").focus();
        }, 100);
    },
    
    saveModal : function(component, event, helper){
        var regForm = component.get('v.itm');
        var action = component.get("c.createItem");
        action.setParams({regForm1  : regForm});
        action.setCallback(this, function(response) {
            var state = response.getState();          
            if (state === "SUCCESS") {
                $A.get('e.force:refreshView').fire();
                var cmpTarget = component.find('Modalbox1');
                var cmpBack = component.find('Modalbackdrop');
                $A.util.removeClass(cmpBack,'slds-backdrop--open');
                $A.util.removeClass(cmpTarget, 'slds-fade-in-open');
                
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                    errors[0].message);
                    }
                } 
                else {
                    console.log(response.getReturnValue());
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    closeNewModal : function(component, event, helper){
        var cmpTarget = component.find('Modalbox1');
        var cmpBack = component.find('Modalbackdrop');
        $A.util.removeClass(cmpBack,'slds-backdrop--open');
        $A.util.removeClass(cmpTarget, 'slds-fade-in-open');
    },
        deleteRecord : function(component, event, helper) {
            if(confirm('Are you sure?'))
                helper.deleteOpportunity(component, event);
        }
    }
)