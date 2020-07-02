import Foundation

// More info about that: http://wiremock.org/docs/api/#tag/Stub-Mappings/paths/~1__admin~1mappings/get

class ResponseStub: Codable{
    
    var status: Int? = nil
    var statusMessage: String? = nil
    var headers: Dictionary<String,String>?
    var body: String? = nil
    
    init(){
        status = nil
        statusMessage = nil
        headers = nil
        body = nil
    }
    
}
