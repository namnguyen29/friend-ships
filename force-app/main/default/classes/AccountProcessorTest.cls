@isTest
public with sharing class AccountProcessorTest {
  @isTest
  public static void testAccountProcessor() {
    Account testAcc = new Account();
    testAcc.Name = 'T Account';
    insert testAcc;

    Contact testCtc = new Contact();
    testCtc.FirstName = 'Demo';
    testCtc.LastName = 'Nam';
    testCtc.AccountId = testAcc.Id;
    insert testCtc;

    List<Id> idList = new List<Id>();
    idList.add(testAcc.Id);

    Test.startTest();
    AccountProcessor.countContacts(idList);
    Test.stopTest();

    Account verifyAccount = [
      SELECT Id, Number_Of_Contacts__c
      FROM Account
      WHERE Id = :testAcc.Id
      LIMIT 1
    ];
    System.assertEquals(verifyAccount.Number_Of_Contacts__c, 1);
  }
}