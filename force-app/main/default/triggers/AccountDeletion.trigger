trigger AccountDeletion on Account(before delete) {
  List<Account> accounts = [
    SELECT Id
    FROM Account
    WHERE Id IN (SELECT AccountId FROM Opportunity) AND ID IN :Trigger.old
  ];

  for (Account a : accounts) {
    Trigger.oldMap.get(a.Id).addError('Cannot delete account with related opportunities.');
  }
}
