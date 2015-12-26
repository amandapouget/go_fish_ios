//
//  NumberOfPlayersButtonMakerTests.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/25/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NumberOfPlayersButtonMaker.h"

@interface NumberOfPlayersButtonMaker()
- (NSMutableArray *)makeNumberOfPlayersButtons:(NSArray *)numberOfPlayers;
- (void)makeButtons;
- (UIButton *)createButton:(UIButton *)button withValue:(NSNumber *)numberValue;
- (void)buttonPressed:(id)sender;
@property NSMutableArray *buttons;
@property NSArray *numberOfPlayers;
@end

@interface NumberOfPlayersButtonMakerTests : XCTestCase
@property NumberOfPlayersButtonMaker *buttonMaker;
@end

@implementation NumberOfPlayersButtonMakerTests

- (void)setUp {
    [super setUp];
    self.buttonMaker = [NumberOfPlayersButtonMaker new];
    self.buttonMaker.numberOfPlayers = @[@2, @3, @4, @5];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testMakeNumberOfPlayersButtons {
    [self.buttonMaker makeNumberOfPlayersButtons:self.buttonMaker.numberOfPlayers];
    XCTAssert(self.buttonMaker.buttons != nil);
    XCTAssert([self.buttonMaker.buttons[0] class] == [UIButton class]);
    UIButton *sampleButton = self.buttonMaker.buttons[0];
    NSNumber *expectedButtonNumber = self.buttonMaker.numberOfPlayers[0];
    XCTAssert(sampleButton.tag == [expectedButtonNumber integerValue]);
    XCTAssert(sampleButton.titleLabel.text == [expectedButtonNumber stringValue]);
}

@end
