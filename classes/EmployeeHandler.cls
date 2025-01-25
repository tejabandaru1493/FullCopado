public class EmployeeHandler {
    
    public static void getminandmax(List<Employee__c> emplist , MAp<Id , Employee__c> oldempmap){
        
        Set<Id> techfirmIds = new Set<Id>();
        List<Tech_firm__c> tflisttoupdate = new List<Tech_firm__c>();
        
        
        for(Employee__c emp : emplist){
            if(emp.Tech_firm__c != null){
                if(oldempmap != null){
                    Employee__c oldemp = oldempmap.get(emp.Id);
                    if(emp.Tech_firm__c != oldemp.Tech_firm__c){
                        techfirmIds.add(emp.Tech_firm__c);
                        techfirmIds.add(oldemp.Tech_firm__c);
                    }else{
                        techfirmIds.add(emp.Tech_firm__c);
                    }
                }else{
                    techfirmIds.add(emp.Tech_firm__c);
                }
            }
        }  
        if(!techfirmIds.isempty()){
            List<AggregateResult> results = [select Tech_firm__c techId , min(salary__c) minsal , max(salary__c) maxsal from Employee__c where Tech_firm__c IN :techfirmIds 
                                             Group By Tech_firm__c];
            
            if(!results.isempty()){
                for(AggregateResult agr : results){
                    Tech_firm__c tf = new Tech_firm__c();
                    tf.Id = (Id)agr.get('techId');
                    tf.Min_salary__c = (Decimal)agr.get('minsal');
                    tf.Max_salary__c = (Decimal)agr.get('maxsal');
                    tflisttoupdate.add(tf);
                    
                    
                }
                
                if(!tflisttoupdate.isempty()){
                    update tflisttoupdate;
                }
            }
        }
    }

}