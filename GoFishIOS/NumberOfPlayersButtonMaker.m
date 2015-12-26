//
//  NumberOfPlayersButtonMaker.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/25/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//
//
// Single Responsibility: take in an array of ints, return an array of buttons ready for the MatchNewViewController

#import "NumberOfPlayersButtonMaker.h"
#import "GFHMatchNewViewController.h"

@interface NumberOfPlayersButtonMaker()
@property NSMutableArray *buttons;
@property NSArray *numberOfPlayers;
@end

@implementation NumberOfPlayersButtonMaker

- (NSMutableArray *)makeNumberOfPlayersButtons:(NSArray *)numberOfPlayers {
    self.numberOfPlayers = numberOfPlayers;
    self.buttons = [NSMutableArray new];
    [self makeButtons];
    return self.buttons;
}

- (void)makeButtons {
    for (NSNumber *possibleNumberOfPlayers in self.numberOfPlayers) {
        UIButton *button = [self createButton:[UIButton buttonWithType:UIButtonTypeCustom] withValue:possibleNumberOfPlayers];
        [self.buttons addObject:button];
    }
}

- (UIButton *)createButton:(UIButton *)button withValue:(NSNumber *)numberValue {
    [button addTarget:self
               action:@selector(buttonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    button.tag = [numberValue integerValue];
    [button setTitle:[numberValue stringValue] forState:UIControlStateNormal];
    return button;
}

- (void)buttonPressed:(id)sender {
    //    get button.tag and then do something with it
//    UIButton *clicked = (UIButton *)sender;
//    int chosenNumberOfPlayers = clicked.tag;
    //    submit to server match/create
    //    insert code here...
}
@end