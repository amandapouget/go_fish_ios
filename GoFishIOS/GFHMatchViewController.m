//
//  GFHMatchViewController.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/16/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHMatchViewController.h"
#import "GFHRepository.h"
#import "GFHDatabase.h"
#import "MatchPerspective.h"
#import "GFHPlayerViewController.h"
#import "GFHOpponentCollectionCell.h"
#import "KTCenterFlowLayout.h"
#import "GFHMatchNewViewController.h"
#import "PTPusher.h"
#import "PTPusherChannel.h"
#import "PTPusherEvent.h"

static NSString * const CELL_ID = @"OpponentCell";

@interface GFHMatchViewController ()<PTPusherDelegate> {
    PTPusher *_pusher;
}
@property (nonatomic, strong) MatchPerspective *matchPerspective;
@property (nonatomic, strong) GFHPlayerViewController *playerViewController;
@property (weak, nonatomic) IBOutlet UICollectionView *opponentCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *fishButton;
@property (weak, nonatomic) IBOutlet UILabel *fishLeft;
@end

@implementation GFHMatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    KTCenterFlowLayout *layout = [KTCenterFlowLayout new];
    layout.minimumInteritemSpacing = 50.f;
    layout.minimumLineSpacing = 10.f;
    layout.itemSize = CGSizeMake (102, 121);
    self.opponentCollectionView.collectionViewLayout = layout;
    [[GFHRepository sharedRepository] loadMatchPerspectiveWithSuccess:^{
        self.matchPerspective = [GFHDatabase sharedDatabase].matchPerspective;
        self.playerViewController.player = self.matchPerspective.player;
        self.speech.text = self.matchPerspective.message;
        [self.opponentCollectionView reloadData];
        [self subscribeToPusher];
    } failure:nil withMatchExternalId:self.matchExternalId];
}

// PrepareForSegue must be used by the GIVING controller so it can communicate information to a RECEIVING controller (in this case, GFHPlayerViewController)
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.playerViewController = [segue destinationViewController];
    self.playerViewController.parent = self;
}

- (void)viewDidAppear:(BOOL)animated {

}


- (void)subscribeToPusher {
    _pusher = [PTPusher pusherWithKey:GFHPusherKey delegate:self encrypted:YES];
    PTPusherChannel *channel = [_pusher subscribeToChannelNamed:[NSString stringWithFormat:@"game_play_channel_%@", self.matchExternalId]];
    [channel bindToEventNamed:@"refresh_event" target:self action:@selector(handlePusherEvent:)];
    [_pusher connect];
}

- (void)pusher:(PTPusher *)pusher didSubscribeToChannel:(PTPusherChannel *)channel {
    [self setSubscribed:YES];
}

- (void)handlePusherEvent:(PTPusherEvent *) event {
    [[GFHRepository sharedRepository] loadMatchPerspectiveWithSuccess:^{
        self.matchPerspective = [GFHDatabase sharedDatabase].matchPerspective;
        self.playerViewController.player = self.matchPerspective.player;
        self.speech.text = self.matchPerspective.message;
        [self.opponentCollectionView reloadData];
    } failure:nil withMatchExternalId:self.matchExternalId];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.matchPerspective.opponents count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GFHOpponentCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    cell.opponent = self.matchPerspective.opponents[indexPath.row];
    return cell;
}

- (IBAction)makeMatchPlay:(id)sender {
    if (self.opponentSelected && self.cardSelected) {
        [[GFHRepository sharedRepository] patchMatchWithSuccess:^{} failure:^{} withMatchExternalId:self.matchExternalId withCardRank:self.cardSelected.rank withOpponentExternalID:self.opponentSelected.externalId];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    self.opponentSelected = self.matchPerspective.opponents[indexPath.row];
}
@end
//
//UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Patch was successful!" message:[NSString stringWithFormat:@"opponent %d", [self.opponentSelected.externalId intValue]] preferredStyle:UIAlertControllerStyleAlert];
//[alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
//[self presentViewController:alert animated:YES completion:nil];