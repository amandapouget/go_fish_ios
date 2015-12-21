//
//  Card.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "Card.h"

NSString * const RANKS = @"two three four five six seven eight nine ten jack queen king ace";
NSString * const SUITS = @"clubs diamonds hearts spades";

@interface Card()
// This is the private interface, the classes view of itself overriding the public interface
@property (nonatomic, strong) NSString *rank;
@property (nonatomic, strong) NSString *suit;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSNumber *value;
- (BOOL)compareRankAndSuit:(Card *)card;

@end

@implementation Card

+ (NSArray *)ranks {
    static NSArray *_ranks;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ranks = [RANKS componentsSeparatedByString:@" "];
    });
    return _ranks;
}

+ (NSArray *)suits {
    static NSArray *_suits;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _suits = [SUITS componentsSeparatedByString:@" "];
    });
    return _suits;
}

+ (instancetype)newWithRank:(NSString *)rank withSuit:(NSString *)suit withIcon:(NSString *)icon {
    Card *card = [self new];
    card.rank = rank;
    card.suit = suit;
    card.icon = icon;
    card.value = @([[self ranks] indexOfObject:rank]);
    
    return card;
}

- (NSComparisonResult)compareRank:(Card *)card {
    return [self.value compare:card.value];
}

- (BOOL)compareRankAndSuit:(Card *)card {
    return [self.rank isEqual:card.rank] && [self.suit isEqual:card.suit];
}

- (BOOL)isEqual:(Card *)card {
    return [self compareRankAndSuit:card];
}

- (NSUInteger)hash {
    return [self.rank hash] ^ [self.suit hash];
}
@end

