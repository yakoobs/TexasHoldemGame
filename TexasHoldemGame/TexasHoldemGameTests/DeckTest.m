//
//  DeckTest.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 23/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Deck.h"
#import "Card.h"

@interface DeckTest : XCTestCase

@end

@implementation DeckTest

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

- (void)testExample
{
    Deck* deck = [[Deck alloc]init];
    NSMutableArray* drawnCards = [NSMutableArray arrayWithCapacity:52];
    
    for (NSInteger i = 1; i<=52; i++)
    {
        Card* card = [deck drawRandomCardAndRemoveItFromDeck];
        XCTAssertTrue(card, @"Empty card from deck");
        
        for (Card* drawnCard in drawnCards)
        {
            BOOL sameSuit  = [card.suit isEqualToString:drawnCard.suit];
            BOOL sameRank  = [card.rank isEqualToString:drawnCard.rank];
            if (sameSuit && sameRank)
            {
                XCTFail(@"The same card was drawn from the deck");
            }
        }
        [drawnCards addObject:card];
    }
}

@end
