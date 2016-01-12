//
//  GFHScoresViewController.m
//  GoFishIOS
//
//  Created by Amanda Simon on 1/12/16.
//  Copyright © 2016 RoleModel Software. All rights reserved.
//

#import "GFHScoresViewController.h"
#import "GFHRepository.h"
#import "MatchPerspective.h"
#import "GFHScoreCollectionCell.h"

static NSString * const reuseIdentifier = @"ScoreCell";

@interface GFHScoresViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *scoresCollectionView;
@property (nonatomic, strong) NSArray *scores;
@end

@implementation GFHScoresViewController

- (void)setUpScores {
    self.scores = [GFHDatabase sharedDatabase].matchPerspective.scores;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[GFHDatabase sharedDatabase].matchPerspective.scores count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GFHScoreCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.score = self.scores[indexPath.row];
    return cell;
}

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
