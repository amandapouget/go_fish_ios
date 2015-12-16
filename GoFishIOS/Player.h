//
//  Player.h
//  GoFishIOS
//
//  Created by Amanda Simon on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GFHDatabase;

@interface Player : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSMutableArray *books;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSNumber *externalId;

+ (instancetype)newWithAttributes:(NSDictionary *)attributes;
@end