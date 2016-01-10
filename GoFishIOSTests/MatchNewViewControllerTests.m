//
//  MatchNewViewControllerTests.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/23/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GFHMatchNewViewController.h"
#import "TestHelper.h"

@interface GFHMatchNewViewController()
@property int buttonCount;
- (void)insertPossibleNumberOfPlayersButtons;
@end

@interface MatchNewViewControllerTests : XCTestCase
@property GFHMatchNewViewController *matchNewViewController;
@property (nonatomic, strong) TestHelper *testHelper;
@end

@implementation MatchNewViewControllerTests

- (void)setUp {
    [super setUp];
    self.matchNewViewController = [GFHMatchNewViewController new];
    self.testHelper = [TestHelper newWithRepositoryAndDatabase];
    [self.testHelper logIn];
}

- (void)tearDown {
    [self.testHelper.repository.database reset];
    [super tearDown];
}

- (void)testSubscribeToPusher {
    [self.testHelper runTestBlockWithTimeout:^{
        [self.matchNewViewController subscribeToPusher];
    } withExpectedAssertion:^{
        return self.matchNewViewController.subscribed == YES;
    }];
    XCTAssert(self.matchNewViewController.subscribed == YES);
}

- (void)testGetPossibleNumberOfPlayers {
    [self.testHelper runTestBlockWithTimeout:^{
        [self.matchNewViewController getPossibleNumberOfPlayers];
    } withExpectedAssertion:^{
        return self.matchNewViewController.numberOfPlayers != nil;
    }];
    XCTAssert(self.matchNewViewController.numberOfPlayers != nil);
}

@end
