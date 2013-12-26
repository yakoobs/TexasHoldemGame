//
//  GameModel.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 22/12/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "GameModel.h"
#import "Player.h"

const NSUInteger kInitialChipsAmount = 1500;

@interface GameModel()

@property(nonatomic) NSUInteger blindsLevel;

@end



@implementation GameModel

-(id)initWithPlayersNames:(NSArray*)paramPlayersNames
{
    self = [self init];
    
    if (self)
    {
        _board = [[Board alloc] initWithPlayersNames:paramPlayersNames
                                        initialStack:kInitialChipsAmount
                                          smallBlind:self.smallBlind
                                         andDelegate:self];
        
        [self setGameState:GameStateSettingPositions];
        self.blindsLevel = 0;
    }
    
    return self;
}

#pragma mark - Game State setter
-(void)setGameState:(GameStateType)gameState
{
    _gameState = gameState;
    
    switch (gameState)
    {
        case GameStateSettingPositions:
            [self performSettingPostitonsState];
            break;
        case GameStateStartingNewHandCards:
            [self performStartingNewHandState];
            break;
        case GameStatePreFlop:
            [self performPreFlopState];
            break;
        case GameStatePreFlopStateFinished:
            [self performPreFlopStateFinished];
            break;
        case GameStateFlopShown:
            [self performFlopShownState];
            break;
        case GameStateFlopShownStateFinished:
            [self performFlopShownStateFinished];
            break;
        case GameStateTurnShown:
            [self performTurnShownState];
            break;
        case GameStateTurnShownStateFinished:
            [self performTurnShownStateFinished];
            break;
        case GameStateRiverShown:
            [self performRiverShownState];
            break;
        case GameStateRiverShownStateFinished:
            [self performRiverShownStateFinished];
            break;
        case GameStateEndOfTheHand:
            [self performEndOfTheHandState];
            break;
        case GameStatePlayerEliminated:
            [self performPlayerEliminatedState];
            break;
        case GameStateEndOfTournament:
            [self performEndOfTournamentState];
            break;
            
        default:
            break;
    }
}


#pragma mark - Blinds
-(NSArray*)smallBlinds
{
    return @[@10, @20, @30, @40, @50, @75, @100, @125, @150, @200, @250, @300, @400, @500, @750];
}

-(NSUInteger)smallBlind
{
    return [[self.smallBlinds objectAtIndex:self.blindsLevel] unsignedIntegerValue];
}

-(NSUInteger)bigBlind
{
    return (self.smallBlind * 2);
}

#pragma mark - Executing states methods
-(void)performSettingPostitonsState
{
    [self.board updateDealerPosition];
    
    [self setGameState:GameStateStartingNewHandCards];
}

-(void)performStartingNewHandState
{
    [self.board startNewHand];
    
    [self setGameState:GameStatePreFlop];
}

-(void)performPreFlopState
{
    [self.board selectPreFlopActivePlayer];
    
    
}

-(void)performPreFlopStateFinished
{
    
    [self setGameState:GameStateFlopShown];
}

-(void)performFlopShownState
{
    [self.board drawFlopCards];
    [self.board selectPostFlopActivePlayer];
    
}

-(void)performFlopShownStateFinished
{
    
    [self setGameState:GameStateTurnShown];
}

-(void)performTurnShownState
{
    [self.board drawTurnCard];

}

-(void)performTurnShownStateFinished
{
    
    [self setGameState:GameStateRiverShown];
}

-(void)performRiverShownState
{
    [self.board drawRiverCard];
}

-(void)performRiverShownStateFinished
{
    [self setGameState:GameStateEndOfTheHand];
}

-(void)performEndOfTheHandState
{
    
}

-(void)performPlayerEliminatedState
{
    
}

-(void)performEndOfTournamentState
{
    
}

#pragma mark - betting round methods
-(void)activateNextPlayer
{
    [self.board activateNextPlayer];
}

-(void)activePlayerChoseFold
{
    [self.board activePlayerChoseFold];
    [self activateNextPlayer];
}

-(void)activePlayerChoseCheck
{
    [self.board activePlayerChoseCheck];
    [self activateNextPlayer];
}

-(void)activePlayerChoseCall
{
    [self.board activePlayerChoseCall];
    [self activateNextPlayer];

}

-(void)activePlayerChoseBetWithTheAmountOf:(NSUInteger)paramAmount
{
    [self.board activePlayerChoseBetWithTheAmountOf:(NSUInteger)paramAmount];
    [self activateNextPlayer];

}

-(void)activePlayerChoseRaiseWithTheAmountOf:(NSUInteger)paramAmount
{
    [self.board activePlayerChoseRaiseWithTheAmountOf:(NSUInteger)paramAmount];
    [self activateNextPlayer];

}

-(void)activePlayerChoseAllIn
{
    [self.board activePlayerChoseAllIn];
    [self activateNextPlayer];
}


#pragma mark - BoardGameProtocol methods
-(void)performEndOfBettingRound
{
    switch (self.gameState)
    {
        case GameStatePreFlop:
            self.gameState = GameStatePreFlopStateFinished;
            break;
            
        case GameStateFlopShown:
            self.gameState = GameStateFlopShownStateFinished;
            break;
            
        case GameStateTurnShown:
            self.gameState = GameStateTurnShownStateFinished;
            break;
            
        case GameStateRiverShown:
            self.gameState = GameStateRiverShownStateFinished;
            break;
            
        default:
            break;
    }
}

-(void)allOpponentsFolded
{
    self.gameState = GameStateEndOfTheHand;
}
@end
