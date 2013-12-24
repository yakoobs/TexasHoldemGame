//
//  GameModelTests.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 23/12/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GameModel.h"

@interface GameModelTests : XCTestCase

@property(nonatomic, strong) GameModel* gameModel2;
@property(nonatomic, strong) GameModel* gameModel3;
@property(nonatomic, strong) GameModel* gameModel4;
@property(nonatomic, strong) GameModel* gameModel6;

@end

@implementation GameModelTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

#pragma mark - create game model methods
-(void)createGameModelWithTwoPlayers
{
    NSArray* playerNames = @[ @"player1", @"player2"];
    self.gameModel2 = [[GameModel alloc]initWithPlayersNames:playerNames];
}

-(void)createGameModelWithThreePlayers
{
    NSArray* playerNames = @[ @"player1", @"player2", @"player3"];
    self.gameModel3 = [[GameModel alloc]initWithPlayersNames:playerNames];
}

-(void)createGameModelWithFourPlayers
{
    NSArray* playerNames = @[ @"player1", @"player2", @"player3", @"player4"];
    self.gameModel4 = [[GameModel alloc]initWithPlayersNames:playerNames];
}


-(void)createGameModelWithSixPlayers
{
    NSArray* playerNames = @[ @"player1", @"player2", @"player3", @"player4", @"player5", @"player6" ];
    self.gameModel6 = [[GameModel alloc]initWithPlayersNames:playerNames];
}


#pragma  mark - test methods
- (void)testCreateGameModel
{
    [self createGameModelWithTwoPlayers];
    
    XCTAssertNotNil(self.gameModel2, @"self.gameModel initialized as nil");
    XCTAssertNotNil(self.gameModel2.board, @"self.gameModel.board initialized as nil");
    XCTAssertNotNil(self.gameModel2.board.players, @"self.gameModel.board.players initialized as nil");
    XCTAssertNotNil(self.gameModel2.board.playersWithCards, @"self.gameModel.board.playersWithCards initialized as nil");
    

    [self createGameModelWithThreePlayers];
    
    XCTAssertNotNil(self.gameModel3, @"self.gameModel initialized as nil");
    XCTAssertNotNil(self.gameModel3.board, @"self.gameModel.board initialized as nil");
    XCTAssertNotNil(self.gameModel3.board.players, @"self.gameModel.board.players initialized as nil");
    XCTAssertNotNil(self.gameModel3.board.playersWithCards, @"self.gameModel.board.playersWithCards initialized as nil");
    
    [self createGameModelWithFourPlayers];
    
    XCTAssertNotNil(self.gameModel4, @"self.gameModel initialized as nil");
    XCTAssertNotNil(self.gameModel4.board, @"self.gameModel.board initialized as nil");
    XCTAssertNotNil(self.gameModel4.board.players, @"self.gameModel.board.players initialized as nil");
    XCTAssertNotNil(self.gameModel4.board.playersWithCards, @"self.gameModel.board.playersWithCards initialized as nil");
    
    [self createGameModelWithSixPlayers];
    
    XCTAssertNotNil(self.gameModel6, @"self.gameModel initialized as nil");
    XCTAssertNotNil(self.gameModel6.board, @"self.gameModel.board initialized as nil");
    XCTAssertNotNil(self.gameModel6.board.players, @"self.gameModel.board.players initialized as nil");
    XCTAssertNotNil(self.gameModel6.board.playersWithCards, @"self.gameModel.board.playersWithCards initialized as nil");
    
}

-(void)testInitialGameStates;
{
    [self createGameModelWithTwoPlayers];
    XCTAssertTrue(self.gameModel2.gameState == GameStatePreFlop, @"Incorrect state after game model initialisation");
    XCTAssertTrue(self.gameModel2.board.activePlayer.sittingPositionRegardingToDealer == 0, @"Incorrect position of player with first decision");
    
    [self createGameModelWithThreePlayers];
    XCTAssertTrue(self.gameModel3.gameState == GameStatePreFlop, @"Incorrect state after game model initialisation");
    XCTAssertTrue(self.gameModel3.board.activePlayer.sittingPositionRegardingToDealer == 0, @"Incorrect position of player with first decision");

    
    [self createGameModelWithFourPlayers];
    XCTAssertTrue(self.gameModel4.gameState == GameStatePreFlop, @"Incorrect state after game model initialisation");
    XCTAssertTrue(self.gameModel4.board.activePlayer.sittingPositionRegardingToDealer == 3, @"Incorrect position of player with first decision");
    
    [self createGameModelWithSixPlayers];
    XCTAssertTrue(self.gameModel6.gameState == GameStatePreFlop, @"Incorrect state after game model initialisation");
    XCTAssertTrue(self.gameModel6.board.activePlayer.sittingPositionRegardingToDealer == 3, @"Incorrect position of player with first decision");

}

-(void)testAllFoldsAtTheBeginning
{
    [self createGameModelWithTwoPlayers];
    [self.gameModel2 activePlayerChoseFold];
    XCTAssertTrue(self.gameModel2.gameState == GameStateEndOfTheHand, @"Hand should have ended because all opponents folded");
    
    [self createGameModelWithThreePlayers];
    [self.gameModel3 activePlayerChoseFold];
    [self.gameModel3 activePlayerChoseFold];
    XCTAssertTrue(self.gameModel3.gameState == GameStateEndOfTheHand, @"Hand should have ended because all opponents folded");

    [self createGameModelWithFourPlayers];
    [self.gameModel4 activePlayerChoseFold];
    [self.gameModel4 activePlayerChoseFold];
    [self.gameModel4 activePlayerChoseFold];
    XCTAssertTrue(self.gameModel4.gameState == GameStateEndOfTheHand, @"Hand should have ended because all opponents folded");
    
    
    [self createGameModelWithSixPlayers];
    [self.gameModel6 activePlayerChoseFold];
    [self.gameModel6 activePlayerChoseFold];
    [self.gameModel6 activePlayerChoseFold];
    [self.gameModel6 activePlayerChoseFold];
    [self.gameModel6 activePlayerChoseFold];
    XCTAssertTrue(self.gameModel6.gameState == GameStateEndOfTheHand, @"Hand should have ended because all opponents folded");
}

-(void)testAllGoesAllInAtTheBeginning
{
    [self createGameModelWithTwoPlayers];
    [self.gameModel2 activePlayerChoseAllIn];
    [self.gameModel2 activePlayerChoseAllIn];
    XCTAssertTrue(self.gameModel2.gameState == GameStateFlopShown, @"flop should have been shown");
    
    [self createGameModelWithThreePlayers];
    [self.gameModel3 activePlayerChoseAllIn];
    [self.gameModel3 activePlayerChoseAllIn];
    [self.gameModel3 activePlayerChoseAllIn];
    XCTAssertTrue(self.gameModel3.gameState == GameStateFlopShown, @"flop should have been shown");
    
    
    [self createGameModelWithFourPlayers];
    [self.gameModel4 activePlayerChoseAllIn];
    [self.gameModel4 activePlayerChoseAllIn];
    [self.gameModel4 activePlayerChoseAllIn];
    [self.gameModel4 activePlayerChoseAllIn];
    XCTAssertTrue(self.gameModel4.gameState == GameStateFlopShown, @"flop should have been shown");
    
    
    [self createGameModelWithSixPlayers];
    [self.gameModel6 activePlayerChoseAllIn];
    [self.gameModel6 activePlayerChoseAllIn];
    [self.gameModel6 activePlayerChoseAllIn];
    [self.gameModel6 activePlayerChoseAllIn];
    [self.gameModel6 activePlayerChoseAllIn];
    [self.gameModel6 activePlayerChoseAllIn];
    XCTAssertTrue(self.gameModel6.gameState == GameStateFlopShown, @"flop should have been shown");
}
@end
