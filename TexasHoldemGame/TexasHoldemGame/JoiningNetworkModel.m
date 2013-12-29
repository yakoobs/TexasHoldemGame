//
//  JoiningNetworkModel.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 20/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "JoiningNetworkModel.h"
@interface JoiningNetworkModel()
@property (nonatomic, strong)NSMutableArray * peers;
@end

@implementation JoiningNetworkModel

-(void)startHostsSearching
{
    [self configureSessionDetails];
    self.nearbyServiceBrowser = [[MCNearbyServiceBrowser alloc] initWithPeer:self.peerID
                                                                 serviceType:kServiceType];
    self.nearbyServiceBrowser.delegate = self;
    [self.nearbyServiceBrowser startBrowsingForPeers];
}

-(NSMutableArray*)availableHostsNames
{
    if (!_availableHostsNames) {
        _availableHostsNames = [[NSMutableArray alloc]init];
    }
    return _availableHostsNames;
}

-(NSMutableArray*)peers
{
    if (!_peers) {
        _peers = [[NSMutableArray alloc]init];
    }
    return _peers;
}

#pragma mark - MCNearbyServiceBrowserDelegate methods

-(void)browser:(MCNearbyServiceBrowser *)browser
     foundPeer:(MCPeerID *)peerID
withDiscoveryInfo:(NSDictionary *)info
{
    [self.peers addObject:peerID];
    [self.availableHostsNames addObject:peerID.displayName];
    [self.delegate listOfAvailableHostsDidChange];

}


-(void)browser:(MCNearbyServiceBrowser *)browser
      lostPeer:(MCPeerID *)peerID
{
    for (NSString* peerName in self.availableHostsNames)
    {
        if ([peerName isEqualToString:peerID.displayName])
        {
            [self.availableHostsNames removeObject:peerName];
            break;
        }
    }
    [self.peers removeObject:peerID];
    [self.delegate listOfAvailableHostsDidChange];
}

- (void)browser:(MCNearbyServiceBrowser *)browser didNotStartBrowsingForPeers:(NSError *)error
{
    NSLog(@"Did not start browsing for peers: %@", error);
    //TODO: alertView or delegate method should be called from here
}

#pragma mark - Connect to selected host methods
-(void)joinToSelectedHostAtIndex:(NSUInteger)paramIndex
{
    const NSTimeInterval connectionTimeout = 10;
    [self.nearbyServiceBrowser invitePeer:[self.peers objectAtIndex:paramIndex]
                                toSession:self.session
                              withContext:nil
                                  timeout:connectionTimeout];
}



-(void)dealloc
{
    [self.nearbyServiceBrowser stopBrowsingForPeers];
    [self.session disconnect];
}
@end
