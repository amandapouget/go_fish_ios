//
//  MatchPerspective.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/15/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "MatchPerspective.h"
#import "Player.h"

@interface MatchPerspective()
- (NSMutableArray *)makeOpponents:(NSArray *)opponentsInfo;
@end

@implementation MatchPerspective
+ (instancetype)newWithJSON:(NSDictionary *)gameInfo inDatabase:(GFHDatabase *)database {
    MatchPerspective *matchPerspective = [MatchPerspective new];
    matchPerspective.message = gameInfo[@"message"];
    matchPerspective.player = [Player newWithAttributes:gameInfo[@"player"]];
    matchPerspective.opponents = [matchPerspective makeOpponents:gameInfo[@"opponents"]];
    matchPerspective.scores = gameInfo[@"scores"];
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
