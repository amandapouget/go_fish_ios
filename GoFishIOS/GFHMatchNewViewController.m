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
@property int buttonCount;
@end

@implementation GFHMatchNewViewController

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

- (void)insertPossibleNumberOfPlayersButtons {
    float index = 1;
    float totalButtonsToBePutInLine = self.numberOfPlayers.count;
    for (NSNumber *possibleNumberOfPlayers in self.numberOfPlayers) {
        UIButton *button = [self createButton:[UIButton buttonWithType:UIButtonTypeCustom]
                                    withValue:possibleNumberOfPlayers
            withHorizontalPlacementPercentage:index/totalButtonsToBePutInLine
                            ];
        [self.view addSubview:button];
        _buttonCount++;
        index++;
    }
}

- (UIButton *)createButton:(UIButton *)button withValue:(NSNumber *)numberValue withHorizontalPlacementPercentage:(float)horizontalPlacementPercentage {
    [button addTarget:self
               action:@selector(buttonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    button.tag = [numberValue integerValue];
    [button setTitle:[numberValue stringValue] forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
//    add border
//    correct the frame above
//    use the horizontalPlacementPercentage to determine the constraints
//    extract contraints to a different method
//    fill out the does something on button pressed so you can see...
//    maybe sort the original number of players array by value, assuring the order of the buttons?
//    instead of these constraints, maybe add them to a collection view? just an idea...
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-[myView(>=748)]-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(myView)]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:[myView(==200)]-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(myView)]];
    return button;
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
        [self insertPossibleNumberOfPlayersButtons];
    } failure:^(NSString *errorMessage){
        [self showAlert:@"Getting number of players failed" withAlertMessage:errorMessage];
    }];
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