//
//  GFHMatchViewController.h
//  GoFishIOS
//
//  Created by Amanda Simon on 12/16/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFHMatchViewController : UIViewController
@property (nonatomic, strong) NSNumber *matchExternalId;
@property (weak, nonatomic) IBOutlet UILabel *speech;
@end
