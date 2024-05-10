Http http = new Http();
HttpRequest request = new HttpRequest();
request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/1');
request.setMethod('GET');

HttpResponse response = new HttpResponse();
if (response.getStatusCode() == 200) {
  System.debug('raw data::' + JSON.deserializeUntyped(response.getBody()));
}

global with sharing class MySOAPWebService {
  webService static Account getRecord(String id) {
    // Add your code
  }
}
