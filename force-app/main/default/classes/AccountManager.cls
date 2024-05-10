@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
  @HttpGet
  global static Account getAccount() {
    RestRequest request = RestContext.request;
    String caseId = (String) request.requestURI.substringBetween('Accounts/', '/contacts');

    return [
      SELECT Id, Name, (SELECT Id, Name FROM Contacts WHERE AccountId = :caseId)
      FROM Account
      WHERE Id = :caseId
      LIMIT 1
    ];
  }
}

/**
 * Account
 * => talking with people , make Contact => store contact information
 * => Account and Contact have relationship
 */

