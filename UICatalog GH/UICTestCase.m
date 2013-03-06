//
//  UICTestCase.m
//  UICatalog
//
//  Created by Michele Titolo on 3/5/13.
//
//

#import "UICTestCase.h"
#import "MainViewController.h"

@implementation UICTestCase

- (void)testFoo {
    NSString *a = @"foo";
    GHTestLog(@"I can log to the GHUnit test console: %@", a);
    
    // Assert a is not NULL, with no custom error description
    GHAssertNotNULL(a, nil);
    
    // Assert equal objects, add custom error description
    NSString *b = @"bar";
    GHAssertEqualObjects(a, b, @"A custom error message. a should be equal to: %@.", b);
}

- (void)testBar {
    // Another test
    MainViewController* mainVC = [[MainViewController alloc] init];
    GHAssertEquals(mainVC.menuList.count, 5, @"Check we have 5 rows in our table");
}

@end
