//
//  HostNetworkModel.h
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 20/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "MultipeerConnectionNetworkBaseModel.h"

@protocol HostNetworkModelProtocol <NSObject>

-(void)updateListOfPlayers;

@end

@interface HostNetworkModel : MultipeerConnectionNetworkBaseModel<MCNearbyServiceAdvertiserDelegate>

@property (nonatomic, copy) NSString* tournamentName;
@property (nonatomic, strong) MCNearbyServiceAdvertiser* advertiserAssistant;
@property (nonatomic, strong) NSMutableArray* playersNames;
@property (nonatomic, weak) id<HostNetworkModelProtocol> delegate;

/**
 * Initiates HostNetworkModel properties: MCPeerID, MCSession, MCAdvertiserAssistant objects.
 * Begins advertising the service provided by a local peer and starts the assistant
 */
-(void)hostGame;

@end
