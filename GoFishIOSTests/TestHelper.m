//
//  TestHelper.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/23/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "TestHelper.h"

@implementation TestHelper
+ (TestHelper *)newWithRepositoryAndDatabase {
    TestHelper *testHelper = [TestHelper new];
    testHelper.repository = [GFHRepository new];
    return testHelper;
}

- (void)logIn {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Login with Good User Info"];
    [self.repository loginWithSuccess:^{
        [expectation fulfill];
    }failure:nil withEmail:@"mandysimon88@gmail.com" withPassword:@"rose0212"];
    [self waitForExpectationsWithTimeout:4.0 handler:nil];
}

- (void)mockLogIn {
    self.repository.database.user = [User new];
    self.repository.database.user.authentication_token = @"valid_token";
    self.repository.database.user.email = @"valid_email";
    self.repository.database.user.externalId = @"valid_id";
}

- (void)runTestBlockWithTimeout:(EmptyBlock)testBlock withExpectedAssertion:(BlockReturningBOOL)assertion {
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:5.0];
    testBlock();
    while (!assertion() && ([timeoutDate timeIntervalSinceNow] > 0)) {
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.01, YES);
    }
    XCTAssert(assertion);
}
@end
