//
//  GFHColors.h
//  GoFishIOS
//
//  Created by Amanda Simon on 12/26/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#ifndef GFHColors_h
#define GFHColors_h

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

#define GoFishYellow \
UIColorFromRGB(16776656)

#define GoFishBlue \
UIColorFromRGB(993868)

#define GoFishLightBrown \
UIColorFromRGB(6636321)

#define GoFishDarkBrown \
UIColorFromRGB(4139540)

#define GoFishRed \
UIColorFrom RGB(8388640)

#endif /* GFHColors_h */


