//
//  GFHMatchNewViewController.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/21/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHMatchNewViewController.h"
#import "GFHMatchViewController.h"
#import "GFHLogInViewController.h"
#import "GFHRepository.h"
#import "GFHDatabase.h"
#import "User.h"
#import "PTPusher.h"
#import "PTPusherChannel.h"
#import "PTPusherEvent.h"
#import "GFHNumberOfPlayersButtonsViewController.h"

static NSString * const NAVIGATION_LOGIN_STORYBOARD_ID = @"GFHNavigationLogIn";
NSString * const GFHPusherKey = @"39cc3ae7664f69e97e12";


@interface GFHMatchNewViewController ()<PTPusherDelegate> {
    PTPusher *_pusher;
}
// might delete the next line, not sure it is needed
@property (nonatomic, weak) id<PTPusherDelegate> delegate;
@property (nonatomic, strong) GFHNumberOfPlayersButtonsViewController *numberOfPlayersButtonsViewController;

@end

@implementation GFHMatchNewViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.numberOfPlayersButtonsViewController = [segue destinationViewController];
    self.numberOfPlayersButtonsViewController.parent = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([[GFHRepository sharedRepository] loggedIn]) {
        [self.speech setText:@"Choose your pond, Fishmaster!"];
        [self subscribeToPusher];
        [self getPossibleNumberOfPlayers];
    } else {
        [self askForLogIn];
    }
}

// move the next two methods to buttoncontroller view did load
- (void)addNumberOfPlayersButtons {
    [self.numberOfPlayersButtonsViewController makeNumberOfPlayersButtons:self.numberOfPlayers];
}

- (void)getPossibleNumberOfPlayers {
    [[GFHRepository sharedRepository] getNumberOfPlayersWithSuccess:^(NSArray *numberOfPlayers) {
        self.numberOfPlayers = numberOfPlayers;
        [self addNumberOfPlayersButtons];
    } failure:^(NSString *errorMessage){
        [self showAlert:@"Getting number of players failed" withAlertMessage:errorMessage];
    }];
}


- (void)askForLogIn {
    GFHLogInViewController *logInViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GFHLogInViewController"];
    [self.navigationController presentViewController:logInViewController animated:YES completion:nil];
}

- (void)sendToMatchWithId:(NSNumber *)matchExternalId {
    GFHMatchViewController *matchViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GFHMatchViewController"];
    matchViewController.matchExternalId = matchExternalId;
    [self.navigationController pushViewController:matchViewController animated:YES];
}
    
- (void)subscribeToPusher {
    _pusher = [PTPusher pusherWithKey:GFHPusherKey delegate:self encrypted:YES];
    PTPusherChannel *channel = [_pusher subscribeToChannelNamed:[NSString stringWithFormat:@"waiting_for_players_channel_%@", [GFHDatabase sharedDatabase].user.externalId]];
    [channel bindToEventNamed:@"send_to_game_event" target:self action:@selector(handlePusherEvent:)];
    [_pusher connect];
}

- (void)pusher:(PTPusher *)pusher didSubscribeToChannel:(PTPusherChannel *)channel {
    [self setSubscribed:YES];
}

- (void)handlePusherEvent:(PTPusherEvent *) event {
    [self sendToMatchWithId:[NSNumber numberWithInteger:[event.data[@"message"] integerValue]]];
}

- (void)showAlert:(NSString *)alertText withAlertMessage:(NSString *)alertMessage {
    NSLog(@"%@",alertText);
    NSLog(@"%@",alertMessage);
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:alertText
                                                                   message:alertMessage
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
@end