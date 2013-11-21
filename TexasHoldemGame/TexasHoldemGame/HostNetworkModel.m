//
//  HostNetworkModel.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 20/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "HostNetworkModel.h"

@implementation HostNetworkModel

-(instancetype)initWithPlayerName:(NSString*) playerName andTournamentName:(NSString*)tournamentName
{
    self = [super init];
    if (self) {
        _playerName = playerName;
        _tournamentName = tournamentName;
    }
    return self;
}

-(void)hostGame
{
    [super configureSessionDetails];
    self.advertiserAssistant = [[MCAdvertiserAssistant alloc] initWithServiceType:kServiceType
                                                                    discoveryInfo:nil
                                                                          session:self.session];
    [self.advertiserAssistant start];
}
@end
