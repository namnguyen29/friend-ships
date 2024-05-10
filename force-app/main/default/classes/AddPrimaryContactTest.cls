@isTest
public with sharing class AddPrimaryContactTest {
  @TestSetup
  static void makeData() {
    Integer numberOfAccounts = 100;
    List<Account> accounts = new List<Account>();
    for (Integer i = 0; i < 100; i++) {
      if (i < 50) {
        accounts.add(new Account(Name = 'Test' + i, BillingState = 'NY'));
      }
      accounts.add(new Account(Name = 'Test' + i, BillingState = 'CA'));
    }

    insert accounts;
  }

  @IsTest
  static void testAddPrimaryContact() {
    List<Account> verifyAccounts = [
      SELECT Id, BillingState
      FROM Account
      WHERE BillingState = 'CA'
      LIMIT 50
    ];
    Contact contact = new Contact(LastName = 'My Clone');

    Test.startTest();
    AddPrimaryContact updater = new AddPrimaryContact(contact, 'CA');
    System.enqueueJob(updater);
    Test.stopTest();

    for (Account acc : verifyAccounts) {
      System.assertEquals('CA', acc.BillingState, 'WRONG - TRY AGAIN');
    }
  }
}