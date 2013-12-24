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


-(void)playerGoesAllIn
{
    self.amountBettedInThisRound += self.stack;
    self.stack = 0;
    self.playerState = PlayerStateAllIn;
}

-(void)playerBetsAmount:(NSUInteger)paramAmount
{
    self.playerState = PlayerStateRaiseOrBet;
    self.amountBettedInThisRound = paramAmount;
    self.stack = paramAmount;
}

-(void)playerCallsAmount:(NSUInteger)paramAmount
{
    if (paramAmount >= self.stack)
    {
        [self playerGoesAllIn];
    }
    else
    {
        self.amountBettedInThisRound = paramAmount;
        self.stack -= paramAmount;
        self.playerState = PlayerStateCall;
    }
}


@end
