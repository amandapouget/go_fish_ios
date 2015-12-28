//
//  GFHNumberOfPlayersButtonsViewController.h
//  GoFishIOS
//
//  Created by Amanda Simon on 12/25/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//
//


#import <UIKit/UIKit.h>

@interface GFHNumberOfPlayersButtonsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UIViewController *parent;
@property (nonatomic, strong) NSMutableArray *numberOfPlayersButtons;
- (void)makeNumberOfPlayersButtons:(NSArray *)numberOfPlayers;

@end
