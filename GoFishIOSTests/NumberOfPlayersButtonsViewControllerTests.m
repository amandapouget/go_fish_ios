//
//  NumberOfPlayersbuttonControllerTests.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/25/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GFHNumberOfPlayersButtonsViewController.h"

@interface GFHNumberOfPlayersButtonsViewController()
- (void)makeNumberOfPlayersButtons:(NSArray *)numberOfPlayers;
- (UIButton *)createButton:(UIButton *)button withValue:(NSNumber *)numberValue;
- (void)buttonPressed:(id)sender;
@property NSArray *numberOfPlayers;
@end

@interface GFHNumberOfPlayersButtonsViewControllerTests : XCTestCase
@property GFHNumberOfPlayersButtonsViewController *buttonController;
@end

@implementation GFHNumberOfPlayersButtonsViewControllerTests

- (void)setUp {
    [super setUp];
    self.buttonController= [GFHNumberOfPlayersButtonsViewController new];
    self.buttonController.numberOfPlayers = @[@2, @3, @4, @5];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testMakeNumberOfPlayersButtons {
    [self.buttonController makeNumberOfPlayersButtons:self.buttonController.numberOfPlayers];
    XCTAssert(self.buttonController.numberOfPlayersButtons != nil);
    XCTAssert([self.buttonController.numberOfPlayersButtons[0] class] == [UIButton class]);
    UIButton *sampleButton = self.buttonController.numberOfPlayersButtons[0];
    NSNumber *expectedButtonNumber = self.buttonController.numberOfPlayers[0];
    XCTAssert(sampleButton.tag == [expectedButtonNumber integerValue]);
    XCTAssert(sampleButton.titleLabel.text == [expectedButtonNumber stringValue]);
}

@end
