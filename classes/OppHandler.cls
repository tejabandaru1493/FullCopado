public class OppHandler {
    
    public static void maxOppnameOnAccount(List<Opportunity> opplist , Map<Id ,Opportunity> oldmapopp){
        
        Set<Id> accidsIds = new Set<Id>();
        List<Account> acclisttoupdate = new List<Account>();
        
        
        for(Opportunity opp : opplist){
            if(opp.AccountId != null){
                if(oldmapopp != null){
                    opportunity oldopp = oldmapopp.get(opp.Id);
                    if(opp.AccountId  != oldopp.AccountId ){
                        accidsIds.add(opp.AccountId);
                        accidsIds.add(oldopp.AccountId);
                    }else{
                        accidsIds.add(opp.AccountId);
                    }
                }else{
                    accidsIds.add(opp.AccountId);
                }
            }
        }  
        if(!accidsIds.isempty()){
            List<AggregateResult> results = [select AccountId acid , max(amount) maxamount from Opportunity where accountId in : accidsIds
                                            Group By AccountId];
            
            if(!results.isempty()){
                for(AggregateResult agr : results){
                    Account ac = new Account();
                    ac.Id = (Id)agr.get('acid');
                    ac.Max_opp_amount__c = (Decimal)agr.get('maxamount');
					acclisttoupdate.add(ac);
                }
            }
            
            /*List<Account> acclist = [select id, Max_Opp_Name__c ,(select id, name , accountid from opportunities order by amount desc limit 1) from Account
                                    where id in : accidsIds];
            
            if(!acclist.isempty()){
                for(Account acc : acclist){
                    if(acc.opportunities.size() > 0){
                        acc.Max_Opp_Name__c = acc.opportunities[0].Name;
                        acclisttoupdate.add(acc);
                    }else{
                        acc.Max_Opp_Name__c = '';
                        acclisttoupdate.add(acc);
                    }
                }*/
                if(!acclisttoupdate.isempty()){
                    update acclisttoupdate;
                }

}
        }
    }