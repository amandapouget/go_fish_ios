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

@interface MatchPerspective : NSObject

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) Player *player;
@property (nonatomic, strong) NSMutableArray *opponents;
@property (nonatomic, strong) NSMutableArray *scores;

+ (instancetype)newWithJSON:(NSDictionary *)gameInfo inDatabase:(GFHDatabase *)database;
@end
