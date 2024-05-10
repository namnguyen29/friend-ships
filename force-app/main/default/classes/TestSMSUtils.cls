@IsTest
private class TestSMSUtils {
  @IsTest
  private static void testSendSms() {
    Test.setMock(HttpCalloutMock.class, new SMSCalloutMock());
    Test.startTest();
    SMSUtils.sendSMSAsync('111', '222', 'Greetings!');
    Test.stopTest();

    List<SMS_Log__c> logs = [SELECT msg__c FROM SMS_Log__c];
    System.assertEquals(1, logs.size());
    System.assertEquals('success', logs[0].msg__c);
  }
}
