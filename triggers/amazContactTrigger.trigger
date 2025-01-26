trigger amazContactTrigger on Contact (before insert , before update) {
    
    if(trigger.isbefore && (trigger.isinsert || trigger.isundelete)){
        ContactHandler.primaryContact(trigger.new , null);
	}
    
     if(trigger.isbefore && trigger.isupdate){
        ContactHandler.primaryContact(trigger.new , trigger.oldmap);
	}

}