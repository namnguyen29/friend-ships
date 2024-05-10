public with sharing class AccountHandler {
  public static Account insertNewAccount(String str) {
    try {
      Account newAcc = new Account(Name = str);
      insert newAcc;
      return [SELECT Id, Name FROM Account WHERE Name = :str LIMIT 1];
    } catch (Exception err) {
      System.debug(err.getMessage());
      return null;
    }
  }
}