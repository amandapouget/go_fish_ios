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
#import "GFHColors.h"
#import "CALayer+RuntimeAttribute.h"

static NSString * const NAVIGATION_LOGIN_STORYBOARD_ID = @"GFHNavigationLogIn";
NSString * const GFHPusherKey = @"39cc3ae7664f69e97e12";

@interface GFHMatchNewViewController ()<PTPusherDelegate> {
    PTPusher *_pusher;
}
@property (nonatomic, strong) GFHNumberOfPlayersButtonsViewController *numberOfPlayersButtonsViewController;
@end

@implementation GFHMatchNewViewController

- (void)viewDidLoad {
    [self customizeNavigationBar];
}

- (void)customizeNavigationBar {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logOut:)];
    self.navigationController.navigationBar.barTintColor = GoFishRed;
    self.navigationController.navigationBar.translucent = NO;
    CALayer *border = [CALayer layer];
    border.borderIBColor = GoFishYellow;
    border.borderWidth = 3;
    CALayer *layer = self.navigationController.navigationBar.layer;
    border.frame = CGRectMake(0, layer.bounds.size.height, layer.bounds.size.width, 3);
    [layer addSublayer:border];
}

- (void)logOut:(id)sender {
    [[GFHDatabase sharedDatabase ]reset];
    [self askForLogIn];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.numberOfPlayersButtonsViewController = [segue destinationViewController];
    self.numberOfPlayersButtonsViewController.parent = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([[GFHRepository sharedRepository] loggedIn]) {
        [self.speech setText:@"Choose your pond, Fishmaster!"];
        [self subscribeToPusher];
    } else {
        [self askForLogIn];
    }
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
@end

//- (void)showAlert:(NSString *)alertText withAlertMessage:(NSString *)alertMessage {
//    NSLog(@"%@",alertText);
//    NSLog(@"%@",alertMessage);
//    UIAlertController* alert = [UIAlertController alertControllerWithTitle:alertText
//                                                                   message:alertMessage
//                                                            preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
//                                                            style:UIAlertActionStyleDefault
//                                                          handler:^(UIAlertAction * action) {}];
//    [alert addAction:defaultAction];
//    [self presentViewController:alert animated:YES completion:nil];
//}