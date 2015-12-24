//
//  GFHDatabase.h
//  GoFishIOS
//
//  Created by Amanda Simon on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rihts reserved.
//

#import <Foundation/Foundation.h>
@class User;
@class MatchPerspective;

@interface GFHDatabase : NSObject

@property (nonatomic, strong) MatchPerspective *matchPerspective;
@property (nonatomic, strong) User *user;

+ (instancetype)sharedDatabase;
- (void)reset;
@end
