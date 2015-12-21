//
//  GFHMatchViewController.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/16/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHMatchViewController.h"
#import "PTPusher.h"
#import "PTPusherChannel.h"
#import "PTPusherEvent.h"
#import "GFHRepository.h"
#import "GFHDatabase.h"
#import "MatchPerspective.h"
#import "GFHPlayerViewController.h"

static NSString * const PUSHER_KEY = @"9dba9a12fa9567e0a20e";
static NSString * const NAVIGATION_LOGIN_STORYBOARD_ID = @"GFHNavigationLogIn";

@interface GFHMatchViewController ()
@property (nonatomic, strong) PTPusher *pusher;
@property (nonatomic, strong) MatchPerspective *matchPerspective;
@property (nonatomic, strong) GFHPlayerViewController *playerViewController;
@end

@implementation GFHMatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([[GFHRepository sharedRepository] loggedIn]) {
        self.pusher = [PTPusher pusherWithKey:PUSHER_KEY delegate:nil encrypted:YES];
        PTPusherChannel *channel = [self.pusher subscribeToChannelNamed:@"channel1"];
        [channel bindToEventNamed:@"ping" target:self action:@selector(handlePusherEvent:)];
        [self.pusher connect];
        
        [[GFHRepository sharedRepository] loadMatchPerspectiveWithSuccess:^{
            self.matchPerspective = [GFHDatabase sharedDatabase].matchPerspective;
            self.playerViewController.player = self.matchPerspective.player;
        } failure:nil];
    } else {
        UINavigationController *navigationLogInController = [self.storyboard instantiateViewControllerWithIdentifier:NAVIGATION_LOGIN_STORYBOARD_ID];
        [self presentViewController:navigationLogInController animated:YES completion:nil];
    }
}

// PrepareForSegue must be used by the GIVING controller so it can communicate information to a RECEIVING controller (in this case, GFHPlayerViewController)
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.playerViewController = [segue destinationViewController];
}

- (void)handlePusherEvent:(PTPusherEvent *) event {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"From Pusher" message:event.data[@"message"] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
