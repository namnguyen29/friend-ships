public class StringArrayTest {
  public static List<String> generateStringArray(Integer length) {
    List<String> myArray = new List<String>();

    for (Integer i = 0; i < length; i++) {
      myArray.add('Test ' + i);
      System.debug(myArray[i]);
    }

    return myArray;
  }

  public static void logAccounts() {
    try {
      Account acct = [
        SELECT Phone, Id, Fax, Name
        FROM Account
        WHERE Name = 'Nam-Lee'
        LIMIT 1
      ];
      System.debug('Is Exist::' + acct);
    } catch (DmlException err) {
      System.debug(err.getMessage());
    }
  }
}