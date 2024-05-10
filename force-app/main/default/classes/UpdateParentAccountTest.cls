@isTest
public class UpdateParentAccountTest {
  @testSetup
  static void setup() {
    List<Account> accounts = new List<Account>();
    // add a parent account
    accounts.add(new Account(name = 'Parent'));
    // add 100 child accounts
    for (Integer i = 0; i < 100; i++) {
      accounts.add(new Account(name = 'Test Account' + i));
    }
    insert accounts;
  }

  static testMethod void testQueueable() {
    // query for test data to pass to queueable class
    Id parentId = [SELECT id FROM account WHERE name = 'Parent'][0].Id;
    List<Account> accounts = [SELECT id, name FROM account WHERE name LIKE 'Test Account%'];
    // Create our Queueable instance
    UpdateParentAccount updater = new UpdateParentAccount(accounts, parentId);
    // startTest/stopTest block to force async processes to run
    Test.startTest();
    System.enqueueJob(updater);
    Test.stopTest();
    // Validate the job ran. Check if record have correct parentId now
    System.assertEquals(100, [SELECT COUNT() FROM account WHERE parentId = :parentId]);
  }
}
