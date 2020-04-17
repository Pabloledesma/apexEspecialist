trigger MaintenanceRequest on Case (before update, before insert) {

    if(trigger.isInsert){
        for(Case newCase : trigger.new){
            newCase.Date_Reported__c = Date.today();
        }
    }
    
    if(trigger.isUpdate){
        MaintenanceRequestHelper.updateWorkOrders(Trigger.New);
    }

}