//
//  UICAlertScenario.h
//  UICatalog
//
//  Created by Michele Titolo on 3/5/13.
//
//

#import "KIFTestScenario.h"

@interface UICAlertScenario : KIFTestScenario

+ (id)scenarioToOpenSimpleAlert;
+ (id)scenarioToOpenOkCancelAlert;

@end
