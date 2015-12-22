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
    [[GFHMockServer sharedHelper] resetMocks];
    [super tearDown];
}

- (void)testGetNumberOfPlayersWithSuccess {
    [self logIn];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Get Number of Players"];
    [self.repository getNumberOfPlayersWithSuccess:^(NSArray *playerRange){
            XCTAssert(playerRange !=nil);
            [expectation fulfill];
        } failure:nil
    ];
    [self waitForExpectationsWithTimeout:4.0 handler:nil];
}

- (void)testLoadMatchPerspective {
    [self mockLogIn];
    [[GFHMockServer sharedHelper]mockLoadMatchPerspectiveResponse];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Load MatchPerspective"];
    [self.repository loadMatchPerspectiveWithSuccess:^{
        XCTAssert(self.repository.database.matchPerspective != nil);
        [expectation fulfill];
    } failure:nil withMatchExternalId:@1];
    [self waitForExpectationsWithTimeout:4.0 handler:nil];
}

- (void)testLogInToServerWithGoodInfo {
    [[GFHMockServer sharedHelper]mockAuthenticationResponse];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Login with Good User Info"];
    [self.repository loginWithSuccess:^{
        XCTAssert(self.repository.database.user.authentication_token != nil);
        [expectation fulfill];
    } failure:nil withEmail:@"valid_email" withPassword:@"valid_password"];
    [self waitForExpectationsWithTimeout:4.0 handler:nil];
    XCTAssert(self.repository.database.user.authentication_token != nil);
}

- (void) testLogInToServerWithBadInfo {
    [[GFHMockServer sharedHelper]mockAuthenticationResponse];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Login with Bad User Info"];
    [self.repository loginWithSuccess:nil failure:^(NSString *errorMessage) {
        [expectation fulfill];
    } withEmail:@"fake" withPassword:@"fake"];
    [self waitForExpectationsWithTimeout:4.0 handler:nil];
    XCTAssert(self.repository.database.user == nil);
}

- (void)testLoggedIn {
    XCTAssertFalse([self.repository loggedIn]);
    self.repository.database.user = [User new];
    self.repository.database.user.authentication_token = @"valid_token";
    XCTAssertTrue([self.repository loggedIn]);
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
@end
