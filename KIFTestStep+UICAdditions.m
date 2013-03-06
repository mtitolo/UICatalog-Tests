//
//  KIFTestStep+UICAdditions.m
//  UICatalog
//
//  Created by Michele Titolo on 3/5/13.
//
//

#import "KIFTestStep+UICAdditions.h"
#import "AppDelegate.h"
#import "UIAccessibilityElement-KIFAdditions.h"
#import "UIScrollView-KIFAdditions.h"
#import "UIApplication-KIFAdditions.h"

@implementation KIFTestStep (UICAdditions)

+ (id)stepToReset
{
    return [KIFTestStep stepWithDescription:@"Reset the application state." executionBlock:^(KIFTestStep *step, NSError **error) {
        BOOL successfulReset = YES;
        
        // Do the actual reset for your app. Set successfulReset = NO if it fails.
        
        AppDelegate* delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [delegate.navigationController popToRootViewControllerAnimated:NO];
        
        KIFTestCondition(successfulReset, error, @"Failed to reset some part of the application.");
        
        return KIFTestStepResultSuccess;
    }];
}

+ (id)stepToScrollToItemWithAccessibilityLabel:(NSString *)label
{
    return [KIFTestStep stepWithDescription:[NSString stringWithFormat:@"Scroll to %@", label] executionBlock:^KIFTestStepResult(KIFTestStep *step, NSError *__autoreleasing *error) {
        
        [KIFTestStep scrollToElement:[[UIApplication sharedApplication] accessibilityElementWithLabel:label ]];
        
        return KIFTestStepResultSuccess;
    }];
}

+ (void)scrollToElement:(UIAccessibilityElement *)element
{
    UIView *view = [UIAccessibilityElement viewContainingAccessibilityElement:element];
    UIScrollView *scrollView = (UIScrollView *)view;
    while (scrollView && ![scrollView isKindOfClass:[UIScrollView class]]) {
        scrollView = (UIScrollView *)scrollView.superview;
    }
    if (scrollView) {
        if ((UIAccessibilityElement *)view == element) {
            [scrollView scrollViewToVisible:view animated:YES];
        } else {
            CGRect elementFrame = [view.window convertRect:element.accessibilityFrame toView:scrollView];
            [scrollView scrollRectToVisible:elementFrame animated:YES];
        }
        
        // Give the scroll view a small amount of time to perform the scroll.
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.3, false);
    }
}

@end
