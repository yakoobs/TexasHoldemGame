//
//  CardCombinationTest.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 24/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Deck.h"
#import "CardCombination.h"
#import <objc/runtime.h>



/**
 * Category only for test purposes
 */
@interface CardCombination (Testing)

/**
 * Not visible in public interface methods of CardCombination class,
 */
-(BOOL)checkForFlush:(NSArray*)paramCardsToEvaluate;
-(BOOL)checkForStraight:(NSArray*)paramCardsToEvaluate;
-(BOOL)checkForStraightFlush:(NSArray*)paramCardsToEvaluate;
-(BOOL)checkForFourOfKind:(NSArray*)paramCardsToEvaluate;
-(BOOL)checkForThreeOfKind:(NSArray*)paramCardsToEvaluate;
-(BOOL)checkForFullHouse:(NSArray*)paramCardsToEvaluate;
-(BOOL)checkForTwoPairs:(NSArray*)paramCardsToEvaluate;
-(BOOL)checkForPair:(NSArray*)paramCardsToEvaluate;

@end


@interface CardCombinationTest : XCTestCase

@end

@implementation CardCombinationTest

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
-(void)testStraightFlushValidation
{
    Card* card1 = [[Card alloc]initWithRank:@"2" suit:@"h" andValue:2];
    Card* card2 = [[Card alloc]initWithRank:@"A" suit:@"h" andValue:14];
    Card* card3 = [[Card alloc]initWithRank:@"4" suit:@"h" andValue:4];
    Card* card4 = [[Card alloc]initWithRank:@"5" suit:@"h" andValue:5];
    Card* card5 = [[Card alloc]initWithRank:@"6" suit:@"h" andValue:6];
    Card* card6 = [[Card alloc]initWithRank:@"7" suit:@"s" andValue:7];
    Card* card7 = [[Card alloc]initWithRank:@"3" suit:@"h" andValue:3];
    
    NSArray *cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    CardCombination* cardCombination = [[CardCombination alloc]initWithCardsToEvaluate:cardsForValidation];
    XCTAssertTrue([cardCombination checkForStraightFlush:cardsForValidation], @"should be a straight flush!");
    
    card1.suit = @"c"; card1.value = 3;
    card2.suit = @"h"; card2.value = 4;
    card3.suit = @"h"; card3.value = 14;
    card4.suit = @"s"; card4.value = 9;
    card5.suit = @"h"; card5.value = 2;
    card6.suit = @"h"; card6.value = 3;
    card7.suit = @"h"; card7.value = 5;
    
    cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    cardCombination.cardsToEvaluate = cardsForValidation;
    XCTAssertTrue([cardCombination checkForStraightFlush:cardsForValidation], @"should be a wheel straight flush!");
    
    
    card1.suit = @"c"; card1.value = 3;
    card2.suit = @"s"; card2.value = 4;
    card3.suit = @"s"; card3.value = 6;
    card4.suit = @"s"; card4.value = 9;
    card5.suit = @"s"; card5.value = 8;
    card6.suit = @"s"; card6.value = 3;
    card7.suit = @"s"; card7.value = 5;
    cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    cardCombination.cardsToEvaluate = cardsForValidation;
    XCTAssertFalse([cardCombination checkForStraightFlush: cardsForValidation], @"shouldn't be a straight flush!");
    
    card1.suit = @"s"; card1.value = 3;
    card2.suit = @"s"; card2.value = 4;
    card3.suit = @"h"; card3.value = 11;
    card4.suit = @"h"; card4.value = 9;
    card5.suit = @"h"; card5.value = 2;
    card6.suit = @"h"; card6.value = 3;
    card7.suit = @"h"; card7.value = 5;
    cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    cardCombination.cardsToEvaluate = cardsForValidation;
    XCTAssertFalse([cardCombination checkForStraightFlush: cardsForValidation], @"shouldn't be a straight flush!");
    
    card1.suit = @"h"; card1.value = 3;
    card2.suit = @"h"; card2.value = 4;
    card3.suit = @"s"; card3.value = 14;
    card4.suit = @"s"; card4.value = 4;
    card5.suit = @"s"; card5.value = 2;
    card6.suit = @"s"; card6.value = 3;
    card7.suit = @"s"; card7.value = 5;
    cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    cardCombination.cardsToEvaluate = cardsForValidation;
    XCTAssertTrue([cardCombination checkForStraightFlush: cardsForValidation], @"should be a straight flush!");
    
    card1.suit = @"h"; card1.value = 3;
    card2.suit = @"h"; card2.value = 4;
    card3.suit = @"s"; card3.value = 14;
    card4.suit = @"s"; card4.value = 4;
    card5.suit = @"s"; card5.value = 2;
    card6.suit = @"s"; card6.value = 3;
    card7.suit = @"s"; card7.value = 5;
    cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    cardCombination.cardsToEvaluate = cardsForValidation;
    XCTAssertTrue([cardCombination checkForStraightFlush: cardsForValidation], @"should be a straight flush!");
}

-(void)testFourOfKindValidation
{
    Card* card1 = [[Card alloc]initWithRank:@"2" suit:@"h" andValue:2];
    Card* card2 = [[Card alloc]initWithRank:@"A" suit:@"h" andValue:14];
    Card* card3 = [[Card alloc]initWithRank:@"A" suit:@"c" andValue:14];
    Card* card4 = [[Card alloc]initWithRank:@"5" suit:@"h" andValue:5];
    Card* card5 = [[Card alloc]initWithRank:@"6" suit:@"h" andValue:6];
    Card* card6 = [[Card alloc]initWithRank:@"A" suit:@"d" andValue:14];
    Card* card7 = [[Card alloc]initWithRank:@"A" suit:@"h" andValue:14];
    NSArray *cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    CardCombination* cardCombination = [[CardCombination alloc]initWithCardsToEvaluate:cardsForValidation];
    XCTAssertTrue([cardCombination checkForFourOfKind:cardsForValidation], @"should be a four of kind!");
    
    
    
    card1.rank = @"3"; card1.value = 3;
    card2.rank = @"4"; card2.value = 4;
    card3.rank = @"4"; card3.value = 4;
    card4.rank = @"4"; card4.value = 4;
    card5.rank = @"5"; card5.value = 5;
    card6.rank = @"5"; card6.value = 5;
    card7.rank = @"5"; card7.value = 5;
    cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    cardCombination.cardsToEvaluate = cardsForValidation;
    XCTAssertFalse([cardCombination checkForFourOfKind:cardsForValidation], @"shouldn't be a four of kind!");

}

-(void)testFullHouseValidation
{
    Card* card1 = [[Card alloc]initWithRank:@"2" suit:@"h" andValue:2];
    Card* card2 = [[Card alloc]initWithRank:@"A" suit:@"h" andValue:14];
    Card* card3 = [[Card alloc]initWithRank:@"A" suit:@"c" andValue:14];
    Card* card4 = [[Card alloc]initWithRank:@"5" suit:@"h" andValue:5];
    Card* card5 = [[Card alloc]initWithRank:@"6" suit:@"h" andValue:6];
    Card* card6 = [[Card alloc]initWithRank:@"A" suit:@"d" andValue:14];
    Card* card7 = [[Card alloc]initWithRank:@"A" suit:@"h" andValue:14];
    NSArray *cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    CardCombination* cardCombination = [[CardCombination alloc]initWithCardsToEvaluate:cardsForValidation];
    XCTAssertFalse([cardCombination checkForFullHouse:cardsForValidation], @"shouldn't be a full house!");
    
    
    
    card1.rank = @"3"; card1.value = 3;
    card2.rank = @"4"; card2.value = 4;
    card3.rank = @"4"; card3.value = 4;
    card4.rank = @"4"; card4.value = 4;
    card5.rank = @"5"; card5.value = 5;
    card6.rank = @"5"; card6.value = 5;
    card7.rank = @"5"; card7.value = 5;
    cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    cardCombination.cardsToEvaluate = cardsForValidation;
    XCTAssertTrue([cardCombination checkForFullHouse:cardsForValidation], @"should be a full house!");
}

-(void)testFlushValidation
{
    Card* card1 = [[Card alloc]initWithRank:@"2" suit:@"s" andValue:2];
    Card* card2 = [[Card alloc]initWithRank:@"A" suit:@"s" andValue:14];
    Card* card3 = [[Card alloc]initWithRank:@"4" suit:@"s" andValue:4];
    Card* card4 = [[Card alloc]initWithRank:@"5" suit:@"s" andValue:5];
    Card* card5 = [[Card alloc]initWithRank:@"6" suit:@"s" andValue:6];
    Card* card6 = [[Card alloc]initWithRank:@"7" suit:@"s" andValue:7];
    Card* card7 = [[Card alloc]initWithRank:@"K" suit:@"s" andValue:13];
    NSArray *cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    CardCombination* cardCombination = [[CardCombination alloc]initWithCardsToEvaluate:cardsForValidation];
    
    XCTAssertTrue([cardCombination checkForFlush:cardsForValidation], @"should be a Flush!");
    
    card1.suit = @"s";
    card2.suit = @"s";
    card3.suit = @"h";
    card4.suit = @"s";
    card5.suit = @"s";
    card6.suit = @"h";
    card7.suit = @"s";
    cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    cardCombination.cardsToEvaluate = cardsForValidation;
    
    XCTAssertTrue([cardCombination checkForFlush:cardsForValidation], @"should be a Flush!");
    
    
    card1.suit = @"h";
    card2.suit = @"h";
    card3.suit = @"h";
    card4.suit = @"s";
    card5.suit = @"s";
    card6.suit = @"h";
    card7.suit = @"s";
    cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    cardCombination.cardsToEvaluate = cardsForValidation;
    XCTAssertFalse([cardCombination checkForFlush:cardsForValidation], @"shouldn't be a Flush!");
    
    card1.suit = @"d";
    card2.suit = @"h";
    card3.suit = @"d";
    card4.suit = @"s";
    card5.suit = @"d";
    card6.suit = @"h";
    card7.suit = @"d";
    cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    cardCombination.cardsToEvaluate = cardsForValidation;
    XCTAssertFalse([cardCombination checkForFlush:cardsForValidation], @"shouldn't be a Flush!");
    
    card1.suit = @"h";
    card2.suit = @"h";
    card3.suit = @"c";
    card4.suit = @"c";
    card5.suit = @"c";
    card6.suit = @"c";
    card7.suit = @"c";
    cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    cardCombination.cardsToEvaluate = cardsForValidation;
    XCTAssertTrue([cardCombination checkForFlush:cardsForValidation], @"should be a Flush!");
}

-(void)testStraightValidation
{
    Card* card1 = [[Card alloc]initWithRank:@"2" suit:@"h" andValue:2];
    Card* card2 = [[Card alloc]initWithRank:@"A" suit:@"h" andValue:14];
    Card* card3 = [[Card alloc]initWithRank:@"4" suit:@"s" andValue:4];
    Card* card4 = [[Card alloc]initWithRank:@"5" suit:@"s" andValue:5];
    Card* card5 = [[Card alloc]initWithRank:@"6" suit:@"h" andValue:6];
    Card* card6 = [[Card alloc]initWithRank:@"7" suit:@"s" andValue:7];
    Card* card7 = [[Card alloc]initWithRank:@"3" suit:@"s" andValue:3];
    
    NSArray *cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    CardCombination* cardCombination = [[CardCombination alloc]initWithCardsToEvaluate:cardsForValidation];
    XCTAssertTrue([cardCombination checkForStraight:cardsForValidation], @"should be a straight!");
    
    card1.rank = @"3"; card1.value = 3;
    card2.rank = @"4"; card2.value = 4;
    card3.rank = @"A"; card3.value = 14;
    card4.rank = @"9"; card4.value = 9;
    card5.rank = @"2"; card5.value = 2;
    card6.rank = @"3"; card6.value = 3;
    card7.rank = @"5"; card7.value = 5;
    
    cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    cardCombination.cardsToEvaluate = cardsForValidation;
    XCTAssertTrue([cardCombination checkForStraight:cardsForValidation], @"should be a wheel straight!");
    
    
    card1.rank = @"3"; card1.value = 3;
    card2.rank = @"4"; card2.value = 4;
    card3.rank = @"6"; card3.value = 6;
    card4.rank = @"9"; card4.value = 9;
    card5.rank = @"8"; card5.value = 8;
    card6.rank = @"3"; card6.value = 3;
    card7.rank = @"5"; card7.value = 5;
    cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    cardCombination.cardsToEvaluate = cardsForValidation;
    XCTAssertFalse([cardCombination checkForStraight: cardsForValidation], @"shouldn't be a straight!");
    
    card1.rank = @"3"; card1.value = 3;
    card2.rank = @"4"; card2.value = 4;
    card3.rank = @"K"; card3.value = 11;
    card4.rank = @"9"; card4.value = 9;
    card5.rank = @"2"; card5.value = 2;
    card6.rank = @"3"; card6.value = 3;
    card7.rank = @"5"; card7.value = 5;
    cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    cardCombination.cardsToEvaluate = cardsForValidation;
    XCTAssertFalse([cardCombination checkForStraight: cardsForValidation], @"shouldn't be a straight!");
    
    card1.rank = @"3"; card1.value = 3;
    card2.rank = @"4"; card2.value = 4;
    card3.rank = @"A"; card3.value = 14;
    card4.rank = @"4"; card4.value = 4;
    card5.rank = @"2"; card5.value = 2;
    card6.rank = @"3"; card6.value = 3;
    card7.rank = @"5"; card7.value = 5;
    cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    cardCombination.cardsToEvaluate = cardsForValidation;
    XCTAssertTrue([cardCombination checkForStraight: cardsForValidation], @"should be a straight!");
    
    card1.rank = @"3"; card1.value = 3;
    card2.rank = @"4"; card2.value = 4;
    card3.rank = @"A"; card3.value = 14;
    card4.rank = @"4"; card4.value = 4;
    card5.rank = @"2"; card5.value = 2;
    card6.rank = @"3"; card6.value = 3;
    card7.rank = @"5"; card7.value = 5;
    cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    cardCombination.cardsToEvaluate = cardsForValidation;
    XCTAssertTrue([cardCombination checkForStraight: cardsForValidation], @"should be a straight!");
}

-(void)testThreeOfKindValidation
{
    Card* card1 = [[Card alloc]initWithRank:@"2" suit:@"h" andValue:2];
    Card* card2 = [[Card alloc]initWithRank:@"A" suit:@"h" andValue:14];
    Card* card3 = [[Card alloc]initWithRank:@"Q" suit:@"c" andValue:12];
    Card* card4 = [[Card alloc]initWithRank:@"5" suit:@"h" andValue:5];
    Card* card5 = [[Card alloc]initWithRank:@"6" suit:@"h" andValue:6];
    Card* card6 = [[Card alloc]initWithRank:@"Q" suit:@"d" andValue:12];
    Card* card7 = [[Card alloc]initWithRank:@"A" suit:@"h" andValue:14];
    NSArray *cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    CardCombination* cardCombination = [[CardCombination alloc]initWithCardsToEvaluate:cardsForValidation];
    XCTAssertFalse([cardCombination checkForThreeOfKind:cardsForValidation], @"shouldn't be three fo kind!");
    
    
    
    card1.rank = @"3"; card1.value = 3;
    card2.rank = @"4"; card2.value = 4;
    card3.rank = @"4"; card3.value = 4;
    card4.rank = @"4"; card4.value = 4;
    card5.rank = @"6"; card5.value = 6;
    card6.rank = @"7"; card6.value = 7;
    card7.rank = @"9"; card7.value = 9;
    cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    cardCombination.cardsToEvaluate = cardsForValidation;
    XCTAssertTrue([cardCombination checkForThreeOfKind:cardsForValidation], @"should be three of kind!");
}

-(void)testTwoPairsValidation
{
    Card* card1 = [[Card alloc]initWithRank:@"2" suit:@"h" andValue:2];
    Card* card2 = [[Card alloc]initWithRank:@"A" suit:@"h" andValue:14];
    Card* card3 = [[Card alloc]initWithRank:@"Q" suit:@"c" andValue:12];
    Card* card4 = [[Card alloc]initWithRank:@"5" suit:@"h" andValue:5];
    Card* card5 = [[Card alloc]initWithRank:@"6" suit:@"h" andValue:6];
    Card* card6 = [[Card alloc]initWithRank:@"Q" suit:@"d" andValue:12];
    Card* card7 = [[Card alloc]initWithRank:@"K" suit:@"h" andValue:13];
    NSArray *cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    CardCombination* cardCombination = [[CardCombination alloc]initWithCardsToEvaluate:cardsForValidation];
    XCTAssertFalse([cardCombination checkForTwoPairs:cardsForValidation], @"shouldn't be two pairs!");
    
    
    
    card1.rank = @"3"; card1.value = 3;
    card2.rank = @"4"; card2.value = 4;
    card3.rank = @"4"; card3.value = 4;
    card4.rank = @"6"; card4.value = 6;
    card5.rank = @"6"; card5.value = 6;
    card6.rank = @"7"; card6.value = 7;
    card7.rank = @"9"; card7.value = 9;
    cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    cardCombination.cardsToEvaluate = cardsForValidation;
    XCTAssertTrue([cardCombination checkForTwoPairs:cardsForValidation], @"should be two pairs!");
}

-(void)testPairValidation
{
    Card* card1 = [[Card alloc]initWithRank:@"2" suit:@"h" andValue:2];
    Card* card2 = [[Card alloc]initWithRank:@"9" suit:@"h" andValue:9];
    Card* card3 = [[Card alloc]initWithRank:@"Q" suit:@"c" andValue:12];
    Card* card4 = [[Card alloc]initWithRank:@"5" suit:@"h" andValue:5];
    Card* card5 = [[Card alloc]initWithRank:@"6" suit:@"h" andValue:6];
    Card* card6 = [[Card alloc]initWithRank:@"J" suit:@"d" andValue:11];
    Card* card7 = [[Card alloc]initWithRank:@"K" suit:@"h" andValue:13];
    NSArray *cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    CardCombination* cardCombination = [[CardCombination alloc]initWithCardsToEvaluate:cardsForValidation];
    XCTAssertFalse([cardCombination checkForPair:cardsForValidation], @"shouldn't be a pair!");
    
    
    
    card1.rank = @"3"; card1.value = 3;
    card2.rank = @"4"; card2.value = 4;
    card3.rank = @"J"; card3.value = 11;
    card4.rank = @"6"; card4.value = 6;
    card5.rank = @"6"; card5.value = 6;
    card6.rank = @"7"; card6.value = 7;
    card7.rank = @"9"; card7.value = 9;
    cardsForValidation = @[card1, card2, card3, card4, card5, card6, card7];
    cardCombination.cardsToEvaluate = cardsForValidation;
    XCTAssertTrue([cardCombination checkForPair:cardsForValidation], @"should be a pair!");
}

@end
