//
//  NewProjectViewController.m
//  SidebarDemo
//
//  Created by Rodolfo Andrés Ramírez Valenzuela on 16/04/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

#import "NewProjectViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Global.h"
#import "HHAlertView.h"

@interface NewProjectViewController ()

@end

@implementation NewProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

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
- (IBAction)picChoosing:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.picImageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (IBAction)createProject:(id)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //Creates the new project
        PFObject *project = [PFObject objectWithClassName:@"Project"];
        project[@"name"] = self.tfNew.text;
        project[@"details"] = self.tfDescription.text;
        
        //Making the image NSData in order for it to be a PFFile
        
        NSData *imageData = UIImagePNGRepresentation(self.picImageView.image);
        PFFile *imageFile = [PFFile fileWithData:imageData];
        project[@"image"] = imageFile;
    
        if (self.tfNew.text.length >0 && self.tfDescription.text.length > 0)
        {
            [userProjects addObject:project];
            [project save];
        }else{
            NSLog(@"error");
        }
        
        //Retrieving the user to set the relation between user and project
        PFUser *user = [PFUser currentUser]; //Retrieve the currentUser that is logged
        user[@"projectsPartOf"] = @2;
        [user save];
        
        //Get the user relation
        PFRelation *userForProjects = [project relationForKey:@"projectUsers"];
        //Add a user to the project
        [userForProjects addObject:user];
        [project save]; //Save the project with the data inserted
        
        //Now add a project to the user
        PFRelation *projectsForuser = [user relationForKey:@"userProjects"];
        [projectsForuser addObject:project];
        //NSInteger *projectsCount = [user[@"projectsPartOf"] integerValue] + 1;
        //user[@"projectsPartOf"] = projectsCount;
        
        [user save];
        

        
        

        
        
        UIStoryboard *sb = self.storyboard;
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"main"];
        
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        //returns the pointer to the whole application
        
        //Makes the main as the new initial VC
        //app.window.rootViewController = vc;
        
        //animation
        [UIView transitionWithView:app.window duration:0.7 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            app.window.rootViewController = vc;
            
        } completion:nil];

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HHAlertView showAlertWithStyle:HHAlertStyleOk inView:self.view Title:@"Success" detail:@"You have created a project" cancelButton:nil Okbutton:@"Sure"];
    });


    
    
    
    
    
    /*
    
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
            
            UIStoryboard *sb = self.storyboard;
            UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"projectsVC"];
            
            AppDelegate *app = [[UIApplication sharedApplication] delegate];
            //returns the pointer to the whole application
            
            //Makes the main as the new initial VC
            //app.window.rootViewController = vc;
            
            //animation
            [UIView transitionWithView:app.window duration:0.7 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
                app.window.rootViewController = vc;
                
            } completion:nil];
            
            
        }else{
            
        }
    }];
    */
    

}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.tfDescription isFirstResponder] && [touch view] != self.tfDescription) {
        [self.tfDescription resignFirstResponder];
    }
    else if ([self.tfNew isFirstResponder] && [touch view] != self.tfNew) {
        [self.tfNew resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}







@end
