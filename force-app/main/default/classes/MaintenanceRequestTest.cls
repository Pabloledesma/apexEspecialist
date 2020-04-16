@isTest
private class MaintenanceRequestTest {

    @isTest
    static void create_a_new_request_when_the_current_one_is_closed() {
        Case newCase = new Case(Subject = 'subject');
        insert newCase;
        System.assertNotEquals(null, newCase.Id, 'The case was not created');

        System.assertEquals(
            1,
            [SELECT count() FROM Case],
            'The number of cases was not correct'
        );

        newCase.Status = 'Closed';
        
        Test.startTest();
        update newCase;
        Test.stopTest();

        System.assertEquals(
            2,
            [SELECT count() FROM Case],
            'The number of cases was not correct'
        );
    }

    @IsTest
    static void the_subject_should_not_be_null(){
        
        Case newCase = new Case();
        Test.startTest();
        try {
            insert newCase;
        } catch (System.DmlException e){
            System.assertEquals(true, e.getMessage().contains('The subject should not be null'));
        }
        Test.stopTest();
        
    }

    @IsTest
    static void the_new_case_is_tied_to_the_same_vehicle(){
        
        Vehicle__c vehicle = new Vehicle__c();
        insert vehicle;
        System.assertNotEquals(null, vehicle.Id, 'The vehicle was not created');
        
        Case newCase = new Case(Subject = 'subject');
        newCase.Vehicle__c = vehicle.Id;
        insert newCase;
        System.assertNotEquals(null, newCase.Id, 'The case was not created');

        System.assertEquals(
            1,
            [SELECT count() FROM Case],
            'The number of cases was not correct'
        );

        newCase.Status = 'Closed';
        
        Test.startTest();
        update newCase;
        Test.stopTest();

        System.assertEquals(
            2,
            [SELECT count() FROM Case where Vehicle__c =: vehicle.Id],
            'The number of cases was not correct'
        );
        
    }

    @IsTest
    static void the_new_request_is_tied_to_the_same_equipment(){
        
        Product2 equipment = new Product2(Name = 'Test equipment');
        insert equipment;
        System.assertNotEquals(null, equipment.Id, 'The equipment was not created');
        
        Case newCase = new Case(Subject = 'subject');
        newCase.Equipment__c = equipment.Id;
        insert newCase;
        System.assertNotEquals(null, newCase.Id, 'The case was not created');

        System.assertEquals(
            1,
            [SELECT count() FROM Case],
            'The number of cases was not correct'
        );

        newCase.Status = 'Closed';
        
        Test.startTest();
        update newCase;
        Test.stopTest();

        System.assertEquals(
            2,
            [SELECT count() FROM Case where Equipment__c =: equipment.Id],
            'The number of cases was not correct'
        );
        
    }

    @IsTest
    static void the_new_requests_type_should_be_set_as_routine_maintenance(){
        
        Case newCase = new Case(Subject = 'subject');
        insert newCase;
        System.assertNotEquals(null, newCase.Id, 'The case was not created');

        System.assertEquals(
            1,
            [SELECT count() FROM Case],
            'The number of cases was not correct'
        );

        newCase.Status = 'Closed';
        
        Test.startTest();
        update newCase;
        Test.stopTest();

        Id routineMaintenanceRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Routine Maintenance').getRecordTypeId();
        System.assertNotEquals(null, routineMaintenanceRecordTypeId, 'The record type Routine Maintenance does not exists');

        System.assertEquals(
            2,
            [SELECT count() FROM Case where RecordTypeId =: routineMaintenanceRecordTypeId],
            'The number of cases was not correct'
        );
    }

    @IsTest
    static void the_day_reported_field_reflects_the_day_the_request_was_created(){
        
        Case newCase = new Case(Subject = 'subject');
        
        Test.startTest();
        insert newCase;
        Test.stopTest();
        
        System.assertNotEquals(null, newCase.Id, 'The case was not created');
        
        Case caseCreated = [SELECT Date_Reported__c FROM Case];

        System.assertNotEquals(
            null, 
            caseCreated.Date_Reported__c,
            'The date reported is null'    
        );

        System.assertEquals(
            Date.today(), 
            caseCreated.Date_Reported__c, 
            'The date is not correct'
        );
    }

    @IsTest
    static void the_service_date_has_the_shortest_maintenance_cycle(){
        
        Test.startTest();
       
        Test.stopTest();
        
    }
 
}