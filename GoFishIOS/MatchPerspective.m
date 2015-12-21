//
//  MatchPerspective.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/15/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "MatchPerspective.h"
#import "Player.h"

NSString * const GFHMatchPerspectiveNameKey = @"name";
NSString * const GFHMatchPerspectiveCardsKey = @"cards";
NSString * const GFHMatchPerspectiveBooksKey = @"books";
NSString * const GFHMatchPerspectiveIconKey = @"icon";
NSString * const GFHMatchPerspectiveIdKey = @"id";
NSString * const GFHMatchPerspectiveRankKey = @"rank";
NSString * const GFHMatchPerspectiveSuitKey = @"suit";
NSString * const GFHMatchPerspectiveMessageKey = @"message";
NSString * const GFHMatchPerspectivePlayerKey = @"player";
NSString * const GFHMatchPerspectiveOpponentsKey = @"opponents";
NSString * const GFHMatchPerspectiveScoresKey = @"scores";

@implementation MatchPerspective
+ (instancetype)newWithAttributes:(NSDictionary *)gameInfo inDatabase:(GFHDatabase *)database {
    MatchPerspective *matchPerspective = [MatchPerspective new];
    matchPerspective.message = gameInfo[GFHMatchPerspectiveMessageKey];
    matchPerspective.player = [Player newWithAttributes:gameInfo[GFHMatchPerspectivePlayerKey]];
    matchPerspective.opponents = [matchPerspective makeOpponents:gameInfo[GFHMatchPerspectiveOpponentsKey]];
    matchPerspective.scores = gameInfo[GFHMatchPerspectiveScoresKey];
    database.matchPerspective = matchPerspective;
    return matchPerspective;
}

- (NSMutableArray *)makeOpponents:(NSArray *)opponentsInfo {
    NSMutableArray *opponents = [NSMutableArray new];
    for (NSDictionary *opponentInfo in opponentsInfo) {
        Player *opponent = [Player newWithAttributes:opponentInfo];
        [opponents addObject:opponent];
    }
    return opponents;
}
@end
