//
//  GoFishIOSUITests.m
//  GoFishIOSUITests
//
//  Created by Amanda Simon on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface GoFishIOSUITests : XCTestCase
@property (nonatomic, strong) XCUIApplication *app;
@end

@implementation GoFishIOSUITests

- (void)setUp {
    [super setUp];
    self.continueAfterFailure = NO;
    self.app = [XCUIApplication new];
    [self.app launch];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testLogInScreenLoads {
//    timeout if can't find:
    [self.app.staticTexts[@"Log In"] tap];
//    confirm found
    XCTAssert(self.app.staticTexts[@"Log In"].exists);
}

// good login information (user does exist)
- (void)testLogInButtonWithGoodInfo {
    [self fillInLogInInfoWithEmail:@"mandysimon88@gmail.com" withPassword:@"rose0212"];
//    [self.app.buttons[@"Log In"] tap];
    XCTAssert(self.app.staticTexts[@"Log In"].exists);te
}

// bad login information (user does not exist)
- (void)testLogInButtonWithBadInfo {
    [self fillInLogInInfoWithEmail:@"fake" withPassword:@"fake"];
    //    [self.app.buttons[@"Log In"] tap];
    XCTAssert(self.app.staticTexts[@"Log In"].exists);
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
@end
