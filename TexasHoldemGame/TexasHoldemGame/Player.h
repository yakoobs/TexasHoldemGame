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
    PlayerStateRaise,
    PlayerStateAllIn,
    PlayerStateWaitingNextHand,
};

@interface Player : NSObject

@property (nonatomic, strong) NSString* uniqueID;
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
-(id)initWithName:(NSString*)paramName stack:(NSUInteger)paramStack;

@end
