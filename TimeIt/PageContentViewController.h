//
//  PageContentViewController.h
//  testPageController
//
//  Created by Andres Pelaez on 3/9/15.
//  Copyright (c) 2015 Andres Pelaez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import <Parse/Parse.h>
#import "Global.h"
#import "HHAlertView.h"
#import "MBProgressHUD.h"
@interface PageContentViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *btNewtable;
@property (weak, nonatomic) IBOutlet UIButton *btLigar;
@property (weak, nonatomic) IBOutlet UITableView *table;

@property NSUInteger pageIndex;
@property PFObject *parentProject;
@property NSString *titleText;
@property NSString *imageFile;
@property NSMutableArray *contTabla;
@property NSMutableArray *detaTabla;
@property NSMutableArray *detaComp;

@end
