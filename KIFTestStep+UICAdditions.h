//
//  KIFTestStep+UICAdditions.h
//  UICatalog
//
//  Created by Michele Titolo on 3/5/13.
//
//

#import "KIFTestStep.h"

@interface KIFTestStep (UICAdditions)

+ (id)stepToReset;

+ (id)stepToScrollToItemWithAccessibilityLabel:(NSString*)label;

+ (void)scrollToElement:(UIAccessibilityElement *)element;

@end
