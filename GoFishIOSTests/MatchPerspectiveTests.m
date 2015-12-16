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
    self.responseObject = @{
                            @"message":@"Amanda, click card, player and me to request cards!",
                            @"player":@{
                                    @"id":@32,
                                    @"name":@"Amanda",
                                    @"cards":@[
                                            @{@"rank":@"three",@"suit":@"hearts",@"icon":@"/assets/cards/h3.png"},
                                            @{@"rank":@"six",@"suit":@"spades",@"icon":@"/assets/cards/s6.png"},
                                            @{@"rank":@"six",@"suit":@"clubs",@"icon":@"/assets/cards/c6.png"},
                                            @{@"rank":@"jack",@"suit":@"spades",@"icon":@"/assets/cards/s11.png"},
                                            @{@"rank":@"nine",@"suit":@"spades",@"icon":@"/assets/cards/s9.png"}],
                                    @"books":@[],
                                    @"icon":@"/assets/players/player_bee.png"},
                            @"player_index":@0,
                            @"opponents":@[
                                    @{@"id":@33,@"name":@"Bob",@"icon":@"/assets/players/player_dino.png"}],
                            @"scores":@[@[@"Amanda",@0],@[@"Bob",@0],@[@"Fish Left",@42]]};
}

- (void)testNewWithJSON {
    MatchPerspective *matchPerspective = [MatchPerspective newWithJSON:self.responseObject inDatabase:self.database];
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
