trigger APEX_TRIGGER5 on Account (before insert, before update) {
    Set<String> accNames = new Set<String>();

    for (Account acc : trigger.new) {
        accNames.add(acc.Name);
    }

    if (!accNames.isEmpty()) {
        List<Account> accDetail = [SELECT Id, Name, Phone FROM Account WHERE Name IN :accNames];

        Map<String, Account> accMap = new Map<String, Account>();

        for (Account acc : accDetail) {
            accMap.put(acc.Name, acc);
        }

        for (Account accMatch : trigger.new) {
            if (accMap.containsKey(accMatch.Name)) {
                accMatch.addError('An account with this name already exists.');
            }
        }
    }
}