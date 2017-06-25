//
//  CardCombination.h
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 23/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

typedef NS_ENUM(NSInteger, CardCombinationType)
{
    HighCard,
    Pair,
    TwoPairs,
    ThreeOfKind,
    Straight,
    Flush,
    FullHouse,
    FourOfKind,
    StraightFlush,
    IncorrectCombination
};

@interface CardCombination : NSObject

@property (nonatomic,readonly) NSString* typeName;
@property CardCombinationType type;
@property (nonatomic,strong) NSArray* descendingSortedCardsCombination;
@property (nonatomic, copy)NSArray* cardsToEvaluate;

/**
 * Initiates CardCombination object with an array of cards to evaluate.
 * @param (NSArray*)paramCardsToEvaluate should contain 7 Card objects (5 from board + 2 in hand)
 */
-(instancetype)initWithCardsToEvaluate:(NSArray*)paramCardsToEvaluate NS_DESIGNATED_INITIALIZER;

/**
* YES if combination is higher than paramCardCombination.
 * If NO it DOES NOT mean that paramCardCombination is higher combination. Equality is possible!
*/
-(BOOL)isHigherCombinationThan:(CardCombination*)paramCardCombination;


@end
