//
//  GameModel.h
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 22/12/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Board.h"

typedef NS_ENUM(NSInteger, GameStateType)
{
    GameStateSettingPositions,
    GameStateStartingNewHandCards,
    GameStatePreFlop,
    GameStatePreFlopStateFinished,
    GameStateFlopShown,
    GameStateFlopShownStateFinished,
    GameStateTurnShown,
    GameStateTurnShownStateFinished,
    GameStateRiverShown,
    GameStateRiverShownStateFinished,
    GameStateEndOfTheHand,
    GameStatePlayerEliminated,
    GameStateEndOfTournament
};

@interface GameLogicModel : NSObject<BoardGameProtocol>

@property(nonatomic,strong) Board* board;
@property(nonatomic) GameStateType gameState;
@property(nonatomic) NSUInteger smallBlind;
@property(nonatomic) NSUInteger bigBlind;

-(instancetype)initWithPlayersNames:(NSArray*)paramPlayersNames;
-(void)activateNextPlayer;
-(void)activePlayerChoseFold;
-(void)activePlayerChoseCheck;
-(void)activePlayerChoseCall;
-(void)activePlayerChoseBetWithTheAmountOf:(NSUInteger)paramAmount;
-(void)activePlayerChoseRaiseWithTheAmountOf:(NSUInteger)paramAmount;
-(void)activePlayerChoseAllIn;

@end
