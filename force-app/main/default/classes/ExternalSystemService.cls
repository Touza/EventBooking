public  class ExternalSystemService {

    public void registerAttendees(Case handledCase){
        if(!Schema.sObjectType.Account.isQueryable()){
            return;
        }
        List<Account> accounts = [SELECT id FROM Account where id = :handledCase.AccountId];
        Set<Id> accountIdsSet = (new Map<Id,SObject>(accounts)).keySet();
        ExternalSystemCallout.makeCallout(accountIdsSet, handledCase.Id);
    } 

}