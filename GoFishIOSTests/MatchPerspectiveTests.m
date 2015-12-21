//
//  MatchPerspectiveTests.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/15/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MatchPerspective.h"
#import "GFHRepository.h"
#import "GFHDatabase.h"

@interface MatchPerspectiveTests : XCTestCase
@property (nonatomic, strong) GFHDatabase *database;
@property (nonatomic, strong) NSDictionary *responseObject;
@end

@implementation MatchPerspectiveTests

- (void)setUp {
    [super setUp];
    self.database = [GFHDatabase new];
    NSString *path = [[NSBundle bundleForClass:self.class] pathForResource:@"match_json_fixture" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    self.responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
}

- (void)testNewWithAttributes {
    MatchPerspective *matchPerspective = [MatchPerspective newWithAttributes:self.responseObject inDatabase:self.database];
    XCTAssertEqual([matchPerspective message], self.responseObject[@"message"]);
    XCTAssertEqual([matchPerspective scores], self.responseObject[@"scores"]);
    XCTAssertEqual(matchPerspective.player.name, self.responseObject[@"player"][@"name"]);
    NSUInteger index = 0;
    for (Player *opponent in matchPerspective.opponents) {
        XCTAssertEqual(opponent.name, self.responseObject[@"opponents"][index][@"name"]);
        index++;
    }
    XCTAssertTrue(self.database.matchPerspective != nil);
}
@end
