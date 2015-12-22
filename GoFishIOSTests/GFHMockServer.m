//
//  GFHMockServer.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/18/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHMockServer.h"
#import "GFHRepository.h"
#import <OHHTTPStubs/OHHTTPStubs.h>

static GFHMockServer *_sharedHelper;

@implementation GFHMockServer

+ (GFHMockServer *)sharedHelper {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHelper = [self new];
    });
    return _sharedHelper;
}

- (void)mockLoadMatchPerspectiveResponse {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
        return [request.URL.relativePath rangeOfString:@"/api/matches/\\d+" options:NSRegularExpressionSearch].location != NSNotFound;
    } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
        if ([self matchesToken:request withToken:@"valid_token"]) {
            NSString *path = [[NSBundle bundleForClass:self.class] pathForResource:@"match_json_fixture" ofType:@"json"];
            NSData *data = [[NSData alloc] initWithContentsOfFile:path];
            NSDictionary *fakeResponseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            return [self JSONResponseWithStatus:200 body:fakeResponseObject];
        } else {
            return [self JSONResponseWithStatus:401 body:@{
                                                           @"error": @"Token is invalid."
                                                           }];
        }
    }];
}

- (void)mockAuthenticationResponse {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
        return [request.URL.relativePath rangeOfString:@"/api/authenticate"].location != NSNotFound;
    } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
        if ([self matchesBasicAuthCredentials:request withUsername:@"valid_email" withPassword:@"valid_password"]) {
            return [self JSONResponseWithStatus:200 body:@{
                @"email": @"valid_email",
                @"authentication_token": @"valid_token",
                @"id":@"valid_id"
            }];
        } else {
            return [self JSONResponseWithStatus:401 body:@{
                @"error": @"Invalid username or password"
            }];
        }
    }];
}

- (BOOL)matchesBasicAuthCredentials:(NSURLRequest *)request withUsername:(NSString *)username withPassword:(NSString *)password {
    NSString *encoded = [request allHTTPHeaderFields][@"Authorization"];
    NSData *dataToDecode = [[NSData alloc] initWithBase64EncodedString:[encoded substringFromIndex:6] options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *decoded = [[NSString alloc] initWithData:dataToDecode encoding:NSUTF8StringEncoding];
    NSArray *components = [decoded componentsSeparatedByString:@":"];
    NSString *requestUsername = components[0];
    NSString *requestPassword = components[1];
    return [username isEqual:requestUsername] && [password isEqual:requestPassword];
}

- (BOOL)matchesToken:(NSURLRequest *)request withToken:(NSString *)authentication_token {
    NSString *authorizationHeader = [request allHTTPHeaderFields][@"Authorization"];
    NSString *requestToken = [authorizationHeader substringFromIndex:12];
    return [authentication_token isEqual:requestToken];
}

- (OHHTTPStubsResponse *)JSONResponseWithStatus:(int)status body:(id)body {
    NSData *data = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:NULL];
    return [OHHTTPStubsResponse responseWithData:data statusCode:status headers:@{@"Content-Type": @"application/json"}];
}

- (void)resetMocks {
    [OHHTTPStubs removeAllStubs];
}

@end