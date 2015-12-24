//
//  GFHMatchNewViewController.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/21/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHMatchNewViewController.h"
#import "GFHRepository.h"
#import "GFHDatabase.h"
#import "User.h"
#import "PTPusher.h"
#import "PTPusherChannel.h"
#import "PTPusherEvent.h"

static NSString * const NAVIGATION_LOGIN_STORYBOARD_ID = @"GFHNavigationLogIn";
NSString * const GFHPusherKey = @"39cc3ae7664f69e97e12";


@interface GFHMatchNewViewController ()<PTPusherDelegate> {
    PTPusher *_pusher;
}
@property NSInteger chosenNumberOfPlayers;
@property (nonatomic, weak) id<PTPusherDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *speech;
@end

@implementation GFHMatchNewViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([[GFHRepository sharedRepository] loggedIn]) {
        [self.speech setText:@"Choose your pond, Fishmaster!"];
        [self subscribeToPusher];
        [self getPossibleNumberOfPlayers];
        [self insertPossibleNumberOfPlayersButtons];
    } else {
        [self askForLogIn];
    }
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
//    change this to push to controller matchview
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"From Pusher" message:event.data[@"message"] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)getPossibleNumberOfPlayers {
    [[GFHRepository sharedRepository] getNumberOfPlayersWithSuccess:^(NSArray *numberOfPlayers){
        self.numberOfPlayers = numberOfPlayers;
    } failure:^(NSString *errorMessage){
        [self showAlert:@"Getting number of players failed" withAlertMessage:errorMessage];
    }];
}

- (void)insertPossibleNumberOfPlayersButtons {
        // insert buttons for each numberOfPlayers
        for (NSNumber *possibleNumberOfPlayers in _numberOfPlayers) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = [possibleNumberOfPlayers integerValue];
            [button addTarget:self
                       action:@selector(buttonPressed:)
             forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:@"2" forState:UIControlStateNormal];
            button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
            [self.view addSubview:button];
        }
    
}

- (void)buttonPressed:(id)sender {
    //    get button.tag and then do something with it (set numberOfPlayers)
    UIButton *clicked = (UIButton *)sender;
    self.chosenNumberOfPlayers = clicked.tag;
    //    submit to server match/create
    //    insert code here...
}

- (void)askForLogIn {
    UINavigationController *navigationLogInController = [self.storyboard instantiateViewControllerWithIdentifier:NAVIGATION_LOGIN_STORYBOARD_ID];
    [self presentViewController:navigationLogInController animated:YES completion:nil];
}

/*

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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