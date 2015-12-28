//
//  GFHRepository.h
//  GoFishIOS
//
//  Created by Amanda Simon on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFHDatabase.h"

@import AFNetworking;

typedef void (^EmptyBlock)();
typedef void (^BlockWithString)(NSString *);

@interface GFHRepository : AFHTTPSessionManager
@property (nonatomic, strong) GFHDatabase *database;
+ (instancetype)sharedRepository;
- (void)postNumberOfPlayersWithSuccess:(EmptyBlock)success failure:(EmptyBlock)failure withNumber:(NSNumber *)number;
- (void)getNumberOfPlayersWithSuccess:(EmptyBlock)success failure:(EmptyBlock)failure;
- (void)loadMatchPerspectiveWithSuccess:(EmptyBlock)success failure:(EmptyBlock)failure withMatchExternalId:(NSNumber *)matchExternalId;
- (void)loginWithSuccess:(EmptyBlock)success failure:(BlockWithString)failure withEmail:(NSString *)email withPassword:(NSString *)password;
- (BOOL)loggedIn;
@end
