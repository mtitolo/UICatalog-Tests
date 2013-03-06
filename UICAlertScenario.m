//
//  UICAlertScenario.m
//  UICatalog
//
//  Created by Michele Titolo on 3/5/13.
//
//

#import "UICAlertScenario.h"
#import "KIFTestStep.h"
#import "KIFTestStep+UICAdditions.h"

@implementation UICAlertScenario

+ (void)initialize
{
    [UICAlertScenario setDefaultStepsToSetUp:[NSArray arrayWithObject:[KIFTestStep stepToReset]]];
}

+ (id)scenarioToOpenSimpleAlert
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that we can open a simple alert."];
    [scenario addStep:[KIFTestStep stepToScrollToItemWithAccessibilityLabel:NSLocalizedString(@"AlertTitle", @"")]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:NSLocalizedString(@"AlertTitle", @"")]];
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:1 description:@"Wait for push animation"]];
    [scenario addStep:[KIFTestStep stepToScrollToItemWithAccessibilityLabel:@"UIAlertView Show Simple"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"UIAlertView Show Simple"]];
    [scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"Alert Simple"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"OK"]];
    
    return scenario;
    
}

+ (id)scenarioToOpenOkCancelAlert
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that we can open a simple alert."];
    [scenario addStep:[KIFTestStep stepToScrollToItemWithAccessibilityLabel:NSLocalizedString(@"AlertTitle", @"")]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:NSLocalizedString(@"AlertTitle", @"")]];
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:1 description:@"Wait for push animation"]];
    [scenario addStep:[KIFTestStep stepToScrollToItemWithAccessibilityLabel:@"UIAlertView Show OK-Cancel"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"UIAlertView Show OK-Cancel"]];
    [scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"Alert OK-Cancel"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"OK"]];
    
    return scenario;
}

@end
