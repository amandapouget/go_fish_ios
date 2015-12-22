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

static NSString * const USERNAME_KEY = @"username";
static NSString * const PASSWORD_KEY = @"password";

@implementation GFHMockServer

+ (GFHMockServer *)sharedHelper {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHelper = [self new];
    });
    return _sharedHelper;
}

//- (void)mockLoadMatchPerspectiveResponse {
//    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
//        return [request.URL.relativePath rangeOfString:@"/api/matches/\\d+" options:NSRegularExpressionSearch].location != NSNotFound;
//    } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
//        if ([self matchesBasicAuthToken:request withToken:@"dsgdwzuwxkd7d_T3aVWb"]) {
//            return [self JSONResponseWithStatus:200 body:@{
//                                                           @"email": @"mandysimon88@gmail.com",
//                                                           @"authentication_token": @"valid_token",
//                                                           @"id":@12345
//                                                           }];
//        } else {
//            return [self JSONResponseWithStatus:401 body:@{
//                                                           @"error": @"Invalid username or password"
//                                                           }];
//        }
//    }];
//}

- (void)mockAuthenticationResponse {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
        return [request.URL.relativePath rangeOfString:@"/api/authenticate"].location != NSNotFound;
    } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
        if ([self matchesBasicAuthCredentials:request withUsername:@"mandysimon88@gmail.com" withPassword:@"rose0212"]) {
            return [self JSONResponseWithStatus:200 body:@{
                @"email": @"mandysimon88@gmail.com",
                @"authentication_token": @"valid_token",
                @"id":@12345
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

//- (BOOL)matchesBasicAuthToken:(NSURLRequest *)request withToken:(NSString *)authentication_token {
//    NSString *encoded = [request allHTTPHeaderFields][@"Authorization"];
//    NSData *dataToDecode = [[NSData alloc] initWithBase64EncodedString:[encoded substringFromIndex:6] options:NSDataBase64DecodingIgnoreUnknownCharacters];
//    NSString *decoded = [[NSString alloc] initWithData:dataToDecode encoding:NSUTF8StringEncoding];
//    NSArray *components = [decoded componentsSeparatedByString:@":"];
//    NSString *requestToken = components[0];
//    return [authentication_token isEqual:requestToken];
//}

- (OHHTTPStubsResponse *)JSONResponseWithStatus:(int)status body:(id)body {
    NSData *data = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:NULL];
    return [OHHTTPStubsResponse responseWithData:data statusCode:status headers:@{@"Content-Type": @"application/json"}];
}

- (void)resetMocks {
    [OHHTTPStubs removeAllStubs];
}

@end