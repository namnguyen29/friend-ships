public with sharing class ContactAndLeadSearch {
  public static List<List<SObject>> searchContactsAndLeads(String str) {
    List<List<SObject>> searchList = [
      FIND :str
      IN NAME FIELDS
      RETURNING Contact(FirstName, LastName), Lead(FirstName, LastName)
    ];
    return searchList;
  }
}