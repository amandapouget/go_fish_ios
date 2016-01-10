//
//  LogInUITests.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UITestHelper.h"

@interface LogInUITests : UITestHelper
@end

@implementation LogInUITests

- (void)testLogInScreenLoads {
//    timeout if can't find:
    [self.app.staticTexts[@"Log In"] tap];
//    confirm found
    XCTAssert([self.app.staticTexts[@"Log In"] exists]);
}

- (void)testLogInButtonWithGoodInfo {
    [self fillInLogInInfoWithEmail:@"mandysimon88@gmail.com" withPassword:@"rose0212"];
    [self.app.buttons[@"Log In"] tap];
    XCTAssert(![self.app.alerts[@"Login Failed"] exists]);
    XCTAssert([self.app.staticTexts[@"Number of Players"] exists]);
}

- (void)testLogInButtonWithBadInfo {
    [self fillInLogInInfoWithEmail:@"fake" withPassword:@"fake"];
    [self.app.buttons[@"Log In"] tap];
    XCTAssert([self.app.alerts[@"Login Failed"] exists]);
}

@end
