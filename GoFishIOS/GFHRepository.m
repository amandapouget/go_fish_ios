//
//  GFHRepository.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHRepository.h"
#import "MatchPerspective.h"
#import "User.h"

static GFHRepository *_sharedRepository = nil;
static NSString * const BASE_URL = @"http://localhost:3000";
static NSString * const INVALID_LOGIN_ERROR = @"invalid email or password";

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
    repository.requestSerializer = [AFJSONRequestSerializer serializer];
    return repository;
}

- (void)patchMatchWithSuccess:(EmptyBlock)success failure:(EmptyBlock)failure withMatchExternalId:(NSNumber *)matchExternalId withCardRank:(NSString *)cardRank withOpponentExternalID:(NSNumber *)opponentExternalId {
    NSDictionary *params = @{@"opponentUserId": opponentExternalId,
                             @"rank": cardRank};
    [self.requestSerializer setValue:[NSString stringWithFormat:@"Token token=%@", self.database.user.authentication_token] forHTTPHeaderField:@"Authorization"];
    [self PATCH:[NSString stringWithFormat:@"/api/matches/%d", [matchExternalId intValue]] parameters:params success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *failureError = [self serializeFailure:error];
        if (failure) {
            failure(failureError[@"error"]);
        }
    }];
}

- (void)postNumberOfPlayersWithSuccess:(EmptyBlock)success failure:(EmptyBlock)failure withNumber:(NSNumber *)number {
    NSDictionary *params = @{@"num_players": number};
    [self.requestSerializer setValue:[NSString stringWithFormat:@"Token token=%@", self.database.user.authentication_token] forHTTPHeaderField:@"Authorization"];
    [self POST:@"/api/matches" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *failureError = [self serializeFailure:error];
        if (failure) {
            failure(failureError[@"error"]);
        }
    }];
}

- (void)getNumberOfPlayersWithSuccess:(EmptyBlock)success failure:(EmptyBlock)failure {
    [self.requestSerializer setValue:[NSString stringWithFormat:@"Token token=\"%@\"", self.database.user.authentication_token] forHTTPHeaderField:@"Authorization"];
    [self GET:@"/api/matches/new" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        if (success) {
            success(responseObject[@"player_range"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *failureError = [self serializeFailure:error];
        if (failure) {
            failure(failureError[@"error"]);
        }
    }];
}

- (void)loadMatchPerspectiveWithSuccess:(EmptyBlock)success failure:(EmptyBlock)failure withMatchExternalId:(NSNumber *)matchExternalId {
    [self.requestSerializer setValue:[NSString stringWithFormat:@"Token token=%@", self.database.user.authentication_token] forHTTPHeaderField:@"Authorization"];
    NSString *matchUrl = [NSString stringWithFormat:@"/api/matches/%@", matchExternalId];
    [self GET:matchUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        if (responseObject) {
            [MatchPerspective newWithAttributes:responseObject inDatabase:self.database];
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

- (void)loginWithSuccess:(EmptyBlock)success failure:(BlockWithString)failure withEmail:(NSString *)email withPassword:(NSString *)password {
    [self.requestSerializer setAuthorizationHeaderFieldWithUsername:email password:password];
    [self POST:@"/api/authenticate" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        [User newWithAttributes:responseObject inDatabase:self.database];
        if (success) {
            success();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *failureError = [self serializeFailure:error];
        if (failure) {
            failure(failureError[@"error"]);
        }
    }];
}

- (id)serializeFailure:(NSError *)error {
    NSError *serializeError;
    id errorResponseJSON = @{@"error": @"Unable to process server request at this time."};
    NSData *errorResponse = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
    if (errorResponse) {
        errorResponseJSON = [NSJSONSerialization JSONObjectWithData:errorResponse options:NSJSONReadingMutableContainers error:&serializeError];
    }
    if (serializeError) {
        NSLog(@"Could not serialize JSON response from server: %@", serializeError);
    }
    NSLog(@"Unknown error in your server request: %@", error);
    return errorResponseJSON;
}

- (BOOL)loggedIn {
    return self.database.user.authentication_token != nil;
}
@end
