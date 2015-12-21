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



@interface GFHMatchViewController ()
@property (nonatomic, strong) MatchPerspective *matchPerspective;
@property (nonatomic, strong) GFHPlayerViewController *playerViewController;
@end

@implementation GFHMatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// PrepareForSegue must be used by the GIVING controller so it can communicate information to a RECEIVING controller (in this case, GFHPlayerViewController)
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.playerViewController = [segue destinationViewController];
}

- (void)viewDidAppear:(BOOL)animated {
    [[GFHRepository sharedRepository] loadMatchPerspectiveWithSuccess:^{
        self.matchPerspective = [GFHDatabase sharedDatabase].matchPerspective;
        self.playerViewController.player = self.matchPerspective.player;
    } failure:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
