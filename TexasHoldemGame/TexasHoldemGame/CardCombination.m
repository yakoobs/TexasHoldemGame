//
//  CardCombination.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 23/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "CardCombination.h"

static const NSInteger kNumberOfCardsToEvaluation = 7;
static const NSInteger kAceValue = 14;

@implementation CardCombination


-(instancetype)initWithCardsToEvaluate:(NSArray*)paramCardsToEvaluate
{
    self = [super init];
    if (self)
    {
        _cardsToEvaluate = [paramCardsToEvaluate copy];
        
        if ([self invalidCardsToEvaluate] || _cardsToEvaluate.count != kNumberOfCardsToEvaluation)
        {
            NSLog(@"Invalid cards' array for evaluation");
            
            return nil;
        }
    }
    return self;
}


-(BOOL)invalidCardsToEvaluate
{
    for (id object in self.cardsToEvaluate)
    {
        if ([object isKindOfClass:[Card class]])
        {
            Card* card = (Card*)object;
            
            BOOL isValidCard = card.value && card.suit && card.rank;
            
            if (!isValidCard)
            {
                return YES;
            }
        }
        else
        {
            return YES;
        }
    }
    return NO;
}

-(BOOL)isHigherCombinationThan:(CardCombination*)paramCardCombination
{
    return NO;
}


#pragma mark - Combinetion validation methods

-(void)validateCardsCombination
{
    //Straight flush
    if ([self checkForStraightFlush:self.cardsToEvaluate])
    {
        self.type = StraightFlush;
    }
    //Four of kind
    else if ([self checkForFourOfKind:self.cardsToEvaluate])
    {
        self.type = FourOfKind;
    }
    //Full house
    if ([self checkForFullHouse:self.cardsToEvaluate])
    {
        self.type = FullHouse;
    }
    //Flush
    else if ([self checkForFlush:self.cardsToEvaluate])
    {
        self.type = Flush;
    }
    //Straight
    else if ([self checkForStraight:self.cardsToEvaluate])
    {
        self.type = Straight;
    }
    //Three of kind
    else if ([self checkForThreeOfKind:self.cardsToEvaluate])
    {
        self.type = ThreeOfKind;
    }
    //Two pairs
    else if ([self checkForTwoPairs:self.cardsToEvaluate])
    {
        self.type = TwoPairs;
    }
    //Pair
    else if ([self checkForPair:self.cardsToEvaluate])
    {
        self.type = Pair;
    }
    //High card
    else
    {
        self.type = HighCard;
        [self sortHighCardCombination];
    }
}

-(BOOL)checkForFlush:(NSArray*)paramCardsToEvaluate
{
    NSArray* cards = [self sortCards:paramCardsToEvaluate valueAscending:NO suitAscending:YES];
    for (NSInteger i = 0; i < cards.count - 4; i++)
    {
        Card *card0 = [cards objectAtIndex:i];
        Card *card1 = [cards objectAtIndex:i+1];
        if ([card0.suit isEqualToString:card1.suit])
        {
            Card *card2 = [cards objectAtIndex:i+2];
            if ([card1.suit isEqualToString:card2.suit])
            {
                Card *card3 = [cards objectAtIndex:i+3];
                if ([card2.suit isEqualToString:card3.suit])
                {
                    Card *card4 = [cards objectAtIndex:i+4];
                    if ([card3.suit isEqualToString:card4.suit])
                    {
                        NSArray * flushCombinationCards = [NSArray arrayWithObjects:card0, card1, card2, card3, card4, nil];
                        self.descendingSortedCardsCombination = flushCombinationCards;
                        return YES;
                    }
                }
                return NO;
            }
            else
            {
                i++;
            }
        }
    }
    return NO;
}


-(BOOL)checkForStraight:(NSArray*)paramCardsToEvaluate
{
    NSMutableArray* cards = [NSMutableArray arrayWithArray:[self sortCards:paramCardsToEvaluate valueAscending:NO]];
    NSInteger firstCardValue = [(Card*)[cards objectAtIndex:0] value];
    if (firstCardValue == kAceValue)
    {
        Card* additionalAceForWheel = [[cards objectAtIndex:0] copy];
        additionalAceForWheel.value = 1;
        [cards addObject:additionalAceForWheel];
    }

    for (NSInteger a = 0; a < cards.count-4; a++)
    {
        Card * tempCard1 = [cards objectAtIndex:a];
        Card * tempCard2 = [cards objectAtIndex:a+1];
        if (tempCard1.value == tempCard2.value+1)
        {
            for (NSInteger b = a+1; b < cards.count-3; b++)
            {
                Card * tempCard3 = [cards objectAtIndex:b+1];
                if (tempCard2.value == tempCard3.value+1)
                {
                    for (NSInteger c = b+1; c < cards.count-2; c++)
                    {
                        Card * tempCard4 = [cards objectAtIndex:c+1];
                        if (tempCard3.value == tempCard4.value+1)
                        {
                            for (NSInteger d = c+1; d < cards.count-1; d++)
                            {
                                Card * tempCard5 = [cards objectAtIndex:d+1];
                                if (tempCard4.value == tempCard5.value+1)
                                {
                                    NSArray * straightCombinationCards = [NSArray arrayWithObjects:tempCard1, tempCard2, tempCard3, tempCard4, tempCard5, nil];
                                    self.descendingSortedCardsCombination = straightCombinationCards;
                                    return YES;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return NO;
}

-(BOOL)checkForStraightFlush:(NSArray*)paramCardsToEvaluate
{
    NSMutableArray* tempCards = [[NSMutableArray alloc]init];
    for (Card* card  in paramCardsToEvaluate)
    {
        if (card.value == kAceValue)
        {
            Card* additionalAceForWheel = [card copy];
            additionalAceForWheel.value = 1;
            [tempCards addObject:additionalAceForWheel];
        }
    }
    
    NSMutableArray* cards = [NSMutableArray arrayWithArray:paramCardsToEvaluate];
    [cards addObjectsFromArray:tempCards];
    cards = [NSMutableArray arrayWithArray:[self sortCards:cards valueAscending:NO suitAscending:YES]];
    
    for (NSInteger a = 0; a < cards.count-4; a++)
    {
        Card * tempCard1 = [cards objectAtIndex:a];
        Card * tempCard2 = [cards objectAtIndex:a+1];
        BOOL areSuitedConnected = (tempCard1.value == tempCard2.value+1) && [tempCard1.suit isEqualToString:tempCard2.suit];
        if (areSuitedConnected)
        {
            for (NSInteger b = a+1; b < cards.count-3; b++)
            {
                Card * tempCard3 = [cards objectAtIndex:b+1];
                areSuitedConnected = (tempCard2.value == tempCard3.value+1) && [tempCard2.suit isEqualToString:tempCard3.suit];
                if (areSuitedConnected)
                {
                    for (NSInteger c = b+1; c < cards.count-2; c++)
                    {
                        Card * tempCard4 = [cards objectAtIndex:c+1];
                        areSuitedConnected = (tempCard3.value == tempCard4.value+1) && [tempCard3.suit isEqualToString:tempCard4.suit];
                        if (areSuitedConnected)
                        {
                            for (NSInteger d = c+1; d < cards.count-1; d++)
                            {
                                Card * tempCard5 = [cards objectAtIndex:d+1];
                                areSuitedConnected = (tempCard4.value == tempCard5.value+1) && [tempCard4.suit isEqualToString:tempCard5.suit];
                                if (areSuitedConnected)
                                {
                                    NSArray * straightFlushCombinationCards = [NSArray arrayWithObjects:tempCard1, tempCard2, tempCard3, tempCard4, tempCard5, nil];
                                    self.descendingSortedCardsCombination = straightFlushCombinationCards;
                                    return YES;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return NO;
}

-(BOOL)checkForFourOfKind:(NSArray*)paramCardsToEvaluate
{
    NSMutableArray* cards = [NSMutableArray arrayWithArray:[self sortCards:paramCardsToEvaluate valueAscending:NO]];
    
    for (NSInteger a = 0; a < cards.count-3; a++)
    {
        Card * tempCard1 = [cards objectAtIndex:a];
        Card * tempCard2 = [cards objectAtIndex:a+1];
        Card * tempCard3 = [cards objectAtIndex:a+2];
        Card * tempCard4 = [cards objectAtIndex:a+3];
        
        BOOL allValuesAreEqual = (tempCard1.value == tempCard2.value) && (tempCard1.value == tempCard3.value) && (tempCard1.value == tempCard4.value);
        
        if (allValuesAreEqual)
        {
            Card * tempCard5;
            if (a == 0)
            {
                tempCard5 = [cards objectAtIndex:4];
            }
            else
            {
                tempCard5 = [cards objectAtIndex:0];
            }
            NSArray * fourOfKindCombinationCards = [NSArray arrayWithObjects:tempCard1, tempCard2, tempCard3, tempCard4, tempCard5, nil];
            self.descendingSortedCardsCombination = fourOfKindCombinationCards;
            return YES;
        }
    }
    return NO;
}


-(BOOL)checkForThreeOfKind:(NSArray*)paramCardsToEvaluate
{
    NSMutableArray* cards = [NSMutableArray arrayWithArray:[self sortCards:paramCardsToEvaluate valueAscending:NO]];
    
    for (NSInteger a = 0; a < cards.count-2; a++)
    {
        Card * tempCard1 = [cards objectAtIndex:a];
        Card * tempCard2 = [cards objectAtIndex:a+1];
        Card * tempCard3 = [cards objectAtIndex:a+2];
        
        BOOL allValuesAreEqual = (tempCard1.value == tempCard2.value) && (tempCard1.value == tempCard3.value);
        if(allValuesAreEqual)
        {
            Card * tempCard4;
            Card * tempCard5;
            if (a == 0)
            {
                tempCard4 = [cards objectAtIndex:3];
                tempCard5 = [cards objectAtIndex:4];
            }
            else if (a == 1)
            {
                tempCard4 = [cards objectAtIndex:0];
                tempCard5 = [cards objectAtIndex:4];
            }
            else
            {
                tempCard4 = [cards objectAtIndex:0];
                tempCard5 = [cards objectAtIndex:1];
            }
            
            NSArray * threeOfKindCombinationCards = [NSArray arrayWithObjects:tempCard1, tempCard2, tempCard3, tempCard4, tempCard5, nil];
            self.descendingSortedCardsCombination = threeOfKindCombinationCards;
            return YES;
        }
    }
    return NO;
}

-(BOOL)checkForFullHouse:(NSArray*)paramCardsToEvaluate

{
    NSMutableArray* threeCards = [[NSMutableArray alloc]init];
   
    if ([self checkForThreeOfKind:paramCardsToEvaluate])
    {
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 3)];
        [threeCards addObjectsFromArray:[self.descendingSortedCardsCombination objectsAtIndexes:indexSet]];
        
        NSMutableArray * tempArray = [NSMutableArray arrayWithArray:self.descendingSortedCardsCombination];
        [tempArray removeObjectsAtIndexes:indexSet];
        
        for (NSInteger a = 0; a < tempArray.count-1; a++)
        {
            Card * tempCard1 = [tempArray objectAtIndex:a];
            Card * tempCard2 = [tempArray objectAtIndex:a+1];
            if (tempCard1.value == tempCard2.value)
            {
                tempArray = [NSMutableArray arrayWithArray: @[tempCard1, tempCard2]];
                self.descendingSortedCardsCombination = [threeCards arrayByAddingObjectsFromArray:tempArray];
                return YES;
            }
        }
    }
    return NO;
}

-(BOOL)checkForTwoPairs:(NSArray*)paramCardsToEvaluate
{
    NSMutableArray* cards = [NSMutableArray arrayWithArray:[self sortCards:paramCardsToEvaluate valueAscending:NO]];
    
    for (NSInteger a = 0; a < cards.count-3; a++)
    {
        Card * tempCard1 = [cards objectAtIndex:a];
        Card * tempCard2 = [cards objectAtIndex:a+1];
        if (tempCard1.value == tempCard2.value)
        {
            for (NSInteger b = a+2; b < cards.count-1; b++)
            {
                Card * tempCard3 = [cards objectAtIndex:b];
                Card * tempCard4 = [cards objectAtIndex:b+1];
                if (tempCard3.value == tempCard4.value)
                {
                    Card * tempCard5;
                    if (a == 0)
                    {
                        if (b == 2)
                        {
                            tempCard5 = [cards objectAtIndex:4];
                        }
                        else
                        {
                            tempCard5 = [cards objectAtIndex:2];
                        }
                    }
                    else
                    {
                        tempCard5 = [cards objectAtIndex:0];
                    }
                    return YES;
                }
            }
        }
    }
    return NO;

}


-(BOOL)checkForPair:(NSArray*)paramCardsToEvaluate
{
    NSMutableArray* cards = [NSMutableArray arrayWithArray:[self sortCards:paramCardsToEvaluate valueAscending:NO]];
    
    for (NSInteger a = 0; a < cards.count-1; a++)
    {
        Card * tempCard1 = [cards objectAtIndex:a];
        Card * tempCard2 = [cards objectAtIndex:a+1];
        if (tempCard1.value == tempCard2.value)
        {
            Card * tempCard3;
            Card * tempCard4;
            Card * tempCard5;

            if (a == 0)
            {
                tempCard3 = [cards objectAtIndex:2];
                tempCard4 = [cards objectAtIndex:3];
                tempCard5 = [cards objectAtIndex:4];
            }
            else if(a == 1)
            {
                tempCard3 = [cards objectAtIndex:0];
                tempCard4 = [cards objectAtIndex:3];
                tempCard5 = [cards objectAtIndex:4];
            }
            else if(a == 2)
            {
                tempCard3 = [cards objectAtIndex:0];
                tempCard4 = [cards objectAtIndex:1];
                tempCard5 = [cards objectAtIndex:4];
            }
            else
            {
                tempCard3 = [cards objectAtIndex:0];
                tempCard4 = [cards objectAtIndex:1];
                tempCard5 = [cards objectAtIndex:2];
            }
            return YES;
        }
    }
    return NO;
}


-(void)sortHighCardCombination
{
    NSMutableArray* cards = [NSMutableArray arrayWithArray:[self sortCards:self.cardsToEvaluate valueAscending:NO]];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 5)];
    self.descendingSortedCardsCombination = [cards objectsAtIndexes:indexSet];
}

#pragma mark - Card Sorter

static NSString * const kValueOfCardPropertyName = @"value";
static NSString * const kSuitOfCardPropertyName = @"suit";

-(NSArray *) sortCards:(NSArray *)cards valueAscending:(BOOL)isAscending
{
    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:kValueOfCardPropertyName ascending:isAscending];
    return [cards sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}

-(NSArray *) sortCards:(NSArray *)cards  suitAscending:(BOOL)isAscending
{
    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:kSuitOfCardPropertyName ascending:isAscending];
    return [cards sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}

-(NSArray *) sortCards:(NSArray *)cards  valueAscending:(BOOL)isValueAscending suitAscending:(BOOL)isSuitAscending
{
    NSSortDescriptor *sorter0 = [NSSortDescriptor sortDescriptorWithKey:kValueOfCardPropertyName ascending:isValueAscending];
    NSSortDescriptor *sorter1 = [NSSortDescriptor sortDescriptorWithKey:kSuitOfCardPropertyName ascending:isSuitAscending];
    return [cards sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sorter1,sorter0,nil]];
}


@end
