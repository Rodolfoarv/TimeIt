//
//  LogInViewController.h
//  SidebarDemo
//
//  Created by Rodolfo Andrés Ramírez Valenzuela on 07/04/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

#import "ViewController.h"


@interface LogInViewController : ViewController <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;

@end
