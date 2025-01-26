trigger amazAccountTrigger on Account (after update) {
    
    if(trigger.isafter && trigger.isupdate){
        AccountHandler.closerelatedopps(Trigger.new , trigger.oldmap);
    }

}