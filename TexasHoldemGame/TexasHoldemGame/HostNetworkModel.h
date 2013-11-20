//
//  HostNetworkModel.h
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 20/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "MultipeerConnectionNetworkModel.h"

@interface HostNetworkModel : MultipeerConnectionNetworkModel

@property (nonatomic, strong) MCAdvertiserAssistant* advertiserAssistant;

-(void)hostGame;

@end
