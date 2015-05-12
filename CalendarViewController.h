//
//  ViewController.h
//  CLWeeklyCalendarView
//
//  Created by Caesar on 11/12/2014.
//  Copyright (c) 2014 Caesar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLWeeklyCalendarView.h"
@interface CalendarViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) CLWeeklyCalendarView *actualDate;
-(void)dailyCalendarViewDidSelect:(NSDate *)date;
@end



