//
//  GFHLogInViewController.m
//  GoFishIOS
//
//  Created by Amanda Simon on 12/17/15.
//  Copyright © 2015 RoleModel Software. All rights reserved.
//

#import "GFHLogInViewController.h"
#import "GFHRepository.h"
#import "GFHDatabase.h"
#import "User.h"

@interface GFHLogInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@end

@implementation GFHLogInViewController
- (IBAction)logIn:(id)sender {
    // Send to repository to communicate with server and save resulting user
    [[GFHRepository sharedRepository] loginWithSuccess:^{
        if ([[GFHRepository sharedRepository] loggedIn]) {
            printf("LOGGED IN!");
//            something like the next line to set the user on the match/new controller and go to that controller
//            self.playerViewController.player = self.matchPerspective.player;
        }
    } failure:^(NSString *errorMessage){
//      display your login was invalid on the view page
    } withEmail:self.emailField.text withPassword:self.passwordField.text];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
