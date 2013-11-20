//
//  JoiningNetworkModel.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 20/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "JoiningNetworkModel.h"

@implementation JoiningNetworkModel

-(void)joinToGame
{
    [self configureSessionDetails];
    self.browserVC = [[MCBrowserViewController alloc] initWithServiceType:kServiceType
                                                                  session:self.session];
    self.browserVC.delegate = self;
}


#pragma mark - MCBrowserViewControllerDelegate methods
-(void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController
{
    
}

-(void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController
{
    
}


@end
