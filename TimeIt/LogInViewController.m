//
//  LogInViewController.m
//  SidebarDemo
//
//  Created by Rodolfo Andrés Ramírez Valenzuela on 07/04/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

#import "LogInViewController.h"
#import <Parse/Parse.h>
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "HHAlertView.h"
#import "Global.h"
#import "CalendarViewController.h"
@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tfEmail setDelegate:self];
    [self.tfPassword setDelegate:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
/*
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
 }
 */
- (IBAction)back:(id)sender {
    UIStoryboard *sb = self.storyboard;
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"logVC"];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [UIView transitionWithView:app.window duration:0.7 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        app.window.rootViewController = vc;
        
    } completion:nil];
}
-(void)queryForCalendar{
    PFUser *user = [PFUser currentUser]; // get the current User
    PFRelation *relationTasks = [user relationForKey:@"userTask"]; //get the relation of the task with the user
    PFQuery *queryTasks = relationTasks.query; // Make the relation to get access to the values in that relation
    
    [queryTasks findObjectsInBackgroundWithBlock:^(NSArray *tasks, NSError *error) {
        if (!error){
            for (PFObject *task in tasks){
                [userTasks addObject:task];
            }
        }else{
            //error
        }
        
    }];
}

-(void)queryForProjects{
    
}
//method that permits to hide the keyboard when the return is pressed
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.tfEmail resignFirstResponder];
    [self.tfPassword resignFirstResponder];
    return NO;
    
}

- (IBAction)login:(id)sender {
    
    [PFUser logInWithUsernameInBackground:self.tfEmail.text password:self.tfPassword.text block:^(PFUser *user, NSError *error) {
        if (user){
            userProjects = [[NSMutableArray alloc] init];
            userTasks = [[NSMutableArray alloc] init];
            
            if(![[NSUserDefaults standardUserDefaults] boolForKey:@"hasSeenTutorial"]){ //If the user has not seen the tutorial this is the help
                PFRelation *relationProjects = [user relationForKey:@"userProjects"];
                PFQuery *queryProjects = relationProjects.query;
                
                [queryProjects findObjectsInBackgroundWithBlock:^(NSArray *projects, NSError *error) {
                    if (!error){
                        for (PFObject *project in projects){
                            [userProjects addObject:project];
                        }
                        PFRelation *relationTasks = [user relationForKey:@"userTask"]; //get the relation of the task with the user
                        PFQuery *queryTasks = relationTasks.query; // Make the relation to get access to the values in that relation
                        
                        [queryTasks findObjectsInBackgroundWithBlock:^(NSArray *tasks, NSError *error) {
                            if (!error){
                                for (PFObject *task in tasks){
                                    [userTasks addObject:task];
                                }
                                UIStoryboard *sb = self.storyboard;
                                UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"main"];
                                
                                AppDelegate *app = [[UIApplication sharedApplication] delegate];
                                //returns the pointer to the whole application
                                
                                //Makes the main as the new initial VC
                                //app.window.rootViewController = vc;
                                
                                //animation
                                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasLoggedIn"];
                                [UIView transitionWithView:app.window duration:0.7 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                                    app.window.rootViewController = vc;
                                    
                                } completion:nil];
                            }else{
                                //error
                            }
                            
                        }];
                        
                        
                        
                    }else{
                        //display error
                    }
                    
                }];
                
            }else{
                PFRelation *relationProjects = [user relationForKey:@"userProjects"];
                PFQuery *queryProjects = relationProjects.query;
                
                [queryProjects findObjectsInBackgroundWithBlock:^(NSArray *projects, NSError *error) {
                    if (!error){
                        for (PFObject *project in projects){
                            [userProjects addObject:project];
                        }
                        PFRelation *relationTasks = [user relationForKey:@"userTask"]; //get the relation of the task with the user
                        PFQuery *queryTasks = relationTasks.query; // Make the relation to get access to the values in that relation
                        
                        [queryTasks findObjectsInBackgroundWithBlock:^(NSArray *tasks, NSError *error) {
                            if (!error){
                                for (PFObject *task in tasks){
                                    [userTasks addObject:task];
                                }
                                UIStoryboard *sb = self.storyboard;
                                UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"main"];
                                
                                AppDelegate *app = [[UIApplication sharedApplication] delegate];
                                //returns the pointer to the whole application
                                
                                //Makes the main as the new initial VC
                                //app.window.rootViewController = vc;
                                
                                //animation
                                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasLoggedIn"];
                                [UIView transitionWithView:app.window duration:0.7 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                                    app.window.rootViewController = vc;
                                    
                                } completion:nil];
                            }else{
                                //error
                            }
                            
                        }];
                        
                        
                        
                    }else{
                        //display error
                    }
                    
                }];
                
                
                
            }
            
            
        }else{
            //Display an error
            NSString *errorString = [error userInfo][@"error"];
            /* UIAlertController *alerta = [UIAlertController alertControllerWithTitle:@"Error" message:@"The username or password is incorrect" preferredStyle:UIAlertControllerStyleAlert];
             UIAlertAction *accion = [UIAlertAction actionWithTitle:@"Accept" style:UIAlertActionStyleDestructive handler:nil];
             [alerta addAction:accion];
             [self presentViewController:alerta animated:YES completion:nil];*/
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
    else if ([self.tfPassword isFirstResponder] && [touch view] != self.tfPassword) {
        [self.tfPassword resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

-(void)hideKeyboard{
    [self.tfEmail resignFirstResponder];
    [self.tfPassword resignFirstResponder];
}


@end
