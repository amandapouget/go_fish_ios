//
//  GFHOpponentCollectionCell.m
//  GoFishIOS
//
//  Created by Amanda Simon on 1/10/16.
//  Copyright © 2016 RoleModel Software. All rights reserved.
//

#import "GFHOpponentCollectionCell.h"
#import "Player.h"
#import "GFHRepository.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface GFHOpponentCollectionCell()
@property (weak, nonatomic) IBOutlet UIImageView *opponentIconImage;
@property (weak, nonatomic) IBOutlet UILabel *opponentNameLabel;
@end

@implementation GFHOpponentCollectionCell

- (void)setOpponent:(Player *)opponent {
    _opponent = opponent;
    self.opponentNameLabel.text =_opponent.name;
    NSURL *imageURL = [NSURL URLWithString:opponent.icon relativeToURL:[GFHRepository sharedRepository].baseURL];
    [self.opponentIconImage setImageWithURL:imageURL];
}
@end