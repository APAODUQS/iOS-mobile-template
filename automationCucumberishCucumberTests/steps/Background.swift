import Foundation
import Cucumberish

class Background {
    
    func backgroundSteps(){
        
       
        Given("a Mock") { (args, userInfo) -> Void in
            
            print("AUTOMATION - Set the authentication factors with: \(factorList!)")
        }

        Given("a Mock with the params:") { (args, userInfo) -> Void in
            let params  = (userInfo!["DataTable"] as! NSArray);
            
            let requestBody = ConfigBuilder()
                .addAnyValue1(params[0])
                .addAnyValue2(params[1])
                .buildConfig()
            ConfigStub().setBodyStub(requestBody: requestBody);
            ConfigStub().startStub();
            print("AUTOMATION - Config stub were up)")
        }
    }
}
