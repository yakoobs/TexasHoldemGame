//
//  Player.h
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 01/12/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSArray* cardsInTheHand;
@property NSUInteger stack;
@property NSUInteger sittingPositionRegardingToDealer;
@property (nonatomic, getter = isNotFolded) BOOL notFolded;
@property (nonatomic, getter = isMyTurn) BOOL myTurn;

/**
 * Initialize Player* object with custom parameters.
 * @param (NSString*)paramName name property of the Player object
 * @param (NSUInteger)paramStack amount of chips in init stack of Player object
 */
-(id)initWithName:(NSString*)paramName stack:(NSUInteger)paramStack;

@end
