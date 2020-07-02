import Foundation

class WiremockClient {
    
    var baseStub: String
    var wiremockServerIp: String = EnvironmentVar.IP_SERVER
    var wiremockServerPort: String = EnvironmentVar.PORT_SERVER
    
    init(ip: String, port: String){
        self.wiremockServerIp=ip
        self.wiremockServerPort=port
        self.baseStub = "{\"request\":$REQUEST_STUB,\"response\":$RESPONSE_STUB}"
    }
    init(){
        self.baseStub = "{\"request\":$REQUEST_STUB,\"response\":$RESPONSE_STUB}"
    }
    
    func createStub(requestStub: RequestStub, responseStub: ResponseStub) {
        let requestData = try! JSONEncoder().encode(requestStub)
        let responseData = try! JSONEncoder().encode(responseStub)
        baseStub = baseStub.replacingOccurrences(of: "$REQUEST_STUB", with: String(data: requestData, encoding: String.Encoding.utf8)!)
        baseStub = baseStub.replacingOccurrences(of: "$RESPONSE_STUB", with: String(data: responseData, encoding: String.Encoding.utf8)!)
        createMapping(stubDefinition: baseStub)
    }
    
    private func createMapping(stubDefinition: String) -> Dictionary<String, AnyObject>? {
        var dataResponseJson: Dictionary<String, AnyObject>?
        dataResponseJson = sendWiremockOperation(operation:"POST", stub:stubDefinition)
        
        return dataResponseJson
    }
    
    private func sendWiremockOperation(operation: String, stub: String) -> Dictionary<String, AnyObject>? {
        NSLog("AUTOMATION - \(stub)")
        var headers = Array<Dictionary<String,String>>()
        headers.append(["application/json": "Content-Type"])
        let dataResponseJson = RestAPI().doRequest(path: ConstantsDID().PATH_MOCK_SERVER, method: operation, headers: headers, bodyRequest: stub)
        
        return dataResponseJson
    }
    
    func deleteRequests() {
        RestAPI().doRequest(path: ConstantsDID().PATH_MOCK_RESQUESTS, method: "DELETE", headers: nil, bodyRequest: nil)
    }
    
    func deleteStubs() {
        RestAPI().doRequest(path: ConstantsDID().PATH_MOCK_SERVER, method: "DELETE", headers: nil, bodyRequest: nil)
    }
    
    func shutDownMockServer() {
        RestAPI().doRequest(path: ConstantsDID().PATH_MOCK_SHUT_DOWN, method: "POST", headers: nil, bodyRequest: nil)
    }
    
}
