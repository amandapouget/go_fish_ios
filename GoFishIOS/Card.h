//
//  Card.h
//  GoFishIOS
//
//  Created by Amanda Simon on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
// This is the public interface, the outside worlds view of the class
@property (nonatomic, strong, readonly) NSString *rank;
@property (nonatomic, strong, readonly) NSString *suit;
@property (nonatomic, strong, readonly) NSString *icon;

+ (instancetype)newWithRank:(NSString *)rank withSuit:(NSString *)suit withIcon:(NSString *)icon;
+ (NSArray *)suits;
+ (NSArray *)ranks;
- (NSComparisonResult)compareRank:(Card *)card;
@end
