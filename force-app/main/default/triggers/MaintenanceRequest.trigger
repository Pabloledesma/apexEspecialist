trigger MaintenanceRequest on Case (before update, before insert) {

    if(trigger.isInsert){
        for(Case newCase : trigger.new){
            newCase.Date_Reported__c = Date.today();
        }
    }
    
    if(trigger.isUpdate){
        List<Case> casesToCreateList = new List<Case>();
        for(Case updatedCase : trigger.new){
            Case oldCase = trigger.oldMap.get(updatedCase.Id);

            if((oldCase.status != updatedCase.status) && updatedCase.status == 'Closed'){
                casesToCreateList.add(
                    new Case(
                        Vehicle__c = updatedCase.Vehicle__c,
                        Equipment__c = updatedCase.Equipment__c,
                        Subject = updatedCase.Subject
                    )
                );
            }
        }

        insert casesToCreateList;
    }

}