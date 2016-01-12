//
//  GFHMatchViewController.h
//  GoFishIOS
//
//  Created by Amanda Simon on 12/16/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "Card.h"

@interface GFHMatchViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property BOOL subscribed;
@property (nonatomic, strong) NSNumber *matchExternalId;
@property (weak, nonatomic) IBOutlet UILabel *speech;
@property (weak, nonatomic) Player *opponentSelected;
@property (weak, nonatomic) Card *cardSelected;
@end
