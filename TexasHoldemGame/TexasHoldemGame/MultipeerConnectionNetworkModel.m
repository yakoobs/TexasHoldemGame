//
//  MultipeerConnectionNetworkModel.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 20/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "MultipeerConnectionNetworkModel.h"

NSString* const kServiceType = @"THGameService";
NSString* const kPlayerNameInfo = @"tournamentName";

@implementation MultipeerConnectionNetworkModel

-(void)configureSessionDetails
{
    NSString* peerIDFromDeviceName = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    self.peerID = [[MCPeerID alloc] initWithDisplayName:peerIDFromDeviceName];
    self.session = [[MCSession alloc] initWithPeer:self.peerID];
    self.session.delegate = self;
}

#pragma mark - MCSessionDelegate methods
- (void)session:(MCSession *)session
           peer:(MCPeerID *)peerID
 didChangeState:(MCSessionState)state
{
    
}

- (void)session:(MCSession *)session
 didReceiveData:(NSData *)data
       fromPeer:(MCPeerID *)peerID
{
    
}

- (void) session:(MCSession *)session
didReceiveStream:(NSInputStream *)stream
        withName:(NSString *)streamName
        fromPeer:(MCPeerID *)peerID
{
    
}

- (void)session:(MCSession *)session
didStartReceivingResourceWithName:(NSString *)resourceName
       fromPeer:(MCPeerID *)peerID
   withProgress:(NSProgress *)progress
{
    
}

- (void)session:(MCSession *)session
didFinishReceivingResourceWithName:(NSString *)resourceName
       fromPeer:(MCPeerID *)peerID
          atURL:(NSURL *)localURL
      withError:(NSError *)error
{
    
}

@end
