//
//  MultipeerConnectionNetworkModel.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 20/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "MultipeerConnectionNetworkBaseModel.h"

NSString* const kServiceType = @"THGameService";
NSString* const kPlayerNameInfo = @"tournamentName";

@implementation MultipeerConnectionNetworkBaseModel

-(void)configureSessionDetails
{
    NSString* peerIDFromDeviceName = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    self.peerID = [[MCPeerID alloc] initWithDisplayName:peerIDFromDeviceName];
    self.session = [[MCSession alloc] initWithPeer:self.peerID];
    self.session.delegate = self;
}

-(NSMutableArray*)playersNames
{
    if (!_playersNames) {
        _playersNames = [[NSMutableArray alloc]init];
    }
    return _playersNames;
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
