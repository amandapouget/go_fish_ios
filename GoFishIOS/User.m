//
//  User.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/17/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "User.h"

NSString * const GFHUserEmailKey = @"email";
NSString * const GFHUserTokenKey = @"token";

@implementation User

+ (instancetype)newWithAttributes:(NSDictionary *)userInfo inDatabase:(GFHDatabase *)database {
    User *user = [User new];
    user.email = userInfo[GFHUserEmailKey];
    user.token = userInfo[GFHUserTokenKey];
    database.user = user;
    return user;
}
@end
