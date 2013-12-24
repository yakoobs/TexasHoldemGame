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

@property (nonatomic) BOOL betWasMade;
@property (nonatomic) NSUInteger amountOfChipsToCall;

@end

@implementation Board

-(id)initWithPlayersNames:(NSArray*)paramPlayersNames
             initialStack:(NSUInteger)paramInitialStack
               smallBlind:(NSUInteger)paramSmallBlind
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
    self.smallBlind = paramSmallBlind;
    self.bigBlind = (paramSmallBlind * 2);
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
    [self updatePlayersWithCards];
}

-(void)dealTwoCardsForEachPlayer
{
    for (Player* player in self.players)
    {
        NSMutableArray* twoCards = [[NSMutableArray alloc]initWithCapacity:2];
        [twoCards addObject:[self.deck drawRandomCardAndRemoveItFromDeck]];
        [twoCards addObject:[self.deck drawRandomCardAndRemoveItFromDeck]];
        
        player.cardsInTheHand = twoCards;
        player.playerState = PlayerStateWaitingForTheirTurn;
    }
}


-(void)updatePlayersWithCards
{
    [self.playersWithCards removeAllObjects];
    for (Player* player in self.players)
    {
        if (player.playerState != PlayerStateWaitingNextHand)
        {
            [self.playersWithCards addObject:player];
        }
    }
}

-(void)selectPreFlopActivePlayer
{
    self.positionOfFirstPlayerWithDecision = 0;
    NSUInteger smallBlindPosition = 1;
    NSUInteger bigBlindPosition = 2;
    
    if (self.players.count > 3)
    {
        self.positionOfFirstPlayerWithDecision = 3;//UTG position
    }
    else if(self.players.count == 2)
    {
        smallBlindPosition = 0;
        bigBlindPosition = 1;
    }
    
    for (Player* player in self.playersWithCards)
    {
        if (player.sittingPositionRegardingToDealer == smallBlindPosition)
        {
            [self collectSmallBlindFromPlayer:player];
        }else if (player.sittingPositionRegardingToDealer == bigBlindPosition)
        {
            [self collectBigBlindFromPlayer:player];
        }
        
        if (player.sittingPositionRegardingToDealer == self.positionOfFirstPlayerWithDecision)
        {
            if (player.playerState != PlayerStateAllIn)
            {
                self.activePlayer = player;
                player.playerState = PlayerStateMakingDecision;
            }
            else
            {
                [self activateNextPlayer];
            }
        }
    }
}

-(void)collectSmallBlindFromPlayer:(Player*)paramPlayer
{
    if (self.smallBlind < paramPlayer.stack)
    {
        paramPlayer.stack -= self.smallBlind;
        paramPlayer.amountBettedInThisRound = self.smallBlind;
    }
        else
    {
        paramPlayer.amountBettedInThisRound = paramPlayer.stack;
        paramPlayer.stack = 0;
        paramPlayer.playerState = PlayerStateAllIn;
    }
}

-(void)collectBigBlindFromPlayer:(Player*)paramPlayer
{
    if (self.bigBlind < paramPlayer.stack)
    {
        paramPlayer.stack -= self.bigBlind;
        paramPlayer.amountBettedInThisRound = self.bigBlind;
    }
    else
    {
        paramPlayer.amountBettedInThisRound = paramPlayer.stack;
        paramPlayer.stack = 0;
        paramPlayer.playerState = PlayerStateAllIn;
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


#pragma mark - betting round methods
-(void)activateNextPlayer
{

    NSUInteger newActivePlayerPosition = self.activePlayer.sittingPositionRegardingToDealer + 1;
    if (newActivePlayerPosition > self.players.count - 1)
    {
        newActivePlayerPosition = 0;
    }
    
    if (newActivePlayerPosition == self.positionOfFirstPlayerWithDecision)
    {
        [self.delegate performEndOfBettingRound];
    }
    else
    {
        self.activePlayer = [self returnPlayerWithCardsOnPosition:newActivePlayerPosition];
        if (self.activePlayer.playerState != PlayerStateWaitingForTheirTurn)
        {
            [self activateNextPlayer];
        }
    }
}

-(Player*)returnPlayerWithCardsOnPosition:(NSUInteger)paramPosition
{
    Player* playerObject;
    for (Player* player in self.playersWithCards)
    {
        if (player.sittingPositionRegardingToDealer == paramPosition) {
            playerObject = player;
        }
    }
    return playerObject;
}

-(void)activePlayerChoseFold
{
    self.pot += self.activePlayer.amountBettedInThisRound;
    self.activePlayer.amountBettedInThisRound = 0;
    self.activePlayer.playerState = PlayerStateWaitingNextHand;
    [self.playersWithCards removeObject:self.activePlayer];
    if (self.playersWithCards.count == 1)
    {
        [self lastManStandingIsTakingThePot];
    }
}

-(void)activePlayerChoseCheck
{
    self.activePlayer.playerState = PlayerStateCheck;
}

-(void)activePlayerChoseCall
{
    if (self.amountOfChipsToCall >= self.activePlayer.stack)
    {
        [self.activePlayer playerGoesAllIn];
    }
    else
    {
        [self.activePlayer playerCallsAmount:self.amountOfChipsToCall];
    }
}

-(void)activePlayerChoseBetWithTheAmountOf:(NSUInteger)paramAmount
{
    self.betWasMade = YES;
    for (Player* player in self.playersWithCards)
    {
        player.playerState = PlayerStateWaitingForTheirTurn;
    }
    
    [self.activePlayer playerBetsAmount:paramAmount];
    
    self.amountOfChipsToCall = self.activePlayer.amountBettedInThisRound;
    self.positionOfFirstPlayerWithDecision = self.activePlayer.sittingPositionRegardingToDealer;
}

-(void)activePlayerChoseRaiseWithTheAmountOf:(NSUInteger)paramAmount
{
    [self activePlayerChoseBetWithTheAmountOf:paramAmount];
}

-(void)activePlayerChoseAllIn
{
    self.betWasMade = YES;
    [self.activePlayer playerGoesAllIn];
    self.amountOfChipsToCall = self.activePlayer.amountBettedInThisRound;
    self.positionOfFirstPlayerWithDecision = self.activePlayer.sittingPositionRegardingToDealer;
}

-(void)lastManStandingIsTakingThePot
{
    Player * player = [self.playersWithCards objectAtIndex:0];
    player.stack += self.pot;
    player.playerState = PlayerStateWaitingNextHand;
    [self.delegate allOpponentsFolded];
}
@end
