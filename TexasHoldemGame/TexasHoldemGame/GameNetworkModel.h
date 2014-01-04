//
//  MultipeerConnectionNetworkModel.h
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 20/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

extern NSString* const kServiceType;
extern NSString* const kPlayerNameInfo;

@interface GameNetworkModel : NSObject<MCSessionDelegate>

@property (nonatomic) NSUInteger numberOfPlayers;
@property (nonatomic,strong) NSMutableArray* playersPeerNames;
@property (nonatomic, strong) NSMutableArray* playersNames;
@property (nonatomic, strong) MCSession* session;
@property (nonatomic, strong) MCPeerID* peerID;
@property (nonatomic, copy) NSString* playerName;
@property (nonatomic,strong) MCPeerID* serverPeerId;

/**
* Responsible for initialisation MCSession and MCPeerID properties. MCSession instance's delegate is assigned to self.
*/
-(void)configureSessionDetails;

@end
