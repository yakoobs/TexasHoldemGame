//
//  Deck.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 23/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "Deck.h"

static const NSInteger kDeckCapacity = 52;
static const NSInteger kDeuceValue = 2;

@interface Deck()

@property NSMutableArray* cardsInDeck;

@end


@implementation Deck

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _cardsInDeck = [NSMutableArray arrayWithArray:[self fullDeck]];
    }
    return self;
}

-(NSMutableArray*)fullDeck
{
    NSMutableArray* deckArray = [[NSMutableArray alloc]initWithCapacity:kDeckCapacity];
    for (NSString* suit in [self validSuits])
    {
        NSInteger value = kDeuceValue;
        //value depends on rank from "2"(duce) with value 2 to "A"(ace) with value 14
        for (NSString* rank in [self validRanks])
        {
            Card* card = [[Card alloc]initWithRank:rank suit:suit andValue:value];
            [deckArray addObject:card];
            value++;
        }
    }
    return deckArray;
}

- (NSArray *)validSuits
{
    return @[@"s", @"c", @"h", @"d"];
}

- (NSArray *)validRanks
{
    return @[@"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J",@"Q",@"K",@"A"];
}

- (Card *)drawRandomCardAndRemoveItFromDeck
{
    if (self.cardsInDeck.count == 0) //ain't gonna happen in TexasHoldemGame project, just defensive programming here.
    {
        return nil;
    }
    
    NSUInteger randomIndex = arc4random() % (self.cardsInDeck).count;
    Card* card = [(self.cardsInDeck)[randomIndex] copy];
    [self.cardsInDeck removeObjectAtIndex:randomIndex];
    return card;
}

-(void)resetDeck
{
    self.cardsInDeck = [self fullDeck];
}


@end
