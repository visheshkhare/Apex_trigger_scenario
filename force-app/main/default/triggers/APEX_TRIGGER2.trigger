/*whenever Accounts phone field is updated then all contacts
phone field should also get updated with parent accounts phone*/
trigger APEX_TRIGGER2 on Account (after update) {
    
    Map<Id, Account> accmap = new Map<Id, Account>();
    if(trigger.isUpdate && trigger.isAfter){
        if(!trigger.new.isEmpty()){
            for(Account acc : trigger.new){
                if(trigger.oldMap.get(acc.Id).Phone != acc.Phone){
                    accmap.put(acc.Id, acc);
                }
                
                
                List<Contact> contoacc = [SELECT Id, AccountId, Phone FROM Contact WHERE AccountId IN : accmap.keySet()];
                List<Contact> updateli = new List<Contact>();
                if(!contoacc.isEmpty()){
                    for(Contact con: contoacc){                    
                    con.Phone = accmap.get(con.AccountId).Phone;
                    updateli.add(con);
                    }
                }
              if(!updateli.isEmpty()){
            update updateli;
        }  
            }
        }
        
    }
}