//
//  JoiningNetworkModel.h
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 20/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "MultipeerConnectionNetworkModel.h"

@protocol JoiningNetworkModelProtocol <NSObject>

-(void)listOfAvailableHostsDidChange;

@end
@interface JoiningNetworkModel : MultipeerConnectionNetworkModel<MCNearbyServiceBrowserDelegate>

@property (nonatomic, strong) MCNearbyServiceBrowser* nearbyServiceBrowser;
@property (nonatomic, strong) NSMutableArray* availableTournamentsNames;
@property (nonatomic, weak) id <JoiningNetworkModelProtocol> delegate;


/**
 * Initiates JoiningNetworkModel properties: MCPeerID, MCSession, MCNearbyServiceBrowser objects.
 * Assignes MCNearbyServiceBrowser delegate to self and finally starts browsing for peers.
 */
-(void)startHostsSearching;

-(void)joinToSelectedHostAtIndex:(NSUInteger)paramIndex;

@end
