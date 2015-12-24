//
//  CALayer+RuntimeAttribute.h
//  GoFishIOS
//
//  Created by Amanda Simon on 12/24/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@import QuartzCore;

@interface CALayer (IBConfiguration)

@property(nonatomic, assign) UIColor* borderIBColor;
@property(nonatomic, assign) UIColor* shadowIBColor;

@end