//
//  GFHRepository.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHRepository.h"
#import "GFHDatabase.h"
#import "MatchPerspective.h"

static GFHRepository *_sharedRepository = nil;
static NSString * const BASE_URL = @"http://localhost:3000";

@interface GFHRepository()
@property (nonatomic, strong) GFHDatabase *database;
@end

@implementation GFHRepository
+ (instancetype)sharedRepository {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        _sharedRepository = [self new];
    });
    return _sharedRepository;
}

+ (instancetype)new {
    GFHRepository *repository = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    repository.database = [GFHDatabase sharedDatabase];
    repository.responseSerializer = [AFJSONResponseSerializer serializer];
    return repository;
}

- (void)loadMatchPerspectiveWithSuccess:(EmptyBlock)success failure:(EmptyBlock)failure {
    [self GET:@"/simulate_start" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nonnull responseObject) {
        if (responseObject) {
            [MatchPerspective newWithJSON:responseObject inDatabase:self.database];
        }
        if (success) {
            success();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure();
        }
    }];
}
@end
