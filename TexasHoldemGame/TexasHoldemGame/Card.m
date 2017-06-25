//
//  Card.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 23/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "Card.h"

@implementation Card

-(instancetype)initWithRank:(NSString*)paramRank suit:(NSString*)paramSuit andValue:(NSInteger)paramValue
{
    self = [super init];
    if (self) {
        _rank = [NSString stringWithString:paramRank];
        _suit = [NSString stringWithString:paramSuit];
        _value = paramValue;
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone
{
    Card* card = [[Card alloc]initWithRank:self.rank suit:self.suit andValue:self.value];
    return card;
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"%@%@ value:%@",self.rank,self.suit,@(self.value)];
}

@end
