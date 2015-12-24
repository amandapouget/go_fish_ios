//
//  TestHelper.h
//  GoFishIOS
//
//  Created by Amanda Simon on 12/23/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Foundation/Foundation.h>
#import "GFHRepository.h"
#import "GFHDatabase.h"
#import "User.h"

typedef int (^BlockReturningBOOL)(void);

@interface TestHelper : XCTestCase
@property (nonatomic, strong) GFHRepository *repository;
+ (TestHelper *)newWithRepositoryAndDatabase;
- (void)logIn;
- (void)mockLogIn;
- (void)runTestBlockWithTimeout:(EmptyBlock)testBlock withExpectedAssertion:(BlockReturningBOOL)assertion;
@end
