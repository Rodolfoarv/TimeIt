//
//  RPViewController.m
//  RPSlidingMenuDemo
//
//  Created by Paul Thorsteinson on 2/24/2014.
//  Copyright (c) 2014 Robots and Pencils Inc. All rights reserved.
//

#import "RPViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "Global.h"
#import "NewProjectViewController.h"
#import "HHAlertView.h"

@interface RPViewController () 
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,atomic) NSMutableArray *projectsArray;


@end

@implementation RPViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.alpha = 0.5;
    
    UIImage *btnNewImage = [UIImage imageNamed:@"Create New-50.png"];
    UIImage *btnDeleteImage = [UIImage imageNamed:@"Trash-50.png"];
    
    UIButton *newProjectView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [newProjectView addTarget:self action:@selector(newProject) forControlEvents:UIControlEventTouchUpInside];
    [newProjectView setBackgroundImage:btnNewImage forState:UIControlStateNormal];
    self.btnNew = [[UIBarButtonItem alloc] initWithCustomView:newProjectView];
    
    UIButton *deleteProjectView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [deleteProjectView addTarget:self action:@selector(deleteProject) forControlEvents:UIControlEventTouchUpInside];
    [deleteProjectView setBackgroundImage:btnDeleteImage forState:UIControlStateNormal];
    self.btnDelete = [[UIBarButtonItem alloc] initWithCustomView:deleteProjectView];
    
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:self.btnNew, self.btnDelete, nil];
    
}


#pragma mark - RPSlidingMenuViewController


-(NSInteger)numberOfItemsInSlidingMenu{
    NSInteger projectsCount = [userProjects count];
    if(projectsCount == 0){/*
        UIAlertController *alerta = [UIAlertController alertControllerWithTitle:@"No projects" message:@"To get started click the " preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *accion = [UIAlertAction actionWithTitle:@"I get it" style:UIAlertActionStyleDestructive handler:nil];
        [alerta addAction:accion];
        [self presentViewController:alerta animated:YES completion:nil];*/
        [self.lbProject setHidden:false];
    }else
    [self.lbProject setHidden:TRUE];
    return projectsCount;
    
  

    
    /*http://stackoverflow.com/questions/24766292/count-number-of-objects-in-pfrelation*/
}

//Customize the current cell, this is will set a Name, detail and image for the project
- (void)customizeCell:(RPSlidingMenuCell *)slidingMenuCell forRow:(NSInteger)row{
    
    PFFile *projectImage = [userProjects objectAtIndex:row][@"image"]; // get the image for the project
    [projectImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        UIImage *taskImage = [UIImage imageWithData:data];
        slidingMenuCell.textLabel.text = [userProjects objectAtIndex:row][@"name"];
        slidingMenuCell.detailTextLabel.text = [userProjects objectAtIndex:row][@"details"];
        slidingMenuCell.backgroundImageView.image = taskImage;
        
    }];
    
}

//This will detect which proyect are you in
#pragma mark Change to page controller
- (void)slidingMenu:(RPSlidingMenuViewController *)slidingMenu didSelectItemAtRow:(NSInteger)row{
    
    [super slidingMenu:slidingMenu didSelectItemAtRow:row];
    
    PFRelation *relation=[userProjects[row] relationForKey:@"projectTask"];
    PFQuery *query=relation.query;
    _proj=[userProjects objectAtIndex:row];
    _pageTitles =[NSMutableArray arrayWithArray:@[]];
    _pageContent =[NSMutableArray arrayWithArray:@[]];
    _pageDetails =[NSMutableArray arrayWithArray:@[]];
    [query orderByAscending:@"category"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *eso, NSError *error) {
        if (!error && eso.count!=0) {
            NSString *titulo = eso[0][@"category"];
            [_pageTitles addObject:titulo];
            userTasks=[NSMutableArray arrayWithArray:eso];
            for (PFObject *count in eso) {
                if (![count[@"category"] isEqualToString:titulo]) {
                    titulo = count[@"category"];
                    [_pageTitles addObject:titulo];
                }
            }
            
            
            
            _pageTitles =[NSMutableArray arrayWithArray:[_pageTitles arrayByAddingObject:@"Add"]];
            //_pageImages = [NSMutableArray arrayWithArray:@[@"page1.png",@"page2.png",@"page3.png",@"page4.png"]];
            //Se crea el controlador de páginas.
            
            self.pageviewcontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"PGVC"];
            
            self.pageviewcontroller.dataSource=self;
            PageContentViewController *starting=[self viewControllerAtIndex:0];
            
            NSArray *VCs=@[starting];
            NSLog(@"Freezeeeer");
            [self.pageviewcontroller setViewControllers:VCs direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
            NSLog(@"Freezeeeer");
            self.pageviewcontroller.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-10);
            [self addChildViewController:_pageviewcontroller];
            [self.view addSubview:_pageviewcontroller.view];
            [self.pageviewcontroller didMoveToParentViewController:self];
            NSLog(@"Cambio realizado");
        }
        //First time in the project
        if (eso.count==0) {
            NSLog(@"Entro?");
            _pageTitles =[NSMutableArray arrayWithArray:[_pageTitles arrayByAddingObject:@"Add"]];
            self.pageviewcontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"PGVC"];
            self.pageviewcontroller.dataSource=self;
            PageContentViewController *starting=[self viewControllerAtIndex:0];
            NSArray *VCs=@[starting];
            [self.pageviewcontroller setViewControllers:VCs direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
            NSLog(@"Freezeeeer");
            self.pageviewcontroller.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-30);
            [self addChildViewController:_pageviewcontroller];
            [self.view addSubview:_pageviewcontroller.view];
            [self.pageviewcontroller didMoveToParentViewController:self];
            NSLog(@"Cambio realizado");
        }
    }];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
}
#pragma mark - Data Source Page Controller

-(PageContentViewController *)viewControllerAtIndex:(NSUInteger)index{
    if (([self.pageTitles count]==0) || (index>=[self.pageTitles count])) {
        return nil;
    }
    PageContentViewController *page=[self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    
    //page.imageFile=self.pageImages[index];
    page.titleText=self.pageTitles[index];
    page.parentProject=self.proj;
    if (![page.titleText compare:@"Add"]) {
        page.contTabla=[NSMutableArray arrayWithArray:@[]];
        page.detaComp=[NSMutableArray arrayWithArray:@[]];
        page.detaTabla=[NSMutableArray arrayWithArray:@[]];
        page.pageIndex=index;
        return page;
    }else{
        NSMutableArray *titulosTasks=[NSMutableArray arrayWithArray:@[]];
        NSMutableArray *detalleTask=[NSMutableArray arrayWithArray:@[]];
        NSLog(@"%@", userTasks);
        for (PFObject *eso in userTasks) {
            if ([eso[@"category"] isEqualToString:self.pageTitles[index]]) {
                NSLog(@"CATEGORY %@", eso[@"category"]);
                NSLog(@"TITULO %@", eso[@"title"]);
                NSLog(@"DETALLE %@", eso[@"description"]);
                NSString *tit = eso[@"title"];
                NSString *det = eso[@"description"];
                
                titulosTasks=[NSMutableArray arrayWithArray:[titulosTasks arrayByAddingObject:tit]];
                detalleTask=[NSMutableArray arrayWithArray:[detalleTask arrayByAddingObject:det]];
            }
        }
        NSLog(@"Titulos %@", titulosTasks);
        NSLog(@"Detalles %@", detalleTask);
        titulosTasks=[NSMutableArray arrayWithArray:[titulosTasks arrayByAddingObject:@"Añadir"]];
        detalleTask=[NSMutableArray arrayWithArray:[detalleTask arrayByAddingObject:@"componente"]];
        page.contTabla=titulosTasks;
        page.detaTabla=detalleTask,
        page.detaComp=detalleTask;
        page.pageIndex=index;
        return page;
    }
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return [self.pageTitles count];
}

-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return 0;
}

-(void) newProject{
    UIStoryboard *sb = self.storyboard;
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"newProjectVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void) deleteProject{
    NSString *strMensaje = [NSString stringWithFormat:@"Specify the name:"];
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Deleting a project" message:strMensaje preferredStyle:(UIAlertControllerStyleAlert)];
    
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"Project name", nil);
         
     }];
    UIAlertAction *aceptMod=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){//Modificar valores.
        //Obtain the project to delete
        NSString *projectName = ((UITextField *)[alert.textFields objectAtIndex:0]).text;
        PFObject *projectToDelete = nil;
        
        //Obtaining the id of that project
        for (PFObject *project in userProjects){
            NSString *projectN = project[@"name"];
            if ([projectN isEqualToString:projectName]){
                projectToDelete = project;
            }
        }
        
        
        
        //Query to delete project
        PFQuery *query = [PFQuery queryWithClassName:@"Project"];
        if (projectToDelete != nil){
            [query getObjectInBackgroundWithId:projectToDelete.objectId block:^(PFObject *object, NSError *error) {
                if (!error){
                    [object deleteInBackground];
 
                    [userProjects removeObject:projectToDelete];

                    //Delete has been succesful
                    [HHAlertView showAlertWithStyle:HHAlertStyleOk inView:self.view Title:@"Success" detail:@"The project has been deleted" cancelButton:nil Okbutton:@"Continue"];
                    [self.view setNeedsDisplay];
                    [self.collectionView reloadData];
                    
                }else{
                    //Error finding object in the query
                    
                }
            }];
        }else{
            //The project doesn't exist
            [HHAlertView showAlertWithStyle:HHAlertStyleError inView:self.view Title:@"Error" detail:@"The project does not exist" cancelButton:nil Okbutton:@"Continue"];
        }



        
    }];

    UIAlertAction *cancelMod=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:aceptMod];
    [alert addAction:cancelMod];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}

@end
