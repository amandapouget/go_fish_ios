//
//  GFHDatabase.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHDatabase.h"

static GFHDatabase *_sharedDatabase;

@implementation GFHDatabase

+ (instancetype)sharedDatabase {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDatabase = [self new];
    });
    return _sharedDatabase;
}

-(void)reset {
    self.matchPerspective = nil;
    self.user = nil;
}

@end
