//
//  JoiningNetworkModel.h
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 20/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "MultipeerConnectionNetworkModel.h"

@interface JoiningNetworkModel : MultipeerConnectionNetworkModel<MCNearbyServiceBrowserDelegate>

@property (nonatomic, strong) MCNearbyServiceBrowser* nearbyServiceBrowser;
@property (nonatomic, strong) NSMutableArray* availableHosts;

-(void)joinToGame;

@end
