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
                return NO;
            }
        }
        else
        {
            return NO;
        }
    }
    return YES;
}

-(BOOL)isHigherCombinationThan:(CardCombination*)paramCardCombination
{
    return NO;
}


@end
