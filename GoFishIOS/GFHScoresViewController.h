//
//  GFHScoresViewController.h
//  GoFishIOS
//
//  Created by Amanda Simon on 1/12/16.
//  Copyright © 2016 RoleModel Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFHScoresViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UIViewController *parent;
- (void)setUpScores;
@end
