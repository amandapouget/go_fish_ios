//
//  GFHMatchNewViewController.h
//  GoFishIOS
//
//  Created by Amanda Simon on 12/21/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const GFHPusherKey;
@interface GFHMatchNewViewController : UIViewController

@property BOOL subscribed;
@property (weak, nonatomic) IBOutlet UILabel *speech;
- (void)subscribeToPusher;
@end
