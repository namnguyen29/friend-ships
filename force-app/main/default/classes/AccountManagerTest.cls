@isTest
public with sharing class AccountManagerTest {
  @isTest
  static void testGetAccount() {
    Id recordId = createTestAccount();
    RestRequest request = new RestRequest();
    request.requestUri =
      'https://resourceful-koala-bsw72s-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Accounts/' +
      recordId +
      '/contacts';
    request.httpMethod = 'GET';
    RestContext.request = request;
    Account thisAccount = AccountManager.getAccount();
    Assert.areEqual('Nam Nam 13', thisAccount.Name);
  }

  public static Id createTestAccount() {
    Account testAccount = new Account(Name = 'Nam Nam 13');
    insert testAccount;
    return testAccount.Id;
  }
}
