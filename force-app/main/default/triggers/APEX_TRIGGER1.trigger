trigger APEX_TRIGGER1 on Account (before insert, before update) {
    if(trigger.isbefore && (trigger.isInsert || trigger.isUpdate)){
        if(!trigger.new.isEmpty()){
            for(Account acc: trigger.new){
                if(acc.BillingStreet != null){
                    acc.ShippingStreet = acc.BillingStreet;
                }
                if(acc.BillingCity != null){
                    acc.ShippingCity = acc.BillingCity;
                }
                if(acc.BillingPostalCode != null){
                    acc.ShippingPostalCode = acc.BillingPostalCode;
                }
                if(acc.BillingCountry != null){
                    acc.ShippingCountry = acc.BillingCountry;
                }
                if(acc.BillingState != null){
                    acc.ShippingState = acc.BillingState;
                }
            }
        }
    }
}