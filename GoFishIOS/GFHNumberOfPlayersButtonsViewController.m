//
//  GFHNumberOfPlayersButtonsViewController.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/25/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//
//
#import "GFHNumberOfPlayersButtonsViewController.h"
#import "GFHNumberOfPlayersButtonCell.h"
#import "KTCenterFlowLayout.h"

static NSString * const CELL_ID = @"NumberOfPlayersButtonCell";

@interface GFHNumberOfPlayersButtonsViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *numberOfPlayersCollectionView;
@end

@implementation GFHNumberOfPlayersButtonsViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    KTCenterFlowLayout *layout = [KTCenterFlowLayout new];
    layout.minimumInteritemSpacing = 10.f;
    layout.minimumLineSpacing = 10.f;
    self.numberOfPlayersCollectionView.collectionViewLayout = layout;
}

- (void)setNumberOfPlayersButtons:(NSArray *)numberOfPlayersButtons {
    _numberOfPlayersButtons = numberOfPlayersButtons;
    [self.numberOfPlayersCollectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.numberOfPlayersButtons count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GFHNumberOfPlayersButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    
    cell.button = self.numberOfPlayersButtons[indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
