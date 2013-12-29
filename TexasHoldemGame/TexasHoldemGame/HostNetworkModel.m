//
//  HostNetworkModel.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 20/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "HostNetworkModel.h"

@implementation HostNetworkModel

-(void)hostGame
{
    [super configureSessionDetails];
    self.advertiserAssistant = [[MCAdvertiserAssistant alloc] initWithServiceType:kServiceType
                                                                    discoveryInfo:nil
                                                                          session:self.session];
    self.advertiserAssistant.delegate = self;
    [self.advertiserAssistant start];
}

#pragma mark - MCAdvertiserAssistantDelegate methods

- (void)advertiserAssitantWillPresentInvitation:(MCAdvertiserAssistant *)advertiserAssistant
{
    NSLog(@"I've got an invitation");
}


-(void)dealloc
{
    [self.advertiserAssistant stop];
    [self.session disconnect];
}
@end
