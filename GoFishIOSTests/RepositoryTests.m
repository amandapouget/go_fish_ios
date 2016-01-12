//
//  RepositoryTests.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GFHMockServer.h"
#import "TestHelper.h"

@interface RepositoryTests : XCTestCase
@property (nonatomic, strong) TestHelper *testHelper;
@end

@implementation RepositoryTests

- (void)setUp {
    [super setUp];
    self.testHelper = [TestHelper newWithRepositoryAndDatabase];
}

- (void)tearDown {
    [[GFHMockServer sharedHelper] resetMocks];
    [self.testHelper.repository.database reset];
    [super tearDown];
}

- (void)testPatchMatchWithSuccess {
    [self.testHelper mockLogIn];
    [[GFHMockServer sharedHelper]mockPatchMatchResponse];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Post Match Update"];
    [self.testHelper.repository patchMatchWithSuccess:^{
        [expectation fulfill];
    } failure:nil withMatchExternalId:@1 withCardRank:@"two" withOpponentExternalID:@1];
    [self waitForExpectationsWithTimeout:4.0 handler:nil];
    
}

- (void)testPostNumberOfPlayersWithSuccess {
    [self.testHelper logIn];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Post Number of Players"];
    [self.testHelper.repository postNumberOfPlayersWithSuccess:^{
        [expectation fulfill];
    } failure:nil withNumber:@2];
    [self waitForExpectationsWithTimeout:4.0 handler:nil];
}

- (void)testGetNumberOfPlayersWithSuccess {
    [self.testHelper logIn];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Get Number of Players"];
    [self.testHelper.repository getNumberOfPlayersWithSuccess:^(NSArray *playerRange) {
        XCTAssert(playerRange !=nil);
        [expectation fulfill];
    } failure:nil
     ];
    [self waitForExpectationsWithTimeout:4.0 handler:nil];
}

- (void)testLoadMatchPerspective {
    [self.testHelper mockLogIn];
    [[GFHMockServer sharedHelper]mockLoadMatchPerspectiveResponse];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Load MatchPerspective"];
    [self.testHelper.repository loadMatchPerspectiveWithSuccess:^{
        XCTAssert(self.testHelper.repository.database.matchPerspective != nil);
        [expectation fulfill];
    } failure:nil withMatchExternalId:@1];
    [self waitForExpectationsWithTimeout:4.0 handler:nil];
}

- (void)testLogInToServerWithGoodInfo {
    [[GFHMockServer sharedHelper]mockAuthenticationResponse];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Login with Good User Info"];
    [self.testHelper.repository loginWithSuccess:^{
        XCTAssert(self.testHelper.repository.database.user.authentication_token != nil);
        [expectation fulfill];
    } failure:nil withEmail:@"valid_email" withPassword:@"valid_password"];
    [self waitForExpectationsWithTimeout:4.0 handler:nil];
    XCTAssert(self.testHelper.repository.database.user.authentication_token != nil);
}

- (void) testLogInToServerWithBadInfo {
    [[GFHMockServer sharedHelper]mockAuthenticationResponse];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Login with Bad User Info"];
    [self.testHelper.repository loginWithSuccess:nil failure:^(NSString *errorMessage) {
        [expectation fulfill];
    } withEmail:@"fake" withPassword:@"fake"];
    [self waitForExpectationsWithTimeout:4.0 handler:nil];
    XCTAssert(self.testHelper.repository.database.user == nil);
}

- (void)testLoggedIn {
    XCTAssertFalse([self.testHelper.repository loggedIn]);
    self.testHelper.repository.database.user = [User new];
    self.testHelper.repository.database.user.authentication_token = @"valid_token";
    XCTAssertTrue([self.testHelper.repository loggedIn]);
}
@end