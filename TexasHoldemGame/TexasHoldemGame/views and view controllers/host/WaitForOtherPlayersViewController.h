//
//  WaitForOtherPlayersViewController.h
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 14/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HostNetworkModel.h"

@interface WaitForOtherPlayersViewController : UIViewController

@property (nonatomic,strong) HostNetworkModel* hostNetworkModel;

-(void)setHostNetworkModelPlayerName:(NSString*)paramPlayerName andTournamentName:(NSString*)paramTournamentName;

@end
