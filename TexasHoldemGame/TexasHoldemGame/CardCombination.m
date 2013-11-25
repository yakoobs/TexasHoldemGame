//
//  CardCombination.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 23/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "CardCombination.h"

const NSInteger kNumberOfCardsToEvaluation = 7;

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
    if ([self checkForStraightFlush])
    {
        [self sortStraightFlushCombination];
    }
    //Four of kind
    else if ([self checkForFourOfKind])
    {
        [self sortFourOfKindCombination];
    }
    //Full house
    if ([self checkForFullHouse])
    {
        [self sortFullHouseCombination];
    }
    //Flush
    else if ([self checkForFlush])
    {
        [self sortFlushCombination];
    }
    //Straight
    else if ([self checkForStraight])
    {
        [self sortStraightFlushCombination];
    }
    //Three of kind
    else if ([self checkForThreeOfKind])
    {
        [self sortThreeOfKindCombination];
    }
    //Two pairs
    else if ([self checkForTwoPairs])
    {
        [self sortTwoPairsCombination];
    }
    //Pair
    else if ([self checkForPair])
    {
        [self sortPairCombination];
    }
    //High card
    else
    {
        [self sortHighCardCombination];
    }
}

-(BOOL)checkForFlush
{
    return NO;
}

-(void)sortFlushCombination
{
    
}

-(BOOL)checkForStraight
{
    return NO;
}

-(void)sortStraightCombination
{
    
}

-(BOOL)checkForStraightFlush
{
    return NO;
}

-(void)sortStraightFlushCombination
{
    
}

-(BOOL)checkForFourOfKind
{
    return NO;
}

-(void)sortFourOfKindCombination
{
    
}


-(BOOL)checkForThreeOfKind
{
    return NO;
}

-(void)sortThreeOfKindCombination
{
    
}

-(BOOL)checkForFullHouse
{
    return NO;
}

-(void)sortFullHouseCombination
{
    
}

-(BOOL)checkForTwoPairs
{
    return NO;
}

-(void)sortTwoPairsCombination
{
    
}

-(BOOL)checkForPair
{
    return NO;
}

-(void)sortPairCombination
{
    
}

-(void)sortHighCardCombination
{
    
}
@end
