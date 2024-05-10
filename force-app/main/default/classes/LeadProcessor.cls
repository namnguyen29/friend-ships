public with sharing class LeadProcessor implements Database.Batchable<SObject>, Database.Stateful {
  //public Integer recordsProcessed = 0;

  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator(
      'SELECT ID, Address, LastTransferDate, LeadSource, AnnualRevenue, MobilePhone FROM Lead'
    );
  }

  public void execute(Database.BatchableContext bc, List<Lead> scope) {
    List<Lead> updateLeads = new List<Lead>();
    for (Lead lead : scope) {
      lead.LeadSource = 'Dreamforce';
      updateLeads.add(lead);
    }
    update updateLeads;
  }

  public void finish(Database.BatchableContext bc) {
    //
  }
}