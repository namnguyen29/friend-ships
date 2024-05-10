public with sharing class AddPrimaryContact implements Queueable {
  private Contact contact;
  private String state;

  public AddPrimaryContact(Contact contact, String state) {
    this.contact = contact;
    this.state = state;
  }

  public void execute(QueueableContext qc) {
    List<Contact> insertedContacts = new List<Contact>();
    List<Account> accounts = [
      SELECT Id, Name
      FROM Account
      WHERE BillingState = :this.state
      LIMIT 200
    ];

    for (Account acc : accounts) {
      Contact currentContact = this.contact.clone();
      currentContact.AccountId = acc.Id;
      insertedContacts.add(currentContact);
    }

    insert insertedContacts;
  }
}