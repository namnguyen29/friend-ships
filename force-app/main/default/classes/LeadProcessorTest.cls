@isTest
public with sharing class LeadProcessorTest {
  @TestSetup
  static void setupData() {
    List<Lead> mockLeads = new List<Lead>();
    Integer numberOfLeads = 200;

    for (Integer index = 0; index < numberOfLeads; index++) {
      Lead targetLead = new Lead(Company = 'cmp::' + index, LastName = 'Test::' + index);
      mockLeads.add(targetLead);
    }

    insert mockLeads;
  }

  @isTest
  public static void test() {
    Test.startTest();
    LeadProcessor processor = new LeadProcessor();
    Database.executeBatch(processor);
    Test.stopTest();

    Lead verifyLead = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = 'Dreamforce' LIMIT 1];
    System.assertEquals('Dreamforce', verifyLead.LeadSource);
  }
}