public with sharing class ContactSearch {
  public static List<Contact> searchForContacts(String str1, String str2) {
    return [
      SELECT Id, LastName, MailingPostalCode
      FROM Contact
      WHERE Lastname = :str1 AND MailingPostalCode = :str2
    ];
  }
}