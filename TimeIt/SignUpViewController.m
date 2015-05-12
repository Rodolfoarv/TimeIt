//
//  SignUpViewController.m
//  SidebarDemo
//
//  Created by Rodolfo Andrés Ramírez Valenzuela on 07/04/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>
#import "HHAlertView.h"
#import "AppDelegate.h"
@interface SignUpViewController ()

@end

@implementation SignUpViewController
- (IBAction)back:(id)sender {
    UIStoryboard *sb = self.storyboard;
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"logVC"];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [UIView transitionWithView:app.window duration:0.7 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        app.window.rootViewController = vc;
        
    } completion:nil];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.tfName resignFirstResponder];
    [self.tfEmail resignFirstResponder];
    [self.tfPassword resignFirstResponder];
    return NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tfName setDelegate:self];
    [self.tfEmail setDelegate:self];
    [self.tfPassword setDelegate:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)signUp:(id)sender {
    PFUser *user = [PFUser user];
    

    user.username = [self.tfName text];
    user.password = [self.tfPassword text];
    user.email = [self.tfEmail text];

    

    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            [HHAlertView showAlertWithStyle:HHAlertStyleOk inView:self.view Title:@"Success" detail:@"sign up successful!" cancelButton:nil Okbutton:@"Sure" block:^(HHAlertButton buttonindex) {
                if (buttonindex == HHAlertButtonOk) {
                    NSLog(@"ok Button is seleced use block");
                    UIStoryboard *sb = self.storyboard;
                    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"helpVC"];
                    AppDelegate *app = [[UIApplication sharedApplication] delegate];
                    [UIView transitionWithView:app.window duration:0.7 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
                        app.window.rootViewController = vc;
                        
                    } completion:nil];
                }
                else
                {
                    NSLog(@"cancel Button is seleced use block");
                    
                }
            }];
        } else {
           NSString *errorString = [error userInfo][@"error"];
            /*UIAlertController *alerta = [UIAlertController alertControllerWithTitle:@"error" message:errorString preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *accion = [UIAlertAction actionWithTitle:@"Accept" style:UIAlertActionStyleDestructive handler:nil];
            [alerta addAction:accion];
            [self presentViewController:alerta animated:YES completion:nil];*/
            // Show the errorString somewhere and let the user try again.
            
            [self hideKeyboard];
             [HHAlertView showAlertWithStyle:HHAlertStyleError inView:self.view Title:@"Error" detail:errorString cancelButton:nil Okbutton:@"Ok"];
        }
    }];
    

    
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.tfEmail isFirstResponder] && [touch view] != self.tfEmail) {
        [self.tfEmail resignFirstResponder];
    }
    else if ([self.tfName isFirstResponder] && [touch view] != self.tfName) {
        [self.tfName resignFirstResponder];
    }
    else if ([self.tfPassword isFirstResponder] && [touch view] != self.tfPassword) {
        [self.tfPassword resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}
-(void)hideKeyboard{
    [self.tfName resignFirstResponder];
    [self.tfEmail resignFirstResponder];
    [self.tfPassword resignFirstResponder];
}


@end
