//
//  Board.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 01/12/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "Board.h"
#import "Player.h"

@interface Board()

/**
 * This property describes which player has made first decision,
 * or which player's decision (like bet/all in) is under investigation.
 */
@property (nonatomic) NSUInteger positionOfFirstPlayerWithDecision;

@end

@implementation Board

-(id)initWithPlayersNames:(NSArray*)paramPlayersNames
             initialStack:(NSUInteger)paramInitialStack
              andDelegate:(id<BoardGameProtocol>)paramDelegate
{
    self = [self init];
    
    NSMutableArray* tempPlayers = [[NSMutableArray alloc]init];
   
    for (NSString* playerName in paramPlayersNames)
    {
        Player * player = [[Player alloc] initWithName:playerName stack:paramInitialStack];
        player.sittingPositionRegardingToDealer = [tempPlayers count];//TODO: randomize players sitting positions
        [tempPlayers addObject:player];
    }
    
    self.players = tempPlayers;
    [self updateActivePlayers];
    self.delegate = paramDelegate;
    return self;
}

#pragma mark - getters
-(NSMutableArray*)players
{
    if (!_players)
    {
        _players = [[NSMutableArray alloc]init];
    }
    return _players;
}

-(NSMutableArray*)playersWithCards
{
    if (!_playersWithCards)
    {
        _playersWithCards = [[NSMutableArray alloc]init];
    }
    
    return _playersWithCards;
}

-(Deck*)deck
{
    if (!_deck) {
        _deck = [[Deck alloc]init];
    }
    return _deck;
}

-(NSMutableArray*)communityCards
{
    if (!_communityCards) {
        _communityCards = [[NSMutableArray alloc]init];
    }
    return _communityCards;
}


#pragma mark - related with game model methods
-(void)updateDealerPosition
{
    for (Player* player in self.players)
    {
        if (player.sittingPositionRegardingToDealer == 0)
        {
            player.sittingPositionRegardingToDealer = self.players.count-1;
        }
        else
        {
            player.sittingPositionRegardingToDealer--;
        }
    }
}

-(void)startNewHand
{
    self.pot = 0;
    [self.deck resetDeck];
    [self dealTwoCardsForEachPlayer];
}

-(void)dealTwoCardsForEachPlayer
{
    for (Player* player in self.players)
    {
        NSMutableArray* twoCards = [[NSMutableArray alloc]initWithCapacity:2];
        [twoCards addObject:[self.deck drawRandomCardAndRemoveItFromDeck]];
        [twoCards addObject:[self.deck drawRandomCardAndRemoveItFromDeck]];
        
        player.cardsInTheHand = twoCards;
    }
}

-(void)selectPreFlopActivePlayer
{
    self.positionOfFirstPlayerWithDecision = 0;
    if (self.players.count > 3)
    {
        self.positionOfFirstPlayerWithDecision = 3;//UTG position
    }
    
    for (Player* player in self.players)
    {
        if (player.sittingPositionRegardingToDealer == self.positionOfFirstPlayerWithDecision)
        {
            self.activePlayerWithDecision = player;
            player.myTurn = YES;
        }
    }
}

-(void)drawFlopCards
{
    NSMutableArray * threeCards = [[NSMutableArray alloc]initWithCapacity:3];
    [threeCards addObject:[self.deck drawRandomCardAndRemoveItFromDeck]];
    [threeCards addObject:[self.deck drawRandomCardAndRemoveItFromDeck]];
    [threeCards addObject:[self.deck drawRandomCardAndRemoveItFromDeck]];
    
    [self.communityCards addObjectsFromArray:threeCards];
}

-(void)drawTurnCard
{
    Card* turnCard = [self.deck drawRandomCardAndRemoveItFromDeck];
    [self.communityCards addObject:turnCard];

}

-(void)drawRiverCard
{
    Card* riverCard = [self.deck drawRandomCardAndRemoveItFromDeck];
    [self.communityCards addObject:riverCard];
}

-(void)updateActivePlayers
{
    [self.playersWithCards removeAllObjects];
    for (Player* player in self.players)
    {
        if (player.isNotFolded)
        {
            [self.playersWithCards addObject:player];
        }
    }
}


#pragma mark - betting round methods
-(void)activateNextPlayer
{
    [self updateActivePlayers];
    
    NSUInteger newActivePlayerPosition = self.activePlayerWithDecision.sittingPositionRegardingToDealer + 1;
    if (newActivePlayerPosition > self.playersWithCards.count - 1)
    {
        newActivePlayerPosition = 0;
    }
    if (newActivePlayerPosition == self.positionOfFirstPlayerWithDecision)
    {
        [self.delegate performEndOfBettingRound];
    }
}

-(void)activePlayerChoseFold
{
    self.activePlayerWithDecision.notFolded = NO;
    self.activePlayerWithDecision.myTurn = NO;
    [self.playersWithCards removeObject:self.activePlayerWithDecision];
}

-(void)activePlayerChoseCheck
{
    
}

-(void)activePlayerChoseCall
{
    
}

-(void)activePlayerChoseBetWithTheAmountOf:(NSUInteger)paramAmount
{
    self.positionOfFirstPlayerWithDecision = self.activePlayerWithDecision.sittingPositionRegardingToDealer;

}

-(void)activePlayerChoseRaiseWithTheAmountOf:(NSUInteger)paramAmount
{
    self.positionOfFirstPlayerWithDecision = self.activePlayerWithDecision.sittingPositionRegardingToDealer;

}

-(void)activePlayerChoseAllIn
{
    self.positionOfFirstPlayerWithDecision = self.activePlayerWithDecision.sittingPositionRegardingToDealer;
}

@end
