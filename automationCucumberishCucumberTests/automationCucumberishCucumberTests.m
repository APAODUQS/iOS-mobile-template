#import <Foundation/Foundation.h>
#import "automationCucumberishCucumberTests-Swift.h"
#import <XCTest/XCTest.h>


__attribute__((constructor))
void CucumberishInit()
{
    [automationCucumberishCucumberTests CucumberishSwiftInit];

}
