//
//  SidebarTableViewController.m
//  ProyectoFinalDispositivosMoviles
//
//  Created by Rodolfo Andrés Ramírez Valenzuela on 14/03/15.
//  Copyright (c) 2015 Rodolfo Andrés Ramírez Valenzuela. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>
#import "UIView+Toast.h"
#import "Global.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"What's up for today?";
    

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd.MM.YY HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    NSLog(@"%@",dateString);    
    
    int taskHeightLocation = 0;
    for (PFObject *userTask in userTasks){
        PFRelation *relationProject = [userTask relationForKey:@"taskProject"];
        PFQuery *queryGetProjectInfo = relationProject.query; // Make the relation to get access to the values in that relation
        [queryGetProjectInfo getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            PFFile *projectImage = object[@"image"]; // get the image for the project
            [projectImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                UIImage *taskImage = [UIImage imageWithData:data];
                [self.view makeToast:userTask[@"title"] duration:1000.0 position:[NSValue valueWithCGPoint:CGPointMake(screenWidth/2, taskHeightLocation)] title:object[@"name"] image:taskImage];
            }];
            
        } ];
        taskHeightLocation += 120;
    }
    
    
    
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

@end
