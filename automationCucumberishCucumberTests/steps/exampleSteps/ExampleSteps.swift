    
import Foundation
import Cucumberish

class ExampleSteps {
    
    let number1
    let number2
    let result
    private let logic = Logic()
    
    func example(){
        
        Given("a frist number (\\d+)") { (args, userInfo) -> Void in
            number1 = Int((args?[0])!)
            NSLog("AUTOMATION - Given a first number \(number1!)")
        }
        
        Given("a second number (\\d+)") { (args, userInfo) -> Void in
            number2 = Int((args?[0])!)
            NSLog("AUTOMATION - Given a second number \(number2!)")
        }
        
        When("the operation is a (.*)") { (args, userInfo) -> Void in
            let operation = String((args?[0])!)
            NSLog("AUTOMATION - the operation is a \(operation!)")
        }
        
        Then("the result is (\\d+)") { (args, userInfo) -> Void in
            resultCurrent =  self.logic.sumNumbers(number1,number2)
            resultExpected = Int((args?[0])!)
            NSLog("AUTOMATION - the result is\(resultExpected!)")
            
            XCTAssert(resultExpected == resultCurrent, "Incorrect result: \(resultCurrent)")
        }
        
        
    }
}

