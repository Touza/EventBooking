@isTest
public class EventBookingTest {  
    
    @isTest
    public static void refuseCaseCreationWhenAnAccountIsNotAttachedToACase(){
        // Given
        
        Case request =  (Case) TestDataFactory.createSObject('Case', new Map<String,Object> {
            'Origin' => 'Phone',
                'Subject' => 'Event Booking',
                'Description' => 'Book Spots'}, false);
            
            // When 
            
        Test.startTest();
        
        Database.SaveResult result = Database.insert(request, false);
        
        Test.stopTest();
        
        // Then
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('You cannot create a request without attaching an account',
                            result.getErrors()[0].getMessage());
    }
    
    @isTest
    public static void refuseCaseCreationWhenNoContactIsAttachedToAnAccount(){
        // Given
        
        Account a1 = (Account) TestDataFactory.createSObject('Account', new Map<String,Object> {
            'Name'=> 'Salesforce'}, true);
        
        Case request = (Case) TestDataFactory.createSObject('Case', new Map<String,Object> {
            'Origin'=>'Phone',
                'Subject'=>'Event Booking',
                'Description' => 'Book Spots',
                'Account' => a1}, false);        
        // When 
        
        Test.startTest();
        
        Database.SaveResult result = Database.insert(request, false);
        
        Test.stopTest();
        
        // Then
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('You cannot create a request for accounts without contacts',
                            result.getErrors()[0].getMessage());
    }
    
    @isTest
    public static void bookEventFromPhone(){
        // Given
        
        Account a1 = (Account) TestDataFactory.createSObject('Account', new Map<String,Object> {
            'Name'=> 'Salesforce'}, true);
        
        Contact c1 = (Contact) TestDataFactory.createSObject('Contact', new Map<String,Object> {
            'LastName'=> 'Contact 1',
                'Account'=> a1}, true);
        
        Contact c2 = (Contact) TestDataFactory.createSObject('Contact', new Map<String,Object> {
            'LastName'=> 'Contact 2',
                'Account'=> a1}, true);
        
        Contact c3 = (Contact) TestDataFactory.createSObject('Contact', new Map<String,Object> {
            'LastName'=> 'Contact 3',
                'Account'=> a1}, true);
        
        Case request = (Case) TestDataFactory.createSObject('Case', new Map<String, Object> {
            'Origin' => 'Phone',
                'Subject' => 'Event Booking',
                'Description' => 'Book Spots for Company A1 & their 3 employees',
                'Account' => a1}, false);
         
        // When 
        
        Test.startTest();
        
        Database.SaveResult result = Database.insert(request, false);
        Test.stopTest();
        
        // Then
        
        System.assert(result.isSuccess());
        
        
    }
    
    
    @isTest
    public static void refuseEventBookingWhenNumberOfAttendeesIsMoreThanThreeForPhoneCases(){
        // Given
        
        Account a1 = (Account) TestDataFactory.createSObject('Account', new Map<String,Object> {
            'Name'=> 'Salesforce'}, true);
        
        Contact c1 = (Contact) TestDataFactory.createSObject('Contact', new Map<String,Object> {
            'LastName'=> 'Contact 1',
                'Account'=> a1}, true);
        
        Contact c2 = (Contact) TestDataFactory.createSObject('Contact', new Map<String,Object> {
            'LastName'=> 'Contact 2',
                'Account'=> a1}, true);
        
        Contact c3 = (Contact) TestDataFactory.createSObject('Contact', new Map<String,Object> {
            'LastName'=> 'Contact 3',
                'Account'=> a1}, true);
        
        Contact c4 =  (Contact) TestDataFactory.createSObject('Contact', new Map<String,Object> {
            'LastName'=> 'Contact 4',
                'Account'=> a1}, true);
        
        Case request = (Case) TestDataFactory.createSObject('Case', new Map<String, Object>{
            'Origin' => 'Phone',
                'Subject' => 'Event Booking',
                'Description' => 'Book Spots for Company A1 & their 4 employees',
                'Account' => a1}, false);
        
        // When 
        
        Test.startTest();
        
        Database.SaveResult result = Database.insert(request, false);
        
        Test.stopTest();
        
        // Then
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Phone request are only allowed to have three attendee',
                            result.getErrors()[0].getMessage());
        
    }
    
    @isTest
    public static void bookEventFromTheWeb(){
        // Given
        
        Account a1 = (Account) TestDataFactory.createSObject('Account', new Map<String,Object> {
            'Name'=> 'Salesforce'}, true);
        
        Contact c1 = (Contact) TestDataFactory.createSObject('Contact', new Map<String,Object> {
            'LastName'=> 'Contact 1',
                'Account'=> a1}, true);
        
        Case request = (Case) TestDataFactory.createSObject('Case', new Map<String, Object>{
            'Origin' => 'Phone',
                'Subject' => 'Event Booking',
                'Description' => 'Book Spots for Company A1',
                'Account' => a1}, false);
        // When 
        
        Test.startTest();
        
        Database.SaveResult result = Database.insert(request, false);
        
        Test.stopTest();
        
        // Then
        
        System.assert(result.isSuccess());
        
        
    } 
    
    @isTest
    public static void refuseEventBookingWhenNumberOfAttendeesIsMoreThanOneForWebCases(){
        // Given
        
        Account a1 = (Account) TestDataFactory.createSObject('Account', new Map<String,Object> {
            'Name'=> 'Salesforce'}, true);
        
        Contact c1 = (Contact) TestDataFactory.createSObject('Contact', new Map<String,Object> {
            'LastName'=> 'Contact 1',
                'Account'=> a1}, true);
        
        Contact c2 = (Contact) TestDataFactory.createSObject('Contact', new Map<String,Object> {
            'LastName'=> 'Contact 2',
                'Account'=> a1}, true);
        
        Contact c3 = (Contact) TestDataFactory.createSObject('Contact', new Map<String,Object> {
            'LastName'=> 'Contact 3',
                'Account'=> a1}, true);
        
        Case request = (Case) TestDataFactory.createSObject('Case', new Map<String, Object> {
            'Origin' => 'Web',
                'Subject' => 'Event Booking',
                'Description' => 'Book Spots for Company A1 & their 3 employees',
                'Account' => a1}, false);
                
        // When 
        
        Test.startTest();
        
        Database.SaveResult result = Database.insert(request, false);
        
        Test.stopTest();
        
        // Then
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Web request are only allowed to have one attendee',
                            result.getErrors()[0].getMessage());
        
    } 
    
    
    @isTest
    public static void updateCaseAfterInsertion() {
        // Given
        
        Account a1 = (Account) TestDataFactory.createSObject('Account', new Map<String,Object> {
            'Name'=> 'Salesforce'}, true);
        
        Contact c1 = (Contact) TestDataFactory.createSObject('Contact', new Map<String,Object> {
            'LastName'=> 'Contact 1',
                'Account'=> a1}, true);
        
        Case request = (Case) TestDataFactory.createSObject('Case', new Map<String, Object>{
            'Origin' => 'Phone',
                'Subject' => 'Event Booking',
                'Description' => 'Book Spots for Company A1',
                'Status' => 'Closed',
                'Account' => a1}, true);
        
        request.Status = 'Closed';
        system.debug('inside test ');
        system.debug(request.Status);
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('RegisterAttendees');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        // Call method to test
        // When 
        
        Test.startTest();
        
        Database.SaveResult result = Database.update(request, false);
        
        Test.stopTest();
        
        // Then
        
        System.assert(result.isSuccess());

    }
    
    
    @isTest
    public static void registerAttendeesTest() {
        // Given
        
        Account a1 = (Account) TestDataFactory.createSObject('Account', new Map<String,Object> {
            'Name'=> 'Salesforce'}, true);
        
        Contact c1 = (Contact) TestDataFactory.createSObject('Contact', new Map<String,Object> {
            'LastName'=> 'Contact 1',
                'Account'=> a1}, true);
        
        Case request = (Case) TestDataFactory.createSObject('Case', new Map<String, Object>{
            'Origin' => 'Phone',
                'Subject' => 'Event Booking',
                'Description' => 'Book Spots for Company A1',
                'Status' => 'Closed',
                'Account' => a1}, true);
        
        request.Status = 'Closed';
        system.debug('inside test ');
        system.debug(request.Status);
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('RegisterAttendees');
        mock.setStatusCode(201);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        // Call method to test
        // When 
        
        Test.startTest();
        
        Database.SaveResult result = Database.update(request, false);
        
        Test.stopTest();
        
        // Then
        
        System.assert(result.isSuccess());

    }
    
    
}