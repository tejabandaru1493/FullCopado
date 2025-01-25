trigger amazonPracOppTrigger on Opportunity (after insert , after update , after delete , after undelete) {
    
    if(trigger.isafter && (trigger.isinsert || trigger.isundelete)){
        OppHandler.maxOppnameOnAccount(trigger.new , null);
	}
    
     if(trigger.isafter && trigger.isdelete){
        OppHandler.maxOppnameOnAccount(trigger.old , null);
	}
    
     if(trigger.isafter && trigger.isupdate){
        OppHandler.maxOppnameOnAccount(trigger.new , trigger.oldmap);
	}
}