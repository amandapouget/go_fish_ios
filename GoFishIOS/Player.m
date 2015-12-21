//
//  Player.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "Player.h"
#import "Card.h"
#import "MatchPerspective.h"

@implementation Player

+ (instancetype)newWithAttributes:(NSDictionary *)attributes {
    Player *player = [Player new];
    player.name = attributes[GFHMatchPerspectiveNameKey];
    if (attributes[GFHMatchPerspectiveCardsKey]) {
        player.cards = [player makeCards:attributes[GFHMatchPerspectiveCardsKey]];
    }
    if (attributes[GFHMatchPerspectiveBooksKey]) {
        player.books = [player makeBooks:attributes[GFHMatchPerspectiveBooksKey]];
    }
    player.icon = attributes[GFHMatchPerspectiveIconKey];
    player.externalId = attributes[GFHMatchPerspectiveIdKey];
    return player;
}

- (NSMutableArray *)makeCards:(NSArray *)cards {
    NSMutableArray *playerCards = [NSMutableArray new];
    for (NSDictionary *card in cards) {
        Card *playerCard = [Card newWithRank:card[GFHMatchPerspectiveRankKey] withSuit:card[GFHMatchPerspectiveSuitKey] withIcon:card[GFHMatchPerspectiveIconKey]];
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