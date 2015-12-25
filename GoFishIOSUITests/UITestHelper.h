//
//  UITestHelper.h
//  GoFishIOS
//
//  Created by Amanda Simon on 12/24/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface UITestHelper : XCTestCase
@property (nonatomic, strong) XCUIApplication *app;
- (void)fillInLogInInfoWithEmail:(NSString *)email withPassword:(NSString *)password;
- (void)logIn;
@end
