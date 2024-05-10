trigger DmlTriggerBulk on Account(after update) {
  List<Opportunity> relatedOpps = [
    SELECT Id, Name, Probability
    FROM Opportunity
    WHERE AccountId IN :Trigger.new
  ];
  List<Opportunity> oppsToUpdate = new List<Opportunity>();

  for (Opportunity opp : relatedOpps) {
    if ((opp.Probability >= 50) && (opp.Probability < 100)) {
      opp.Description = 'New description for opportunity.';
      oppsToUpdate.add(opp);
    }
  }

  update oppsToUpdate;
}
