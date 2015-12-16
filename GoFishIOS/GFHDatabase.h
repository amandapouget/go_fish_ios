//
//  GFHDatabase.h
//  GoFishIOS
//
//  Created by Amanda Simon on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MatchPerspective;

@interface GFHDatabase : NSObject

@property (nonatomic, strong) MatchPerspective *matchPerspective;

+ (instancetype)sharedDatabase;

@end
