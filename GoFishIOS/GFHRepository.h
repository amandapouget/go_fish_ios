//
//  GFHRepository.h
//  GoFishIOS
//
//  Created by Amanda Simon on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@import AFNetworking;

typedef void (^EmptyBlock)();

@interface GFHRepository : AFHTTPSessionManager
+ (instancetype)sharedRepository;
- (void)loadMatchPerspectiveWithSuccess:(EmptyBlock)success failure:(EmptyBlock)failure;
@end
