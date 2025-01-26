public class AccountHandler {
    
    public static void closerelatedopps(List<Account> acclist , Map<Id, Account> oldaccmap){
        
        Set<Id> accids = new set<Id>();
        List<Opportunity> opplist = new List<Opportunity> ();
        
        for(Account acc :  acclist){
            if(acc.Close_opportunities__c != oldaccmap.get(acc.Id).Close_opportunities__c && acc.Close_opportunities__c){
                accids.add(acc.Id);
            }
        }
        
        if(!accids.isempty()){
            List<Opportunity> opplistfetch = [SELECT Id, StageName, AccountId , closeDate
                                              FROM Opportunity 
                                              WHERE AccountId IN :accids 
                                              AND Probability >= 40 
                                              AND StageName != 'Closed Won'];
            if(!opplist.isempty()){
                for(Opportunity op : opplistfetch){
                    op.StageName = 'Closed Won';
                    op.closeDate = Date.Today();
                    opplist.add(op);
                }
                if(!opplist.isempty()){
                    update opplist;
                }
            }
        }
    }

}