//
//  LoadingGameSettingsViewController.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 15/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "LoadingGameSettingsViewController.h"
#import "MainBoardViewController.h"

@interface LoadingGameSettingsViewController ()

@end

@implementation LoadingGameSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Push MainBoardViewController with segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue
                sender:(id)sender
{
    static NSString* const kPushMainBoardVC = @"PushMainBoardVC";
    if ([segue.identifier isEqualToString:kPushMainBoardVC])
    {
        MainBoardViewController* loadingGameSettingsVC = (MainBoardViewController*)segue.destinationViewController;
        //TODO: initialize MainBoardViewController properties.
    }
}


@end
