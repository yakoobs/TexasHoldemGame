//
//  HostViewController.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 14/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "HostViewController.h"
#import "WaitForOtherPlayersViewController.h"

@implementation HostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureHostNicknameTextField];
    [self configureTournamentnameTextField];
}

-(void)configureHostNicknameTextField
{
    NSString* initialIDFromDeviceName = [UIDevice currentDevice].name;
    self.hostNicknameTextField.delegate = self;
    self.hostNicknameTextField.text = initialIDFromDeviceName;
}

-(void)configureTournamentnameTextField;
{
    static NSString* const kInitialTournamentName  = @"My tournament";
    self.tournamentNameTextField.delegate = self;
    self.tournamentNameTextField.text = kInitialTournamentName;
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Push WaitForOtherPlayersViewController with segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue
                sender:(id)sender
{
    static NSString* const kPushWaitForOtherPlayersVC = @"PushWaitForOtherPlayersVC";
    if ([segue.identifier isEqualToString:kPushWaitForOtherPlayersVC])
    {
        WaitForOtherPlayersViewController* waitForOtherPlayersVC = (WaitForOtherPlayersViewController*)segue.destinationViewController;
        [waitForOtherPlayersVC setHostNetworkModelPlayerName:self.hostNicknameTextField.text
                                           andTournamentName:self.tournamentNameTextField.text];
    }
}

@end
