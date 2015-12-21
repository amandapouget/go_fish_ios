//
//  GFHMockServer.h
//  GoFishIOS
//
//  Created by Amanda Simon on 12/18/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFHMockServer : NSObject
+ (void)startMocking;
+ (void)mockAuthenticationResponse;
+ (void)endMocking;
@end
