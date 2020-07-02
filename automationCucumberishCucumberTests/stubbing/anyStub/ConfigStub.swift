import Foundation

class ConfigStub: WiremockManagerProtocol{
    
    var wiremocklient: WiremockClient
    static var dataBody: String?
    
    init(){
        self.wiremocklient = WiremockClient()
    }
    
    func setBodyStub(requestBody: AnyEntity) {
        ConfigStub.dataBody = "{\"m\":\"$M\",\"k\":\"$K\"}"
        ConfigStub.dataBody = ConfigStub.dataBody!.replacingOccurrences(of: "$M", with: requestBody.m)
        ConfigStub.dataBody = ConfigStub.dataBody!.replacingOccurrences(of: "$K", with: requestBody.k)
    }
    
    func startStub() {
        let requestStub = RequestStub()
        let responseStub = ResponseStub()
        requestStub.urlPathPattern = Constants().PATH_GLOBAL_CONFIG
        requestStub.method = "POST"
        requestStub.headers = ["Accept":["equalTo":"HEADER"]]
        responseStub.body = GlobalConfigStub.dataBody!
        responseStub.status = 200
        responseStub.headers = ["Content-Type":"application/json"]
        wiremocklient.createStub(requestStub: requestStub, responseStub: responseStub)
    }
    
    func countRequests() -> Bool {
        let bodyRequest  = "{\"method\": \"POST\", \"url\": \"\(Constants().PATH_GLOBAL_CONFIG)\"}"
        var headers = Array<Dictionary<String,String>>()
        headers.append(["application/json": "Content-Type"])
        let dataResponseJson = RestAPI().doRequest(path: Constants().PATH_MOCK_COUNT, method: "POST", headers: headers, bodyRequest: bodyRequest)
        let requestCount = dataResponseJson != nil ? dataResponseJson![Constants().COUNT_MOCK] as! Int : 0
        NSLog("AUTOMATION - Requests for Config Stub \(requestCount)")
        
        return requestCount != 0 ? true : false
    }
    
    func waitToConsume() {
        NSLog("AUTOMATION - Wait Global Config")
        var waitRequests = self.countRequests()
        let time = NSDate().timeIntervalSince1970
        while (waitRequests == false) {
            waitRequests = self.countRequests()
            if (RestAPI().waitingTime(time: time)){
                waitRequests = true
                NSLog("AUTOMATION - Time Out Waiting Update Global Config")
            }
        }
    }
    
}
