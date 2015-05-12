//
//  RPViewController.h
//  RPSlidingMenuDemo
//
//  Created by Paul Thorsteinson on 2/24/2014.
//  Copyright (c) 2014 Robots and Pencils Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPSlidingMenu.h"
#import "PageContentViewController.h"
#import "Global.h"

@interface RPViewController : RPSlidingMenuViewController <UIPageViewControllerDataSource> {
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnNew;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnDelete;


@property (strong,nonatomic) UIPageViewController *pageviewcontroller;
@property (strong,nonatomic) NSMutableArray *pageTitles;
@property (strong,nonatomic) NSMutableArray *pageContent;
@property (strong,nonatomic) NSMutableArray *pageDetails;
@property (strong,nonatomic) PFObject *proj;
@property (weak, nonatomic) IBOutlet UILabel *lbProject;




@end
