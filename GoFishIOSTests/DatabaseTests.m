//
//  DatabaseTests.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/17/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GFHDatabase.h"
#import "User.h"
#import "MatchPerspective.h"

@interface DatabaseTests : XCTestCase
@property (nonatomic, strong) GFHDatabase *database;
@end

@implementation DatabaseTests

- (void)setUp {
    [super setUp];
    self.database = [GFHDatabase new];
    self.database.user = [User new];
    self.database.matchPerspective = [MatchPerspective new];

}

- (void)testDatabaseProperties {
    XCTAssertTrue([self.database.user isKindOfClass:[User class]]);
    XCTAssertTrue([self.database.matchPerspective isKindOfClass:[MatchPerspective class]]);
}

@end
