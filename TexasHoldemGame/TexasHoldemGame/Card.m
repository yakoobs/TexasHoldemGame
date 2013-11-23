//
//  Card.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 23/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "Card.h"

@implementation Card

-(instancetype)initWithRank:(NSString*)paramRank andSuit:(NSString*)paramSuit
{
    self = [super init];
    if (self) {
        _rank = [NSString stringWithString:paramRank];
        _suit = [NSString stringWithString:paramSuit];
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone
{
    Card* card = [[Card alloc]initWithRank:self.rank andSuit:self.suit];
    return card;
}
@end
