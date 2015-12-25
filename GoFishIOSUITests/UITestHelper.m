//
//  UITestHelper.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/24/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "UITestHelper.h"

@implementation UITestHelper

- (void)setUp {
    [super setUp];
    self.continueAfterFailure = NO;
    self.app = [XCUIApplication new];
    [self.app launch];
}


- (void)fillInLogInInfoWithEmail:(NSString *)email withPassword:(NSString *)password {
    XCUIElement *element = [[[[[[[self.app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element;
    XCUIElement *textField = [element childrenMatchingType:XCUIElementTypeTextField].element;
    [textField tap];
    [textField typeText:email];
    XCUIElement *secureTextField = [element childrenMatchingType:XCUIElementTypeSecureTextField].element;
    [secureTextField tap];
    [secureTextField typeText:password];
}

- (void)logIn {
    [self fillInLogInInfoWithEmail:@"mandysimon88@gmail.com" withPassword:@"rose0212"];
    [self.app.buttons[@"Log In"] tap];
}

@end
