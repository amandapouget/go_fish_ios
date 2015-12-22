//
//  User.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/17/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "User.h"

NSString * const GFHUserEmailKey = @"email";
NSString * const GFHUserTokenKey = @"authentication_token";
NSString * const GFHUserExternalIdKey = @"id";

@implementation User

+ (instancetype)newWithAttributes:(NSDictionary *)userInfo inDatabase:(GFHDatabase *)database {
    User *user = [User new];
    user.email = userInfo[GFHUserEmailKey];
    user.authentication_token = userInfo[GFHUserTokenKey];
    user.externalId = userInfo[GFHUserExternalIdKey];
    database.user = user;
    return user;
}
@end
