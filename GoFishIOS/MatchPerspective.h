//
//  MatchPerspective.h
//  GoFishIOS
//
//  Created by Amanda Simon on 12/15/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GFHDatabase.h"
#import "Player.h"

extern NSString * const GFHMatchPerspectiveNameKey;
extern NSString * const GFHMatchPerspectiveCardsKey;
extern NSString * const GFHMatchPerspectiveBooksKey;
extern NSString * const GFHMatchPerspectiveIconKey;
extern NSString * const GFHMatchPerspectiveIdKey;
extern NSString * const GFHMatchPerspectiveRankKey;
extern NSString * const GFHMatchPerspectiveSuitKey;
extern NSString * const GFHMatchPerspectiveMessageKey;
extern NSString * const GFHMatchPerspectivePlayerKey;
extern NSString * const GFHMatchPerspectiveOpponentsKey;
extern NSString * const GFHMatchPerspectiveScoresKey;

@interface MatchPerspective : NSObject

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) Player *player;
@property (nonatomic, strong) NSMutableArray *opponents;
@property (nonatomic, strong) NSMutableArray *scores;

+ (instancetype)newWithAttributes:(NSDictionary *)gameInfo inDatabase:(GFHDatabase *)database;
@end
