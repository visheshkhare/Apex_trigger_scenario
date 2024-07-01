/* Trigger to create a related contact of account with same phone ad accounts phone if custom checkbox on account is checked*/ 
trigger APEX_TRIGGER6 on Account (after insert) {
    List<Contact> addto = new List<Contact>();
    for(Account acc : trigger.new){
        if(acc.Match_Billing_Address__c == true){
            Contact create = new Contact();

            create.Phone = acc.Phone;
            create.LastName = acc.Name;
            create.AccountId = acc.Id;
            addto.add(create);
        }
    }

    if(!addto.isEmpty()){
       
            insert addto;
        
    }
}