//
//  Board.h
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 01/12/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Player.h"

@protocol BoardGameProtocol <NSObject>

/**
 * Called when all players made their decision in particular betting round.
 */
-(void)performEndOfBettingRound;

/**
 * Called when all players except one folded their hands
 */
-(void)allOpponentsFolded;

@end

@interface Board : NSObject

@property (nonatomic,strong) Deck* deck;
@property (nonatomic) NSUInteger pot;
@property (nonatomic) NSUInteger smallBlind;
@property (nonatomic) NSUInteger bigBlind;
/**
 * Array of Card* objects which are common for all players (flop, turn and river)
 */
@property (strong, nonatomic) NSMutableArray* communityCards;
/**
 * Array of Player* objects which still are taking part in tournament
 */
@property (strong, nonatomic) NSMutableArray* players;

/**
 * Array of Player* objects which still are taking part in current hand and have cards.
 * Depends on Player* (BOOL)notFolded (isNotFolded) property
 */
@property (strong, nonatomic) NSMutableArray* playersWithCards;

/**
 *Instance of Player* which actually have decision to made
 */
@property (weak, nonatomic) Player* activePlayerWithDecision;

/**
 * YES when only two players left in tournament
 */
@property (nonatomic) BOOL headsUp;

@property (nonatomic,weak) id <BoardGameProtocol> delegate;

/**
 * Custom init method
 * @param (NSArray*)paramPlayersNames is an array of player names
 * @param (NSUInteger)paramInitialStack defines initial stack for each player
 * @param (NSUInteger)paramSmallBlind is the initial small blind in tournament, big blind is automatically multiply by 2
 * @param (id<BoardGameProtocol>)paramDelegate defines delegate to game model
 */
-(id)initWithPlayersNames:(NSArray*)paramPlayersNames
             initialStack:(NSUInteger)paramInitialStack
               smallBlind:(NSUInteger)paramSmallBlind
              andDelegate:(id<BoardGameProtocol>)paramDelegate;

/**
 * Move dealer position one position clockwise
 */
-(void)updateDealerPosition;

/**
 * Reset deck and deal cards for players.
 */
-(void)startNewHand;
-(void)selectPreFlopActivePlayer;

-(void)drawFlopCards;
-(void)drawTurnCard;
-(void)drawRiverCard;

-(void)activateNextPlayer;
-(void)activePlayerChoseFold;
-(void)activePlayerChoseCheck;
-(void)activePlayerChoseCall;
-(void)activePlayerChoseBetWithTheAmountOf:(NSUInteger)paramAmount;
-(void)activePlayerChoseRaiseWithTheAmountOf:(NSUInteger)paramAmount;
-(void)activePlayerChoseAllIn;

@end
