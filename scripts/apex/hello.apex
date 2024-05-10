// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

public enum Fruit {
  APPLE,
  BANANA,
  ORANGE
}

public class MyClass {
  public void main(Fruit args) {
    if (args == Fruit.APPLE) {
      System.debug('I have an apple!');
    } else if (args == Fruit.BANANA) {
      System.debug('I have a banana!');
    } else if (args == Fruit.ORANGE) {
      System.debug('I have an orange!');
    }
  }
}

MyClass ctx = new MyClass();
ctx.main(Fruit.APPLE);
ctx.main(Fruit.BANANA);

Integer enumOrd = Fruit.APPLE.ordinal();
System.debug('ordinal::' + enumOrd);

Set<ID> accountIds = new Set<ID>{ '001d000000BOaHSAA1', '001d000000BOaHTAA1' };
List<Account> accounts = [SELECT Name FROM Account WHERE Id IN :accountIds];

Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, Name FROM Account]);
Id accId = '001d000000BOaHSAA1';

List<Account> accs = [SELECT Id, Name FROM Account LIMIT 10];
System.debug('Get account by Id::' + accs);
