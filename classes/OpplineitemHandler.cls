public class OpplineitemHandler {
    
    public static void countofoppitemsonAccount(List<OpportunityLineItem> opplineitemslist , Map<Id, OpportunityLineitem> oldopplineitemmap){

    	set<Id> oppIds = new set<Id>();
        Map<Id, Integer> countofoppli = new Map<Id,Integer>();
        lIST<Account> acclist = new List<Account>();
        
        for(OpportunityLineItem opli : opplineitemslist){
            if(opli.opportunityId != null && opli.Opportunity.AccountId != null){
                if(oldopplineitemmap != null){
                    OpportunityLineItem oldopli = oldopplineitemmap.get(opli.Id);
                    if(opli.opportunityId != oldopli.opportunityId && opli.Opportunity.AccountId != null){
                        oppIds.add(opli.opportunity.AccountId);
                        oppIds.add(oldopli.opportunity.AccountId);
                    }else{
                        oppIds.add(opli.opportunity.AccountId);
                    }
                }else{
                    oppIds.add(opli.opportunity.AccountId);
                }
                
            }
        }
        
        if(!oppIds.isempty()){
            List<AggregateResult> results = [select opportunity.AccountId accid , count(Id) oplicoumnt from OpportunityLineItem where opportunity.AccountId in: oppIds Group by opportunity.AccountId];
            
            if(!results.isempty()){
                for(AggregateResult agr : results){
                    Account ac = new Account();
                    ac.Id = (Id)agr.get('accid');
					ac.Number_of_opp_lineitems__c = (Decimal)agr.get('oplicoumnt');
                    acclist.add(ac);
                                      
                }
                if(!acclist.isempty()){
                    update acclist;
                }
            }
        }
    
    }

}