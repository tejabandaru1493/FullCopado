trigger manazonprac on Employee__c (after insert , after update , after delete , after undelete) {
    
    if(trigger.isafter && (trigger.isinsert || trigger.isundelete)){
        EmployeeHandler.getminandmax(trigger.new , null);
	}
    
     if(trigger.isafter && trigger.isdelete){
        EmployeeHandler.getminandmax(trigger.old , null);
	}
    
     if(trigger.isafter && trigger.isupdate){
        EmployeeHandler.getminandmax(trigger.new , trigger.oldmap);
	}

}