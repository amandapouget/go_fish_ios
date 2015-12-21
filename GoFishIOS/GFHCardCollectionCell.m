//
//  GFHCardCollectionCell.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/16/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHCardCollectionCell.h"
#import "Card.h"
#import "GFHRepository.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface GFHCardCollectionCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end


@implementation GFHCardCollectionCell

- (void)setCard:(Card *)card {
    _card = card;
    NSURL *imageURL = [NSURL URLWithString:card.icon relativeToURL:[GFHRepository sharedRepository].baseURL];
    [self.imageView setImageWithURL:imageURL];
}

@end
