//
//  WaitForOtherPlayersViewController.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 14/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "WaitForOtherPlayersViewController.h"

@interface WaitForOtherPlayersViewController ()

@end

@implementation WaitForOtherPlayersViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureTheGame];
}

-(void)configureTheGame
{
    [self.hostNetworkModel hostGame];
}

-(void)setHostNetworkModelPlayerName:(NSString*)paramPlayerName
                   andTournamentName:(NSString*)paramTournamentName
{
        self.hostNetworkModel.playerName = paramPlayerName;
        self.hostNetworkModel.tournamentName = paramTournamentName;
}

-(HostNetworkModel*)hostNetworkModel
{
    if (!_hostNetworkModel)
    {
        _hostNetworkModel = [[HostNetworkModel alloc]init];
    }
    return _hostNetworkModel;
}

@end
