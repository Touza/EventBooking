public  class ExternalSystemService {

    private static String webServiceURL = 'https://th-apex-http-callout.herokuapp.com/animals';

    @future(callout=true)
    public static void registerAttendees(String caseId){
        Case r = [select AccountId from Case where ID=:caseId limit 1];
            for(Account a : [SELECT id FROM Account where id = :r.AccountId]){
                for(Contact c : [SELECT id,name, email, AccountId FROM Contact where accountid =: a.id ]){
                     Http http = new Http();
                    HttpRequest request = new HttpRequest();
                        request.setEndpoint(ExternalSystemService.webServiceURL);
                    request.setMethod('POST');
                    request.setHeader('Content-Type', 'application/json;charset=UTF-8');
                    // Set the body as a JSON object
                    request.setBody('{"name":"'+ c.name + '-' + c.email  +'}');
                    HttpResponse response = http.send(request);
                    // Parse the JSON response
                    if (response.getStatusCode() != 201) {
                        System.debug('The status code returned was not expected: ' +
                        response.getStatusCode() + ' ' + response.getStatus());
                    } else {
                       // Everything went as expected.
                       ExternalSystemService.notifyAttendeeByEmail(c);
                    }
                }
            
        }
    } 

    public static void notifyAttendeeByEmail(Contact contact){
      
        Task tk = new Task();
        tk.Subject = 'Send Email To' + contact.name;
        tk.Status = 'Open';
        tk.Priority = 'Normal';
        tk.WhatId = contact.AccountId;
        insert tk;
    } 


}