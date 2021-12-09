@isTest
global class ItemsHttpCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"name":"mighty moose"}');
        response.setStatusCode(200);
        return response; 
    }
}