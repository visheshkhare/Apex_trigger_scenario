/*whenever a contacts description is updated then its parent accounts
description should also updated by it*/
trigger APEX_TRIGGER3 on Contact (after update) {
    
    if(trigger.isAfter && trigger.isUpdate){
        set<Id> accid = new set<Id>();
        if(!trigger.new.isEmpty()){
            for(Contact con : trigger.new){
                if(con.AccountId != null && trigger.oldMap.get(con.id).Description != con.Description ){
                    accid.add(con.AccountId);
                }
            }       
            
            Map<Id, Account> accdes = new Map<Id, Account>([SELECT Id,Description FROM Account WHERE Id IN : accid]);
            List<Account> newup = new List<Account>();
            for(Contact cont: trigger.new ){
                Account acc = accdes.get(cont.AccountId);
                acc.Description = cont.Description;
                newup.add(acc);
            }
            if(!newup.isEmpty()){
            update newup;
        }
        
        }
        
        
    }

}