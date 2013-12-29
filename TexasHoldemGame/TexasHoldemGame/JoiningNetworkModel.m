//
//  JoiningNetworkModel.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 20/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "JoiningNetworkModel.h"
@interface JoiningNetworkModel()
@property (nonatomic, strong)NSMutableArray * availablePeers;
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

-(NSMutableArray*)availableTournamentsNames
{
    if (!_availableTournamentsNames) {
        _availableTournamentsNames = [[NSMutableArray alloc]init];
    }
    return _availableTournamentsNames;
}

-(NSMutableArray*)availablePeers
{
    if (!_availablePeers) {
        _availablePeers = [[NSMutableArray alloc]init];
    }
    return _availablePeers;
}

#pragma mark - MCNearbyServiceBrowserDelegate methods

-(void)browser:(MCNearbyServiceBrowser *)browser
     foundPeer:(MCPeerID *)peerID
withDiscoveryInfo:(NSDictionary *)info
{
    [self.availablePeers addObject:peerID];
    [self.availableTournamentsNames addObject:[info objectForKey:kPlayerNameInfo]];
    [self.delegate listOfAvailableHostsDidChange];

}


-(void)browser:(MCNearbyServiceBrowser *)browser
      lostPeer:(MCPeerID *)peerID
{
    NSUInteger index = [self.availablePeers indexOfObject:peerID];
    [self.availableTournamentsNames removeObjectAtIndex:index];
    [self.availablePeers removeObject:peerID];
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
    [self.nearbyServiceBrowser invitePeer:[self.availablePeers objectAtIndex:paramIndex]
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
