import Foundation

// More info about that: http://wiremock.org/docs/api/#tag/Stub-Mappings/paths/~1__admin~1mappings/get

class RequestStub : Codable{
    
    var method: String?
    var url: String?
    var urlPath: String?
    var urlPathPattern: String?
    var urlPattern: String?
    var queryParameters: Dictionary<String,Dictionary<String,String>?>?
    var headers: Dictionary<String,Dictionary<String,String>?>?
    var bodyPatterns: Dictionary<String,String>?
    
    init(){
        method = nil
        url = nil
        urlPath = nil
        urlPathPattern = nil
        urlPattern = nil
        queryParameters = nil
        headers = nil
        bodyPatterns = nil
    }
    
}
