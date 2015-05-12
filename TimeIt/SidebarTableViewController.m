//
//  SidebarTableViewController.m
//  ProyectoFinalDispositivosMoviles
//
//  Created by Rodolfo Andrés Ramírez Valenzuela on 14/03/15.
//  Copyright (c) 2015 Rodolfo Andrés Ramírez Valenzuela. All rights reserved.
//

#import "SidebarTableViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>


@interface SidebarTableViewController ()

@end

@implementation SidebarTableViewController {
    NSArray *menuItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    menuItems = @[@"home", @"projects", @"calendar", @"help", @"about", @"logOut"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return menuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    if ([segue.identifier isEqualToString:@"logout"]) {
        
        [PFUser logOut];
        UIStoryboard *sb = self.storyboard;
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"hasLoggedIn"];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"logVC"];
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        //animation
        [UIView transitionWithView:app.window duration:0.7 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            app.window.rootViewController = vc;
            
        } completion:nil];
        
        
        
    }


    
    

}


@end
