trigger MaintenanceRequest on Case (before update) {

    if(trigger.isUpdate){
        List<Case> casesToCreateList = new List<Case>();
        for(Case updatedCase : trigger.new){
            Case oldCase = trigger.oldMap.get(updatedCase.Id);

            if((oldCase.status != updatedCase.status) && updatedCase.status == 'Closed'){
                casesToCreateList.add(new Case());
            }
        }

        insert casesToCreateList;
    }

}