import { LightningElement, track, wire } from 'lwc';
import getAllItems from '@salesforce/apex/showItemController.getAllItems';
import { NavigationMixin } from 'lightning/navigation';
export default class ItemList extends NavigationMixin (LightningElement) {
    handleClick(event) {
        console.log(event.target.dataset.targetId);
        this[NavigationMixin.Navigate]({
            type: "standard__recordPage",
            attributes: {
                recordId: event.target.dataset.targetId,
                objectApiName: 'Item__c',
                actionName: 'edit'
            }
        });
    }
    //@wire(getAllItems) items;
    @wire(getAllItems)
    wiredAccounts({ error, data }) {
        console.log(data);
        if (data) {
            this.items = data;
        } else if (error) {
            console.log(error);
            //this.error = error;
        }
    }
    @track items;
}