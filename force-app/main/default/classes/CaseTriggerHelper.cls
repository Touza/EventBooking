public class CaseTriggerHelper {
    
    public static void checkBeforeAddNewCase(List<Case> cases) {
        // WE GET THE CASE FIRST 
    Case r = cases[0];
    
    // Testing if the content of case is null or not to avoid NPE ;) 
    if(r != null && r.AccountId != null){

        Account account =  [SELECT ID, (select id from contacts) FROM Account where id = :r.AccountId LIMIT 1];

        Integer s = account.Contacts.size();

        if(s ==0){
            r.addError('You cannot create a request for accounts without contacts');
        }   else {
            switch on r.Origin {
                when 'Web' {
                    if(s >= 2 ){
                        r.addError('Web request are only allowed to have one attendee');
                    }
                }
                when 'Phone'{
                    if(s >= 4 ){
                        r.addError('Phone request are only allowed to have three attendee');
                    }
                }
            }    
                        
        }

    }else {
        r.addError('You cannot create a request without attaching an account');
    }
    }

    public static void registerAttendees(List<Case> cases) {
        Boolean requestSentToExternalSystem = false;
        Integer i=0;
        
        Case request = cases[0];

        Case r = [SELECT AccountId, Status FROM Case where id=:request.ID];
        if(r.Status == 'Closed'){
            ExternalSystemService.registerAttendees(request.ID);
        }
    }

}