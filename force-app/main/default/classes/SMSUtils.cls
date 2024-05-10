public class SMSUtils {
  @future(callout=true)
  public static void sendSMSAsync(String fromNbr, String toNbr, String m) {
    String results = sendSMS(fromNbr, toNbr, m);
    System.debug(results);
  }

  public static String sendSMS(String fromNbr, String toNbr, String m) {
    String results = SmsMessage.send(fromNbr, toNbr, m);
    insert new SMS_Log__c(to__c = toNbr, from__c = fromNbr, msg__c = results);
    return results;
  }
}
