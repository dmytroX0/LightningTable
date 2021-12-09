global class DeleteRecordsJob implements Database.Batchable<sobject>
{
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator([SELECT Id FROM Lead WHERE Rating = 'Cold' ALL ROWS]);
    }
    
    global void execute(Database.BatchableContext BC, List<SObject> lstRecords)
    {
        
        Database.DeleteResult[] result = Database.delete(lstRecords, false);
        
    }
    global void finish(Database.BatchableContext BC) 
    {
        AsyncApexJob apexJob = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email
                                FROM AsyncApexJob WHERE Id =: BC.getJobId()];
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddress = new String[] {apexJob.CreatedBy.Email};
            system.debug('apexJob.CreatedBy.Email : '+apexJob.CreatedBy.Email);
        mail.setToAddresses(toAddress);
        mail.setSubject('Apex Job status is ' + apexJob.Status);
        mail.setPlainTextBody('The batch Apex job processed ' + apexJob.TotalJobItems + ' batches with '+ apexJob.NumberOfErrors + ' failures.');
         Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}