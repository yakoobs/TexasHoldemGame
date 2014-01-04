//
//  LoadingGameSettingsViewController.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 15/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "LoadingGameSettingsViewController.h"
#import "MainBoardViewController.h"
#import "GameLogicModel.h"

@interface LoadingGameSettingsViewController ()

@end

@implementation LoadingGameSettingsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Push MainBoardViewController with segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue
                sender:(id)sender
{
    static NSString* const kPushMainBoardVC = @"PushMainBoardVC";
    if ([segue.identifier isEqualToString:kPushMainBoardVC])
    {
        MainBoardViewController* mainBoardVC = (MainBoardViewController*)segue.destinationViewController;
        mainBoardVC.gameLogicModel = [[GameLogicModel alloc]initWithPlayersNames:self.networkModel.playersNames];
    }
}


@end
