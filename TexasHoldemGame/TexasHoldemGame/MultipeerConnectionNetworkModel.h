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

@interface MultipeerConnectionNetworkModel : NSObject<MCSessionDelegate>

@property (nonatomic, strong) MCSession* session;
@property (nonatomic, strong) MCPeerID* peerID;

-(void)configureSessionDetails;

@end
