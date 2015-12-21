//
//  GFHMockServer.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/18/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHMockServer.h"
#import "GFHRepository.h"
#import <URLMock/URLMock.h>

@implementation GFHMockServer

+ (void)startMocking {
    [UMKMockURLProtocol enable];
    [UMKMockURLProtocol setVerificationEnabled:YES];
}

+ (void)mockAuthenticationResponse {
    NSString *pattern = [[GFHRepository sharedRepository].baseURL URLByAppendingPathComponent:@"/api/authenticate"].absoluteString;
    UMKPatternMatchingMockRequest *request = [[UMKPatternMatchingMockRequest alloc] initWithURLPattern:pattern];
    request.HTTPMethods = [NSSet setWithObject:kUMKMockHTTPRequestPostMethod];
    request.responderGenerationBlock = ^id<UMKMockURLResponder>(NSURLRequest *request, NSDictionary *parameters) {
        NSString *encoded = [request allHTTPHeaderFields][@"Authorization"];
        NSData *dataToDecode = [[encoded substringFromIndex:6] dataUsingEncoding:NSUTF8StringEncoding];
        NSString *decoded = [[NSString alloc] initWithData:dataToDecode encoding:NSUTF8StringEncoding];
        NSArray *components = [decoded componentsSeparatedByString:@":"];
        NSString *email = components[0];
        NSString *password = components[1];
        
        UMKMockHTTPResponder *responder;
        if ([email isEqual:@"valid_username"] && [password isEqual:@"tests"]) {
            responder = [UMKMockHTTPResponder mockHTTPResponderWithStatusCode:200];
            [responder setBodyWithJSONObject:@{
                                               @"user":@{@"username":@"valid_username", @"authentication_token":@"kjf013md014u01m"}
                                               }];
        } else {
            responder = [UMKMockHTTPResponder mockHTTPResponderWithStatusCode:401];
            [responder setBodyWithJSONObject:@{@"error":@"Invalid username or password"}];
        }
        return responder;
    };
    [UMKMockURLProtocol expectMockRequest:request];
}

+ (void)endMocking {
    [UMKMockURLProtocol enable];
    [UMKMockURLProtocol setVerificationEnabled:NO];
}
@end
