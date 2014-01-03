//
//  ComunicationWithPacketsModel
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 30/12/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, MessageType) {
    TypeListOfPlayers,
    TypePlayerFolded,
    TypePlayerCalled,
    TypePlayerChecked,
    TypePlayerBet,
    TypePlayerGoesAllIn,
    TypePlayerEliminated,
    TypeGameOver,
    TypePlayerQuit
};

@interface ComunicationWithPacketsModel : NSObject

-(void)sendInfoToPlayerWithUniqueID:(NSUInteger)paramUniqueID
                           withType:(MessageType)paramType
                          andObject:(id)paramObject;

-(void)sendInfoToPlayersWithUniqueIDs:(NSArray*)paramUniqueIDs
                             WithType:(MessageType)paramType
                            andObject:(id)paramObject;

@end
