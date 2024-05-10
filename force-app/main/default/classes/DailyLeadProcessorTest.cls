@isTest
public with sharing class DailyLeadProcessorTest {
  public static String CRON_EXP = '0 0 0 15 3 ? 2042';

  @isTest
  public static void dailyLeadProcessorTest() {
    Integer numberOfLeads = 200;
    List<Lead> testLeads = new List<Lead>();
    for (Integer index = 0; index < numberOfLeads; index++) {
      testLeads.add(
        new Lead(LeadSource = '', Company = 'Test CMP' + index, LastName = 'LastName' + index)
      );
    }
    insert testLeads;

    // execute
    Test.startTest();
    String jobId = System.schedule('DailyLeadProcessorTest', CRON_EXP, new DailyLeadProcessor());
    Test.stopTest();

    // verify
    List<Lead> verifyLeads = [SELECT Name, LeadSource FROM Lead LIMIT 200];
    for (Lead lead : verifyLeads) {
      System.assertEquals('Dreamforce', lead.LeadSource);
    }
  }
}