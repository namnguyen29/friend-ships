trigger AddRelatedRecord on Account(after insert, after update) {
  List<Opportunity> oppList = new List<Opportunity>();
  Map<Id, Account> acctsWithOpps = new Map<Id, Account>(
    [SELECT Id, (SELECT Id FROM Opportunities) FROM Account WHERE Id IN :Trigger.new]
  );

  for (Account a : Trigger.new) {
    System.debug(
      'acctsWithOpps.get(a.Id).Opportunities.size()=' + acctsWithOpps.get(a.Id).Opportunities.size()
    );

    if (acctsWithOpps.get(a.Id).Opportunities.size() == 0) {
      oppList.add(
        new Opportunity(
          Name = a.Name + ' Opportunity',
          StageName = 'Prospecting',
          CloseDate = System.today().addMonths(1),
          AccountId = a.Id
        )
      );
    }
  }

  if (oppList.size() > 0) {
    insert oppList;
  }
}