//
//  RepositoryTests.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GFHMockServer.h"
#import "GFHRepository.h"
#import "GFHDatabase.h"
#import "User.h"

@interface GFHRepository(UnitTests)
@property (nonatomic, strong) GFHDatabase *database;
@end

@interface RepositoryTests : XCTestCase
@property (nonatomic, strong) GFHRepository *repository;
@property (nonatomic, strong) NSDictionary *responseObject;
@end

@implementation RepositoryTests

- (void)setUp {
    [super setUp];
    self.repository = [GFHRepository new];
    self.repository.database = [GFHDatabase new];
}

- (void)tearDown {
    [GFHMockServer endMocking];
    [super tearDown];
}

- (void)testLoadMatchPerspective {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Load MatchPerspective"];
    [self.repository loadMatchPerspectiveWithSuccess:^{
        XCTAssert(self.repository.database.matchPerspective != nil);
        [expectation fulfill];
    } failure:nil];
    [self waitForExpectationsWithTimeout:4.0 handler:nil];
}

// good login information (user does exist)
- (void)testLogInToServerWithGoodInfo {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Login with Good User Info"];
    [self.repository loginWithSuccess:^{
        XCTAssert(self.repository.database.user != nil);
        [expectation fulfill];
    } failure:nil withEmail:@"mandysimon88@gmail.com" withPassword:@"rose0212"];
    [self waitForExpectationsWithTimeout:4.0 handler:nil];
}

// bad login information (user does not exist)
- (void) testLogInToServerWithBadInfo {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Login with Bad User Info"];
    [self.repository loginWithSuccess:nil failure:^(NSString *errorMessage) {
        XCTAssert(self.repository.database.user == nil);
        [expectation fulfill];
    } withEmail:@"fake" withPassword:@"fake"];
    [self waitForExpectationsWithTimeout:4.0 handler:nil];
}

- (void)testLoggedIn {
    XCTAssertFalse([self.repository loggedIn]);
    self.repository.database.user = [User new];
    XCTAssertTrue([self.repository loggedIn]);
}
@end
