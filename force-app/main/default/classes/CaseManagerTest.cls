@IsTest
private class CaseManagerTest {
  @isTest
  static void testGetCaseById() {
    Id recordId = createTestRecord();
    RestRequest request = new RestRequest();
    request.requestUri =
      'https://resourceful-koala-bsw72s-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Cases/' +
      recordId;
    request.httpMethod = 'GET';
    RestContext.request = request;
    Case thisCase = CaseManager.getCaseById();
    Assert.isTrue(thisCase != null);
    Assert.areEqual('Test record', thisCase.Subject);
  }

  @isTest
  static void testCreateCase() {
    ID thisCaseId = CaseManager.createCase('Ferocious chipmunk', 'New', 'Phone', 'Low');

    Assert.isTrue(thisCaseId != null);
    Case thisCase = [SELECT Id, Subject FROM Case WHERE Id = :thisCaseId];
    Assert.isTrue(thisCase != null);
    Assert.areEqual(thisCase.Subject, 'Ferocious chipmunk');
  }

  @isTest
  static void testDeleteCase() {
    Id recordId = createTestRecord();
    RestRequest request = new RestRequest();
    request.requestUri =
      'https://resourceful-koala-bsw72s-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Cases/' +
      recordId;
    request.httpMethod = 'DELETE';
    RestContext.request = request;

    CaseManager.deleteCase();

    // Verify record is deleted
    List<Case> cases = [SELECT Id FROM Case WHERE Id = :recordId];
    Assert.isTrue(cases.size() == 0);
  }

  @isTest
  static void testUpsertCase() {
    // 1. Insert new record
    ID case1Id = CaseManager.upsertCase('Ferocious chipmunk', 'New', 'Phone', 'Low', null);

    // Verify new record was created
    Assert.isTrue(Case1Id != null);
    Case case1 = [SELECT Id, Subject FROM Case WHERE Id = :case1Id];
    Assert.isTrue(case1 != null);
    Assert.areEqual(case1.Subject, 'Ferocious chipmunk');
    // 2. Update status of existing record to Working
    ID case2Id = CaseManager.upsertCase('Ferocious chipmunk', 'Working', 'Phone', 'Low', case1Id);
    // Verify record was updated
    Assert.areEqual(case1Id, case2Id);
    Case case2 = [SELECT Id, Status FROM Case WHERE Id = :case2Id];
    Assert.isTrue(case2 != null);
    Assert.areEqual(case2.Status, 'Working');
  }

  @isTest
  static void testUpdateCaseFields() {
    Id recordId = createTestRecord();
    RestRequest request = new RestRequest();
    request.requestUri =
      'https://resourceful-koala-bsw72s-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Cases/' +
      recordId;
    request.httpMethod = 'PATCH';
    request.addHeader('Content-Type', 'application/json');
    request.requestBody = Blob.valueOf('{"status": "Working"}');
    RestContext.request = request;
    // Update status of existing record to Working
    ID thisCaseId = CaseManager.updateCaseFields();
    // Verify record was updated
    Assert.isTrue(thisCaseId != null);
    Case thisCase = [SELECT Id, Status FROM Case WHERE Id = :thisCaseId];
    Assert.isTrue(thisCase != null);
    Assert.areEqual(thisCase.Status, 'Working');
  }

  public static Id createTestRecord() {
    Case caseTest = new Case(
      Subject = 'Test record',
      Status = 'New',
      Origin = 'Phone',
      Priority = 'Medium'
    );
    insert caseTest;
    return caseTest.Id;
  }
}
