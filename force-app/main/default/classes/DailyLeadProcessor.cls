public with sharing class DailyLeadProcessor implements Schedulable {
  public void execute(SchedulableContext ctx) {
    List<Lead> leadsSource = [
      SELECT Id, LeadSource, LastName
      FROM Lead
      WHERE LeadSource = ''
      LIMIT 200
    ];

    for (Lead lead : leadsSource) {
      lead.LeadSource = 'Dreamforce';
    }

    update leadsSource;
  }
}