import Foundation
import XCTest

class RestAPI: XCTestCase {
    
    public var expectation: XCTestExpectation!
    
    func waitingTime(time: Double) -> Bool {
        let time1 = NSDate().timeIntervalSince1970
        
        return (time1 - time) > ConstantsDID().WAIT_TIME ? true : false
    }
    
    func doRequest(path: String, method: String, headers: Array<Dictionary<String, String>>?, bodyRequest: String?) -> Dictionary<String, AnyObject>? {
        let uri = URL(string: "http://\(EnvironmentVar.IP_SERVER):\(EnvironmentVar.PORT_SERVER)\(path)")!
        var request = URLRequest(url: uri)
        var dataResponseJson: Dictionary<String, AnyObject>?
        expectation = expectation(description: "doRequest")
        request.httpMethod = method
        request.timeoutInterval = 30
        if(headers != nil){
            headers?.forEach{ header in
                request.addValue(header.keys.first!, forHTTPHeaderField: header.values.first!)
            }
        }
        if(bodyRequest != nil){
            request.httpBody  = bodyRequest!.data(using: .utf8)
        }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                if error == nil {
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    dataResponseJson = json
                    dataResponseJson![ConstantsDID().BODY_RESPONSE_CODE] = (response as? HTTPURLResponse)!.statusCode as AnyObject
                } else {
                    print("error" + error.debugDescription)
                }
            } catch {
                print("error")
            }
            self.expectation.fulfill()
        })
        task.resume()
        waitForExpectations(timeout: 20)
        
        return dataResponseJson
    }
    
}
