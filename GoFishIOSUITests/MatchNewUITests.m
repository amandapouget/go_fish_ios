//
//  MatchNewUITests.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/24/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UITestHelper.h"

@interface MatchNewUITests : UITestHelper
@end

@implementation MatchNewUITests

- (void)setUp {
    [super setUp];
    [self logIn];
}

- (void)testPlayerButtonsAppear {
    XCTAssert([self.app.staticTexts[@"Number of Players"] exists]);
    XCTAssert([self.app.buttons count] > 0);
}

@end

