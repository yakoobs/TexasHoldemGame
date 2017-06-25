//
//  Player.h
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 01/12/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PlayerOnTableState)
{
    PlayerStateWaitingForTheirTurn,
    PlayerStateMakingDecision,
    PlayerStateCall,
    PlayerStateCheck,
    PlayerStateRaiseOrBet,
    PlayerStateAllIn,
    PlayerStateWaitingNextHand,
};

@interface Player : NSObject

@property (nonatomic) NSUInteger uniqueID;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSArray* cardsInTheHand;
@property NSUInteger stack;
@property NSUInteger amountBettedInThisRound;
@property NSUInteger sittingPositionRegardingToDealer;
@property (nonatomic) PlayerOnTableState playerState;

/**
 * Initialize Player* object with custom parameters.
 * @param (NSString*)paramName name property of the Player object
 * @param (NSUInteger)paramStack amount of chips in init stack of Player object
 */
-(instancetype)initWithName:(NSString*)paramName stack:(NSUInteger)paramStack;

-(void)playerGoesAllIn;

-(void)playerBetsAmount:(NSUInteger)paramAmount;

-(void)playerCallsAmount:(NSUInteger)paramAmount;

@end
