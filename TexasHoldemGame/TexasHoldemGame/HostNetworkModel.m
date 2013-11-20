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
}

@end
