@isTest
public class SMSCalloutMock implements HttpCalloutMock {
  public HttpResponse respond(HttpRequest req) {
    // Create a fake response
    HttpResponse res = new HttpResponse();
    res.setHeader('Content-Type', 'application/json');
    res.setBody('{"status":"success"}');
    res.setStatusCode(200);
    return res;
  }
}