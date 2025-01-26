trigger amazOppLineItemsTrigger on OpportunityLineItem (after insert , after update , after undelete , after delete) {
    
    if(trigger.isafter && (trigger.isinsert || trigger.isundelete)){
        OpplineitemHandler.countofoppitemsonAccount(Trigger.new , null);
    }
    
    if(trigger.isafter && trigger.isdelete){
        OpplineitemHandler.countofoppitemsonAccount(Trigger.old , null);
    }
    
    if(trigger.isafter && trigger.isupdate){
        OpplineitemHandler.countofoppitemsonAccount(Trigger.new , trigger.oldmap);
    }

}