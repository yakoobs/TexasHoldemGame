//
//  Player.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 01/12/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "Player.h"

@implementation Player

-(id)initWithName:(NSString*)paramName stack:(NSUInteger)paramStack
{
    self = [self init];
    
    self.name = paramName;
    self.stack = paramStack;
    self.playerState = PlayerStateWaitingNextHand;
    
    return self;
}

-(NSString*)name
{
    if (!_name) {
        _name = [[NSString alloc]init];
    }
    return _name;
}

-(NSArray*)cardsInTheHand
{
    if (!_cardsInTheHand) {
        _cardsInTheHand = [[NSArray alloc]init];
    }
    return _cardsInTheHand;
}

@end
