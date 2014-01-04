//
//  HostNetworkModel.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 20/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "HostNetworkModel.h"

@interface HostNetworkModel()
@property (nonatomic) NSUInteger numberOfPlayers;
@property (nonatomic,strong) NSMutableArray* playersPeerNames;
@end

@implementation HostNetworkModel

-(NSMutableArray*)playersPeerNames
{
    if (!_playersPeerNames) {
        _playersPeerNames = [[NSMutableArray alloc] init];
    }
    return _playersPeerNames;
}
-(void)hostGame
{
    [super configureSessionDetails];
    NSDictionary* infoDicitonary = @{kPlayerNameInfo: self.tournamentName};
    self.advertiserAssistant = [[MCNearbyServiceAdvertiser alloc] initWithPeer:self.peerID
                                                                 discoveryInfo:infoDicitonary
                                                                   serviceType:kServiceType];
    self.advertiserAssistant.delegate = self;
    [self.advertiserAssistant startAdvertisingPeer];
}

#pragma mark - MCNearbyServiceAdvertiserDelegate methods
- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID
       withContext:(NSData *)context
 invitationHandler:(void (^)(BOOL, MCSession *))invitationHandler
{
    if (self.numberOfPlayers < 6)
    {
        invitationHandler(YES,self.session);
        
        [self.playersPeerNames addObject:peerID];
        
        NSString* newPlayerName = [[NSString alloc]initWithData:context encoding:NSUTF8StringEncoding];
        [self.playersNames addObject:newPlayerName];
        [self.delegate updateListOfPlayers];
    }
    else
    {
        invitationHandler(NO,self.session);
    }
}
- (void)dealloc
{
    [self.advertiserAssistant stopAdvertisingPeer];
    [self.session disconnect];
}
@end
