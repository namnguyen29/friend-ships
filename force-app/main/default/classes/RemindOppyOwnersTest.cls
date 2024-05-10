@IsTest
private class RemindOppyOwnersTest {
  public static String CRON_EXP = '0 0 0 15 3 ? 2042';

  @IsTest
  static void testScheduledJob() {
    // Create some out of date Opportunity records
    List<Opportunity> opptys = new List<Opportunity>();
    Date closeDate = Date.today().addDays(-7);
    for (Integer i = 0; i < 10; i++) {
      Opportunity o = new Opportunity(
        Name = 'Opportunity ' + i,
        CloseDate = closeDate,
        StageName = 'Prospecting'
      );
      opptys.add(o);
    }
    insert opptys;

    // Get the IDs of the opportunities we just inserted
    Map<Id, Opportunity> opptyMap = new Map<Id, Opportunity>(opptys);
    List<Id> opptyIds = new List<Id>(opptyMap.keySet());

    Test.startTest();
    String jobId = System.schedule('ScheduledApexTest', CRON_EXP, new RemindOpptyOwners());
    List<Task> lt = [
      SELECT Id
      FROM Task
      WHERE WhatId IN :opptyIds
    ];
    System.assertEquals(0, lt.size(), 'Tasks exist before job has run');
    Test.stopTest();

    lt = [
      SELECT Id
      FROM Task
      WHERE WhatId IN :opptyIds
    ];
    System.assertEquals(opptyIds.size(), lt.size(), 'Tasks were not created');
  }
}
