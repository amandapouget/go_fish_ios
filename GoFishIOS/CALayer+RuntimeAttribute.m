//
//  CALayer+RuntimeAttribute.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/24/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "CALayer+RuntimeAttribute.h"

@implementation CALayer (IBConfiguration)

-(void)setBorderIBColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderIBColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

-(void)setShadowIBColor:(UIColor*)color
{
    self.shadowColor = color.CGColor;
}

-(UIColor*)shadowIBColor
{
    return [UIColor colorWithCGColor:self.shadowColor];
}

@end