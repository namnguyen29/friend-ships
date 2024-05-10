@isTest
public with sharing class AccountTriggerTest {
  @isTest
  public static void testInsertRecords() {
    List<Account> testAccounts = new List<Account>();
    Integer accountsLimit = 200;
    for (Integer index = 0; index < accountsLimit; index++) {
      Account account = new Account(Name = 'Test acc' + index, BillingState = 'CA');
      testAccounts.add(account);
    }

    Test.startTest();
    if (testAccounts.size() > 0) {
      insert testAccounts;
    }
    Test.stopTest();

    List<Account> verifyAccounts = [SELECT Id, ShippingState, BillingState FROM Account];
    for (Account account : verifyAccounts) {
      System.assertEquals('CA', account.ShippingState, 'WRONG');
    }
  }
}