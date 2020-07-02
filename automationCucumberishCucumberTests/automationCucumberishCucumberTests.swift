import Foundation
import Cucumberish

class automationCucumberishCucumberTests: NSObject {
    
    @objc class func CucumberishSwiftInit()
    {
        var application : XCUIApplication!
        beforeStart { () -> Void in
            application = XCUIApplication()
            // StepDefinitions:
            Background().backgroundSteps()
            ExampleSteps().example()
            // Launch App
            application.launch()
        }
               
        let bundle = Bundle(for: automationCucumberishCucumberTests.self)

        Cucumberish.executeFeatures(inDirectory: "Features", from: bundle, includeTags:nil, excludeTags: nil)
        
        before { (scenario: CCIScenarioDefinition?) in
            WiremockClient().deleteRequests()
            WiremockClient().deleteStubs()
        }
    }
}
