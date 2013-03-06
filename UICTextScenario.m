//
//  UICTextScenario.m
//  UICatalog
//
//  Created by Michele Titolo on 3/5/13.
//
//

#import "UICTextScenario.h"
#import "KIFTestStep+UICAdditions.h"
#import "UIApplication-KIFAdditions.h"
#import "UIAccessibilityElement-KIFAdditions.h"
#import "KIFTestStep.h"

@implementation UICTextScenario

+ (id)scenarioTypeTextInNormalField
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that we can open a simple alert."];
    [scenario addStep:[KIFTestStep stepToScrollToItemWithAccessibilityLabel:NSLocalizedString(@"TextFieldTitle", @"")]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:NSLocalizedString(@"TextFieldTitle", @"")]];
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:1 description:@"Wait for push animation"]];
    [scenario addStep:[KIFTestStep stepToScrollToItemWithAccessibilityLabel:NSLocalizedString(@"NormalTextField", @"")]];
    [scenario addStep:[KIFTestStep stepToEnterText:@"NSMeetup is awesome" intoViewWithAccessibilityLabel:NSLocalizedString(@"NormalTextField", @"")]];

    return scenario;
}

+ (id)scenarioTypeTextInTextView
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that we can open a simple alert."];
    [scenario addStep:[KIFTestStep stepToScrollToItemWithAccessibilityLabel:NSLocalizedString(@"TextViewTitle", @"")]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:NSLocalizedString(@"TextViewTitle", @"")]];
    [scenario addStep:[KIFTestStep stepToWaitForTimeInterval:1 description:@"Wait for push animation"]];

    // Clearing a textview is best done with setText:nil
    [scenario addStep:[KIFTestStep stepWithDescription:@"Clear text in text view" executionBlock:^KIFTestStepResult(KIFTestStep *step, NSError **error) {
        UIAccessibilityElement *element = [[UIApplication sharedApplication] accessibilityElementWithLabel:@"A Text View" ];
       if (!element) {
            return KIFTestStepResultWait;
        }
        
        UIView *view = [UIAccessibilityElement
                        viewContainingAccessibilityElement:element];
        
        [(UITextField *) view setText:nil];
        
        return KIFTestStepResultSuccess;
    }]];
    
    [scenario addStep:[KIFTestStep stepToEnterText:@"A long time ago in a galaxy far, far away..." intoViewWithAccessibilityLabel:@"A Text View" traits:UIAccessibilityTraitNone expectedResult:@""]];
    return scenario;
}

@end
