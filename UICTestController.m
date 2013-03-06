//
//  UICTestController.m
//  UICatalog
//
//  Created by Michele Titolo on 3/5/13.
//
//

#import "UICTestController.h"
#import "UICAlertScenario.h"
#import "UICTextScenario.h"

@implementation UICTestController

- (void)initializeScenarios;
{

    [self addAllScenariosWithSelectorPrefix:@"scenario" fromClass:[UICAlertScenario class]];
    [self addAllScenariosWithSelectorPrefix:@"scenario" fromClass:[UICTextScenario class]];
}

@end
