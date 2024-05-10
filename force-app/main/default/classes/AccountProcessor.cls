public with sharing class AccountProcessor {
  @future
  public static void countContacts(List<Id> accountIds) {
    List<Account> accounts = [
      SELECT Id, (SELECT Id, AccountId FROM Contacts)
      FROM Account
      WHERE Id IN :accountIds
    ];
    for (Account acc : accounts) {
      List<Contact> testContacts = acc.Contacts;
      System.debug(LoggingLevel.WARN, testContacts);

      acc.Number_Of_Contacts__c = testContacts.size();
    }

    update accounts;
  }
}