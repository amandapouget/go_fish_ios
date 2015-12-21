//
//  GFHMatchNewViewController.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/21/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHMatchNewViewController.h"
#import "PTPusher.h"
#import "PTPusherChannel.h"
#import "PTPusherEvent.h"
#import "GFHRepository.h"
#import "GFHDatabase.h"
#import "User.h"



static NSString * const NAVIGATION_LOGIN_STORYBOARD_ID = @"GFHNavigationLogIn";
NSString * const GFHPusherKey = @"39cc3ae7664f69e97e12";


@interface GFHMatchNewViewController ()
@property PTPusher *pusher;
@end

@implementation GFHMatchNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([[GFHRepository sharedRepository] loggedIn]) {
//        subscribe to pusher and listen for game send event
        self.pusher = [PTPusher pusherWithKey:GFHPusherKey delegate:nil encrypted:YES];
        PTPusherChannel *channel = [self.pusher subscribeToChannelNamed:[NSString stringWithFormat:@"waiting_for_players_channel_%@", [GFHDatabase sharedDatabase].user.externalId]];
        [channel bindToEventNamed:@"send_to_game_event" target:self action:@selector(handlePusherEvent:)];
        [self.pusher connect];
    } else {
//        send to login screen if not logged in
        UINavigationController *navigationLogInController = [self.storyboard instantiateViewControllerWithIdentifier:NAVIGATION_LOGIN_STORYBOARD_ID];
        [self presentViewController:navigationLogInController animated:YES completion:nil];
    }
}

- (void)handlePusherEvent:(PTPusherEvent *) event {
//    change this to push to controller matchview
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"From Pusher" message:event.data[@"message"] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
