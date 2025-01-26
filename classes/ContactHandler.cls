public class ContactHandler {
    
    public static void primaryContact(List<Contact> conlist , Map< Id , Contact> oldconmap){
        set<Id> accids = new Set<Id>();
        Map<Id, Integer> primaryconlist = new Map<Id, Integer>();
        
        for(Contact con : conlist){
            if(con.AccountId != null){
                if(oldconmap != null){
                    Contact oldcon = oldconmap.get(con.Id);
                    if(con.AccountId != oldcon.AccountId){
                        accids.add(con.AccountId);
                        accids.add(oldcon.AccountId);   
                    }else{
                        accids.add(con.AccountId);
                    }
                }else{
                    accids.add(con.AccountId);
                }
            }
        }
        
        if(!accids.isempty()){
            List<Account> acclistfetch = [select id , (select id from contacts where Primary_Contact__c = true limit 1) from Account where id in : accids];
            if(!acclistfetch.isempty()){
                for(Account ac : acclistfetch){
                	primaryconlist.put(ac.Id, ac.contacts.size());
            	}
                for(Contact con : conlist){
                    if(con.Primary_Contact__c == true && primaryconlist.containskey(con.AccountId) && primaryconlist.get(con.AccountId) > 0){
                        con.adderror('An account cant have more than 1 primary contact.This account already ahs primary contact.');
                    }
                }
            }
            
        }
    }

}

/*
public class ContactHandler {
    
    public static void primaryContact(List<Contact> conlist , Map<Id, Contact> oldconmap){
        Set<Id> accids = new Set<Id>();
        Map<Id, Boolean> primaryconlist = new Map<Id, Boolean>();
        
        // Identify unique account IDs associated with the contacts
        for(Contact con : conlist){
            if(con.AccountId != null){
                if(oldconmap != null){
                    Contact oldcon = oldconmap.get(con.Id);
                    // Track account changes if the AccountId has been modified
                    if(con.AccountId != oldcon.AccountId){
                        accids.add(con.AccountId);
                        accids.add(oldcon.AccountId);   
                    } else {
                        accids.add(con.AccountId);
                    }
                } else {
                    accids.add(con.AccountId);
                }
            }
        }
        
        if(!accids.isEmpty()){
            // Fetch accounts that have at least one primary contact
            List<Account> acclistfetch = [
                SELECT Id, (SELECT Id FROM Contacts WHERE Primary_Contact__c = true LIMIT 1) 
                FROM Account 
                WHERE Id IN :accids
            ];
            
            if(!acclistfetch.isEmpty()){
                for(Account ac : acclistfetch){
                    // Mark accounts that already have a primary contact
                    primaryconlist.put(ac.Id, !ac.Contacts.isEmpty());
                }

                // Check if any contact is trying to set another primary contact for the same account
                for(Contact con : conlist){
                    if(con.Primary_Contact__c && primaryconlist.containsKey(con.AccountId) && primaryconlist.get(con.AccountId)){
                        con.addError('An account can only have one primary contact. This account already has a primary contact.');
                    }
                }
            }
        }
    }
}

*/