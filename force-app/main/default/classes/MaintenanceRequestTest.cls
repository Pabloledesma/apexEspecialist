@isTest
private class MaintenanceRequestTest {

    @isTest
    static void create_a_new_case_when_the_current_one_is_closed() {
        Case newCase = new Case();
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
}