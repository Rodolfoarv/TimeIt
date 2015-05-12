//
//  ViewController.m
//  CLWeeklyCalendarView
//
//  Created by Caesar on 11/12/2014.
//  Copyright (c) 2014 Caesar. All rights reserved.
//

//
//  ViewController.m
//  CLWeeklyCalendarView
//
//  Created by Caesar on 11/12/2014.
//  Copyright (c) 2014 Caesar. All rights reserved.
//

#import "CalendarViewController.h"
#import "CLWeeklyCalendarView.h"
#import "SWRevealViewController.h"
#import <EventKit/EventKit.h>
#import <Parse/Parse.h>
#import "Global.h"
@interface CalendarViewController ()<CLWeeklyCalendarViewDelegate>

@property (nonatomic, strong) CLWeeklyCalendarView* calendarView;
@property (nonatomic, strong) NSString *selectedDatePrintFormat;
@end

static CGFloat CALENDER_VIEW_HEIGHT = 150.f;
@implementation CalendarViewController
NSArray *tableData;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //tableData = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self.view addSubview:self.calendarView];
    /*
    //Creates the new project
    PFObject *task = [PFObject objectWithClassName:@"Task"];
    
    task[@"title"] = @"Hola";
    task[@"description"] = @"Esto es una prueba de detalles";
    //task[@"creation_date"] = [[NSDate init] alloc]; //Despliega el dia de hoy
    task[@"due_date"] =  self.actualDate.theSelectedDateIs ? self.actualDate.theSelectedDateIs : [NSDate date]; // Despliega para cuando es el task
    
    
    [task saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded){
            NSLog(@"Creating of the object succesful");
        }else{
            //error
        }
    }];*/
    
    
    
 //  PFUser *user = [PFUser currentUser]; //Retrieve the currentUser that is logged
    /*
    PFRelation *taskForUsers = [task relationForKey:@"taskForUsers"];
    
    [taskForUsers addObject:user];
    [task save]; //Save the task with the data inserted
    
    
    PFRelation *userForTasks = [user relationForKey:@"userForTasks"];
    [userForTasks addObject:task];
    [user save];
    */
    
    
    //Mostrar el nombre de un proyecto
    /* PFQuery *query = [PFQuery queryWithClassName:@"Project"]; //Inicializa el query y apunta a la tabla donde vamos a ejecutar el query
     [query whereKey:@"name" equalTo:@"Proyecto"];
     [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
     for (PFObject *object in objects){
     NSLog(@"%@", object[@"details"]);
     }
     }];*/
    
    
    
    /*

    PFQuery *query = [PFQuery queryWithClassName:@"Task"]; //Inicializa el query y apunta a la tabla donde vamos a ejecutar el query
    [query whereKey:@"title" equalTo:@"Hola"];
   [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
       for (PFObject *object in objects){
           [userTasks addObject:object[@"title"]];
       }
    }];*/
    
    /*
    PFUser *user = [PFUser currentUser]; // get the current User
    PFRelation *relationTasks = [user relationForKey:@"userTask"]; //get the relation of the task with the user
    PFQuery *queryTasks = relationTasks.query; // Make the relation to get access to the values in that relation
    [queryTasks findObjectsInBackgroundWithBlock:^(NSArray *tasks, NSError *error) {
        for (PFObject *task in tasks){
            [userTasks addObject:task[@"title"]];
        }
    }];*/

    
    
}


///PARA EL TABLE VIEW
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [userTasks count];
}
//PARA EL TABLE VIEW
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [userTasks objectAtIndex:indexPath.row][@"title"];
    return cell;
}
//PARA EL TABLE VIEW
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    for (UITableViewCell *cell in [tableView visibleCells]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    //el for de arriba permite que se borren las lineas una vez que se selecciona otra
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Initialize
-(CLWeeklyCalendarView *)calendarView
{
    if(!_calendarView){
        _calendarView = [[CLWeeklyCalendarView alloc] initWithFrame:CGRectMake(0, 63, self.view.bounds.size.width, CALENDER_VIEW_HEIGHT)];
        _calendarView.delegate = self;
    }
    return _calendarView;
}




#pragma mark - CLWeeklyCalendarViewDelegate
-(NSDictionary *)CLCalendarBehaviorAttributes
{
    return @{
             CLCalendarWeekStartDay : @2,                 //Start Day of the week, from 1-7 Mon-Sun -- default 1
             //             CLCalendarDayTitleTextColor : [UIColor yellowColor],
             //             CLCalendarSelectedDatePrintColor : [UIColor greenColor],
             };
}



-(void)dailyCalendarViewDidSelect:(NSDate *)date
{
    
    
    /*NSDate *dates = [NSDate date];
     NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
     [dayFormatter setDateFormat:@"EEEE"];
     NSString *strDate = [dayFormatter stringFromDate:dates];*/
    /* NSLog(@"strDate");
     NSLog(@"wtf, %@", strDate);*/
    //You can do any logic after the view select the date
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // the selector is available, so we must be on iOS 6 or newer
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    // display error message here
                    NSLog(@"error");
                }
                else if (!granted)
                {
                    UIAlertController *alerta = [UIAlertController alertControllerWithTitle:@"Not Allowed" message:@"You can't access to the calendar" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *accion = [UIAlertAction actionWithTitle:@"Acept" style:UIAlertActionStyleDestructive handler:nil];
                    [alerta addAction:accion];
                    [self presentViewController:alerta animated:YES completion:nil];
                }
                else
                {
                    // access granted
                    // ***** do the important stuff here *****
                    // NSLog(@"hello");
                 
                    NSLog(@"%@",self.calendarView.theSelectedDateIs);
                  /*
                    PFUser *user = [PFUser currentUser]; // get the current User
                    PFRelation *relationTasks = [user relationForKey:@"userTask"]; //get the relation of the task with the user
                    PFQuery *queryTasks = relationTasks.query; // Make the relation to get access to the values in that relation
                    [queryTasks whereKey:@"fechaEnt" equalTo:self.calendarView.theSelectedDateIs];
                    [queryTasks findObjectsInBackgroundWithBlock:^(NSArray *tasks, NSError *error) {
                        for (PFObject *task in tasks){
                            [userTasks addObject:task[@"title"]];
                        }
                    }];*/
                    // NSLog(strDate);
                    /*if([dates isEqualToDate:self.selectedDate]){
                     NSLog(strDate);
                     //NSLog(@"hello");
                     }*/
                    
                }
            });
        }];
    }
    
    
}



@end
