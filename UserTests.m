//
//  UserTests.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/17/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "User.h"
#import "GFHRepository.h"
#import "GFHDatabase.h"

@interface UserTests : XCTestCase
@property (nonatomic, strong) GFHDatabase *database;
@property (nonatomic, strong) NSDictionary *responseObject;
@end

@implementation UserTests

- (void)setUp {
    [super setUp];
    self.database = [GFHDatabase new];
    NSString *path = [[NSBundle bundleForClass:self.class] pathForResource:@"user_login_valid_json_fixture" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    self.responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
}

- (void)testNewWithAttributes {
    User *user = [User newWithAttributes:self.responseObject inDatabase:self.database];
    XCTAssertEqual([user email], self.responseObject[@"email"]);
    XCTAssertEqual([user token], self.responseObject[@"token"]);
    XCTAssertTrue(self.database.user != nil);
}
@end
