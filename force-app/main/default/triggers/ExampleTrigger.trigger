trigger ExampleTrigger on Contact(after insert, after delete) {
  if (Trigger.isInsert) {
    Integer recordCount = Trigger.new.size();
    String emailAddress = 'nnguyenquoc@owt.swiss';
    String subject = 'Hello Talal';
    String body = recordCount + 'contact(s) were inserted';

    EmailManager.sendMail(emailAddress, subject, body);
  } else if (Trigger.isDelete) {
    //
  }
}