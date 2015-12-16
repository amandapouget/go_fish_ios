//
//  RepositoryTests.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GFHRepository.h"
#import "GFHDatabase.h"

@interface GFHRepository(UnitTests)
@property (nonatomic, strong) GFHDatabase *database;
@end

@interface RepositoryTests : XCTestCase
@property (nonatomic, strong) GFHRepository *repository;
@end

@implementation RepositoryTests

- (void)setUp {
    [super setUp];
    self.repository = [GFHRepository new];
    self.repository.database = [GFHDatabase new];
}

- (void)testLoadMatchPerspective {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Load MatchPerspective"];
    [self.repository loadMatchPerspectiveWithSuccess:^{
        XCTAssert(self.repository.database.matchPerspective != nil);
        [expectation fulfill];
    } failure:nil];
    [self waitForExpectationsWithTimeout:4.0 handler:nil];
}
@end
