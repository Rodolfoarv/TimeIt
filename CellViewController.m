//
//  MapViewController.m
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import "CellViewController.h"
#import "SWRevealViewController.h"
#import "classFeedItem.h"
#import "NumberCell.h"
#import <Parse/Parse.h>


@interface CellViewController ()

@end

@implementation CellViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    items = [[NSMutableArray alloc] init];
    
    [itemsTable setDataSource:self];
    [itemsTable setDelegate:self];
    
    classFeedItem *item1 = [[classFeedItem alloc]init];
    [item1 setText:@"Some text 1"];
    [item1 setImagePath:@"Paisaje-Natural.jpg"];
    
    classFeedItem *item2 = [[classFeedItem alloc]init];
    [item2 setText:@"Some text 2"];
    [item2 setImagePath:@"paisaje-oto-al-10834.jpg"];
    
    classFeedItem *item3 = [[classFeedItem alloc]init];
    [item3 setText:@"Some text 3"];
    [item3 setImagePath:@"ad10941606819.jpg"];
    
    classFeedItem *item4 = [[classFeedItem alloc]init];
    [item4 setText:@"Some text 4"];
    [item4 setImagePath:@"paisajes-naturales.jpg"];
    
    [items addObject:item2];
    [items addObject:item4];
    [items addObject:item1];
    [items addObject:item3];
    
    [itemsTable reloadData];
    
    //The user will load all their projects that are currently assigned to that user
    

    


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


- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return items.count;
}

-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    classFeedItem *buf = (classFeedItem*) items [indexPath.row];
    
    NumberCell *cell = (NumberCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"NumberCell" forIndexPath:indexPath];
    
    [cell loadCell:buf];
    return cell;
    
    
}
- (IBAction)addProject:(id)sender {
    
    
    //Creates the new project
    PFObject *project = [PFObject objectWithClassName:@"Project"];
    project[@"name"] = @"test";
    project[@"details"] = @"Im testing how much text can we possibly write on the details of a project";
    
    [project saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded){
            
            //Retrieve the user ID and project ID to make the relation with the user_project Table
            PFUser *user = [PFUser currentUser]; //Retrieve the currentUser that is logged
            NSString *userID = user.objectId;
            NSString *projectID = project.objectId;

            //make the relation between the user and the project
            PFObject *user_project = [PFObject objectWithClassName:@"User_Project"];
            user_project[@"user_fk"] = userID;
            user_project[@"project_fk"] = projectID;
            [user_project saveInBackground];
            
        }else{
            
        }
    }];
    

    
    
    

}

    


@end
