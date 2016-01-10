//
//  GFHPlayerViewController.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/16/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHPlayerViewController.h"
#import "GFHRepository.h"
#import "GFHCardCollectionCell.h"
#import "KTCenterFlowLayout.h"
#import "Player.h"

static NSString * const CELL_ID = @"CardCell";

@interface GFHPlayerViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *playerNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *playerIconImage;

@end

@implementation GFHPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    KTCenterFlowLayout *layout = [KTCenterFlowLayout new];
    layout.minimumInteritemSpacing = 10.f;
    layout.minimumLineSpacing = 10.f;
    layout.itemSize = CGSizeMake (71, 96);
    self.cardCollectionView.collectionViewLayout = layout;
}

- (void)setPlayer:(Player *)player {
    _player = player;
    [self setUpPlayerInfo];
}

- (void)setUpPlayerInfo {
    self.playerNameLabel.text =_player.name;
    NSURL *imageURL = [NSURL URLWithString:_player.icon relativeToURL:[GFHRepository sharedRepository].baseURL];
    [self.playerIconImage setImageWithURL:imageURL];
    [self.cardCollectionView reloadData];
}

// look at the delegate and datasource protocols for collectionviews to find out what callbacks (like below) that you need to handle the CLICKING people will do on cards

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.player.cards count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GFHCardCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    cell.card = self.player.cards[indexPath.row];
    return cell;
}

@end
