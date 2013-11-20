//
//  JoiningNetworkModel.h
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 20/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "MultipeerConnectionNetworkModel.h"

@interface JoiningNetworkModel : MultipeerConnectionNetworkModel<MCBrowserViewControllerDelegate>

@property (nonatomic, strong) MCBrowserViewController* browserVC;

-(void)joinToGame;

@end
