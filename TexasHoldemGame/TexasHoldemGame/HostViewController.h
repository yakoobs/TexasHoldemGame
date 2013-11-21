//
//  HostViewController.h
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 14/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HostViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tournamentNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *hostNicknameTextField;
@property (weak, nonatomic) IBOutlet UIButton *hostTheGameButton;

@end
