//
//  HostNetworkModel.h
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 20/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "MultipeerConnectionNetworkModel.h"

@interface HostNetworkModel : MultipeerConnectionNetworkModel<MCAdvertiserAssistantDelegate>

@property (nonatomic, copy) NSString* tournamentName;
@property (nonatomic, strong) MCAdvertiserAssistant* advertiserAssistant;


/**
 * Initiates HostNetworkModel properties: MCPeerID, MCSession, MCAdvertiserAssistant objects.
 * Begins advertising the service provided by a local peer and starts the assistant
 */
-(void)hostGame;

@end
