//
//  User.h
//  GoFishIOS
//
//  Created by Amanda Simon on 12/17/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "GFHDatabase.h"

extern NSString * const GFHUserEmailKey;
extern NSString * const GFHUserTokenKey;
extern NSString * const GFHUserExternalIdKey;

@interface User : NSObject
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *authentication_token;
@property (nonatomic, strong) NSString *externalId;

+ (instancetype)newWithAttributes:(NSDictionary *)userInfo inDatabase:(GFHDatabase *)database;
@end
