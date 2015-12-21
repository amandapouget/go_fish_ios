//
//  CardTests.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/14/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Card.h"

@interface CardTests : XCTestCase

@end

@implementation CardTests
- (void)testCreateCard {
    Card *card = [Card newWithRank:@"two" withSuit:@"clubs" withIcon:@""];
    XCTAssertEqual(card.rank, @"two");
    XCTAssertEqual(card.suit, @"clubs");
}

- (void)testCardsRankComparison {
    Card *threeOfDiamonds = [Card newWithRank:@"three" withSuit: @"diamonds" withIcon: @""];
    Card *threeOfDiamondsDuplicate = [Card newWithRank:@"three" withSuit: @"diamonds" withIcon: @""];
    Card *jackOfSpades = [Card newWithRank:@"jack" withSuit: @"spades" withIcon: @""];
    XCTAssertEqual([threeOfDiamonds compareRank:jackOfSpades], NSOrderedAscending);
    XCTAssertEqual([jackOfSpades compareRank:threeOfDiamonds], NSOrderedDescending);
    XCTAssertEqual([threeOfDiamondsDuplicate compareRank:threeOfDiamonds], NSOrderedSame);
}

- (void)testCardsSameCardComparison {
    Card *aceOfSpades = [Card newWithRank:@"ace" withSuit:@"spades" withIcon: @""];
    Card *aceOfSpadesDuplicate = [Card newWithRank:@"ace" withSuit:@"spades" withIcon: @""];
    Card *aceOfHearts = [Card newWithRank:@"ace" withSuit:@"hearts" withIcon: @""];
    XCTAssertEqualObjects(aceOfSpades, aceOfSpadesDuplicate);
    XCTAssertNotEqualObjects(aceOfSpades, aceOfHearts);
}
@end
