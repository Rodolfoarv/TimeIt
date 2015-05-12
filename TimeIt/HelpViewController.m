//
//  HelpViewController.m
//  SidebarDemo
//
//  Created by Rodolfo Andrés Ramírez Valenzuela on 14/04/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

#import "HelpViewController.h"
#import "GHWalkThroughView.h"
#import "AppDelegate.h"


static NSString * const sampleDesc1 = @"Start by creating a project.";

static NSString * const sampleDesc2 = @"Choose your project's name, description and image.";

static NSString * const sampleDesc3 = @"Create the tasks to be done in order to accomplish the project.";

static NSString * const sampleDesc4 = @"Share the project and tasks with your teammates.";

static NSString * const sampleDesc5 = @"Increase productivity and improve communication with Time It.";


@interface HelpViewController () < GHWalkThroughViewDataSource>

@property (nonatomic, strong) GHWalkThroughView* ghView ;
@property (nonatomic, strong) NSArray* descStrings;
@property (nonatomic, strong) UILabel* welcomeLabel;


@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _ghView = [[GHWalkThroughView alloc] initWithFrame:self.navigationController.view.bounds];
    [_ghView setDataSource:self];
    [_ghView setWalkThroughDirection:GHWalkThroughViewDirectionVertical];
    UILabel* welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    welcomeLabel.text = @"Welcome to Time It";
    welcomeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30];
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    self.welcomeLabel = welcomeLabel;
    
    self.descStrings = [NSArray arrayWithObjects:sampleDesc1,sampleDesc2, sampleDesc3, sampleDesc4, sampleDesc5, nil];
    
    [_ghView setFloatingHeaderView:self.welcomeLabel];
    [self.ghView setWalkThroughDirection:GHWalkThroughViewDirectionHorizontal];
    
    [self.ghView showInView:self.navigationController.view animateDuration:0.3];
    
    self.ghView.cp = self;
    
}

-(void) skip {
    UIStoryboard *sb = self.storyboard;
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"main"];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasSeenTutorial"];
    [UIView transitionWithView:app.window duration:0.7 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        app.window.rootViewController = vc;
        
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfPages
{
    return 5;
}

- (void) configurePage:(GHWalkThroughPageCell *)cell atIndex:(NSInteger)index
{
    cell.title = [NSString stringWithFormat:@"Step %ld", index+1];
    cell.titleImage = [UIImage imageNamed:[NSString stringWithFormat:@"title%ld", index+1]];
    cell.desc = [self.descStrings objectAtIndex:index];
}

- (UIImage*) bgImageforPage:(NSInteger)index
{
    NSString* imageName =[NSString stringWithFormat:@"bg_0%ld.jpg", index+1];
    UIImage* image = [UIImage imageNamed:imageName];
    return image;
}

@end
