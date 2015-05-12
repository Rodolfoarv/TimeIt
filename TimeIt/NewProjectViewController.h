//
//  NewProjectViewController.h
//  SidebarDemo
//
//  Created by Rodolfo Andrés Ramírez Valenzuela on 16/04/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

#import "ViewController.h"

@interface NewProjectViewController : ViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tfNew;
@property (weak, nonatomic) IBOutlet UITextField *tfDescription;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

@end
