public with sharing class RandomContactFactory {
  public static List<Contact> generateRandomContacts(
    Integer numberOfContact,
    String commonLastName
  ) {
    List<Contact> ctcList = new List<Contact>();

    for (Integer i = 0; i < numberOfContact; i++) {
      ctcList.add(new Contact(FirstName = 'Test' + i, LastName = commonLastName));
    }

    return ctcList;
  }
}