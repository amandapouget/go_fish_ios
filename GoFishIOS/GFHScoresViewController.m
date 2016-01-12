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
@property (nonatomic, strong) NSArray *scores;
@end

@implementation GFHScoresViewController

- (void)setUpScores {
    self.scores = [GFHDatabase sharedDatabase].matchPerspective.scores;
    [self.collectionView reloadData];
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

@end
