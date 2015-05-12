//
//  LogInSignUpViewController.m
//  SidebarDemo
//
//  Created by Rodolfo Andrés Ramírez Valenzuela on 18/04/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

#import "LogInSignUpViewController.h"
#import "ABCIntroView.h"
#import "AppDelegate.h"

@interface LogInSignUpViewController () <ABCIntroViewDelegate>
@property ABCIntroView *introView;


@end

@implementation LogInSignUpViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.introView = [[ABCIntroView alloc] initWithFrame:self.view.frame];
    self.introView.delegate = self;
    self.introView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.introView];
    /*
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"hasLoggedIn"]){
        UIStoryboard *sb = self.storyboard;
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"main"];
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [UIView transitionWithView:app.window duration:0.7 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            app.window.rootViewController = vc;
            
        } completion:nil];
    }
    */
}

-(void)onLogInButtonPressed{
    
    //    Uncomment so that the IntroView does not show after the user clicks "DONE"
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    [defaults setObject:@"YES"forKey:@"intro_screen_viewed"];
    //    [defaults synchronize];
    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.introView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.introView removeFromSuperview];
    }];
    
    UIStoryboard *sb = self.storyboard;
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"logInVC"];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [UIView transitionWithView:app.window duration:0.7 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        app.window.rootViewController = vc;
        
    } completion:nil];

    
    
}

-(void)onSignUpButtonPressed{
    
    //    Uncomment so that the IntroView does not show after the user clicks "DONE"
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    [defaults setObject:@"YES"forKey:@"intro_screen_viewed"];
    //    [defaults synchronize];
    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.introView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.introView removeFromSuperview];
    }];
    
    UIStoryboard *sb = self.storyboard;
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"signUpVC"];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [UIView transitionWithView:app.window duration:0.7 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        app.window.rootViewController = vc;
        
    } completion:nil];
    
    
    
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



- (BOOL) prefersStatusBarHidden {
    return YES;
}

@end
