//
//  PlayerTests.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/15/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Player.h"
#import "Card.h"

@interface Player(UnitTests)
- (NSMutableArray *)makeCards:(NSArray *)cards;
- (NSMutableArray *)makeBooks:(NSArray *)cards;
@end

@interface PlayerTests : XCTestCase
@property (nonatomic, strong) NSDictionary *responseObject;
@end

@implementation PlayerTests

- (void)setUp {
    [super setUp];
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

- (void)testNewWithAttributes {
    Player *player = [Player newWithAttributes:self.responseObject[@"player"]];
    XCTAssertEqual(self.responseObject[@"player"][@"id"], player.externalId);
    XCTAssertEqual(self.responseObject[@"player"][@"icon"], player.icon);
    XCTAssertEqual(self.responseObject[@"player"][@"name"], player.name);
    XCTAssertEqual([self.responseObject[@"player"][@"cards"] count], [player.cards count]);
    XCTAssertEqual([self.responseObject[@"player"][@"books"] count], [player.books count]);
}

- (void)testMakeCards {
    Player *player = [Player new];
    NSArray *cardInfo = self.responseObject[@"player"][@"cards"];
    NSArray *madeCards = [player makeCards:cardInfo];
    NSUInteger index = 0;
    for (Card *card in madeCards) {
        XCTAssertEqual([card rank], cardInfo[index][@"rank"]);
        XCTAssertEqual([card suit], cardInfo[index][@"suit"]);
        XCTAssertEqual([card icon], cardInfo[index][@"icon"]);
        index ++;
    }
}

- (void)testMakeBooks {
    Player *player = [Player new];
    NSArray *cardInfo = self.responseObject[@"player"][@"cards"];
    NSArray *bookInfo = @[cardInfo, cardInfo];
    NSArray *madeBooks = [player makeBooks:bookInfo];
    for (NSMutableArray *book in madeBooks) {
        NSUInteger index = 0;
        for (Card *card in book) {
            XCTAssertEqual([card rank], cardInfo[index][@"rank"]);
            XCTAssertEqual([card suit], cardInfo[index][@"suit"]);
            XCTAssertEqual([card icon], cardInfo[index][@"icon"]);
            index ++;
        }
        index = 0;
    }
}
@end