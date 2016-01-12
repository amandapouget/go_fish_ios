//
//  GFHPlayerViewController.h
//  GoFishIOS
//
//  Created by Amanda Simon on 12/16/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Player;

@interface GFHPlayerViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UIViewController *parent;
@property (nonatomic, strong) Player *player;
@end
