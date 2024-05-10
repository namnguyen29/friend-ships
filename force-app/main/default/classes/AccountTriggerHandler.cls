public class AccountTriggerHandler {
  public static void CreateAccounts(List<Account> accounts) {
    for (Account acc : accounts) {
      if (acc.ShippingState != acc.BillingState) {
        acc.ShippingState = acc.BillingState;
      }
    }
  }
}