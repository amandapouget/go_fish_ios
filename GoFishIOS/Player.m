//
//  Player.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "Player.h"
#import "GFHDatabase.h"
#import "Card.h"

@interface Player()
- (NSMutableArray *)makeCards:(NSArray *)cards;
- (NSMutableArray *)makeBooks:(NSArray *)cards;
@end

@implementation Player

+ (instancetype)newWithAttributes:(NSDictionary *)attributes {
    Player *player = [Player new];
    player.name = attributes[@"name"];
    if (attributes[@"cards"]) {
        player.cards = [player makeCards:attributes[@"cards"]];
    }
    if (attributes[@"books"]) {
        player.books = [player makeBooks:attributes[@"books"]];
    }
    player.icon = attributes[@"icon"];
    player.externalId = attributes[@"id"];
    return player;
}

- (NSMutableArray *)makeCards:(NSArray *)cards {
    NSMutableArray *playerCards = [NSMutableArray new];
    for (NSDictionary *card in cards) {
        Card *playerCard = [Card newWithRank:card[@"rank"] withSuit:card[@"suit"] withIcon:card[@"icon"]];
        [playerCards addObject: playerCard];
    }
    return playerCards;
}

- (NSMutableArray *)makeBooks:(NSArray *)books {
    NSMutableArray *playerBooks = [NSMutableArray new];
    for (NSArray *book in books) {
        NSMutableArray *playerBook = [self makeCards:book];
        [playerBooks addObject:playerBook];
    }
    return playerBooks;
}
@end