@isTest
private class UpdateContactAddressesTest {
  @testSetup
  public static void setup() {
    List<Account> accounts = new List<Account>();
    List<Contact> contacts = new List<Contact>();

    for (Integer i = 0; i < 10; i++) {
      accounts.add(
        new Account(name = 'Account ' + i, billingcity = 'New York', billingcountry = 'USA')
      );
    }
    insert accounts;

    for (Account account : [SELECT id FROM account]) {
      contacts.add(new Contact(firstname = 'first', lastname = 'last', accountId = account.id));
    }
    insert contacts;
  }

  @isTest
  public static void test() {
    Test.startTest();
    UpdateContactAddresses uca = new UpdateContactAddresses();
    Id batchId = Database.executeBatch(uca);
    Test.stopTest();

    // after the testing stops, assert records were updated properly
    System.assertEquals(10, [SELECT COUNT() FROM contact WHERE MailingCity = 'New York']);
  }
}
