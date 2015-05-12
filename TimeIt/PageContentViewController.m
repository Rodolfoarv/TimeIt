//
//  PageContentViewController.m
//  testPageController
//
//  Created by Andres Pelaez on 3/9/15.
//  Copyright (c) 2015 Andres Pelaez. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.alpha = 0.5;*/
    //self.contTabla=[NSMutableArray arrayWithArray:@[@"Dato 1",@"Dato2",@"Dato3"]];
    //self.detaTabla=[NSMutableArray arrayWithArray:@[@"Resp 1",@"Resp2",@"Resp3"]];
    //self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
    self.titleLabel.text = self.titleText;
    UITableViewCell *rellena;
    NSLog(@"%@",self.contTabla);
    NSLog(@"%@",self.detaComp);
    NSLog(@"%@",self.detaTabla);
    for (NSInteger i=0; i<self.contTabla.count; i++) {
        rellena=[self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        rellena.textLabel.text=self.contTabla[i];
    }
    /*
     UITableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:@"CeldasVC" forIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
     
     cell.textLabel.text = self.estados[indexPath.row];
     cell.detailTextLabel.text = self.capitales[indexPath.row];
     */
    if (self.contTabla.count==0) {
        self.btNewtable.hidden=NO ;
        self.table.hidden=YES;
    }else{
        self.btNewtable.hidden=YES;
        self.table.hidden=NO;
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
#pragma mark - Mètodos de TableView

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contTabla.count;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *strTitulo=[NSString stringWithFormat:@"Contenido"];
    return strTitulo;
}

-(NSArray*) sectionIndexTitlesForTableView:(UITableView *)tableView{
    return @[];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *celda = [tableView dequeueReusableCellWithIdentifier:@"CeldasVC" forIndexPath:indexPath];
    
    //NSString *strNumero = [NSString stringWithFormat:@"%ld", (indexPath.row+1)+(indexPath.section)*10];
    
    if ((indexPath.row+1)%7==0) {
        celda.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        celda.accessoryType=0;
    }
    
    celda.textLabel.text = self.contTabla[indexPath.row];
    //NSLog(@"%@",self.contTabla[indexPath.row]);
    celda.detailTextLabel.text=self.detaTabla[indexPath.row];
    //NSLog(@"%@",self.contTabla[indexPath.row]);
    return celda;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     NSInteger valor= (indexPath.row+1)+(indexPath.section)*10;
     
     NSString *mensaje= [NSString stringWithFormat:@"El triple de %ld es %ld",valor,3*valor];
     */
    PFObject *task = [PFObject objectWithClassName:@"Task"];
    
    NSString *strMensaje = self.detaComp[indexPath.row];
    
    UIAlertController *alerta=[UIAlertController alertControllerWithTitle:@"Detail" message:strMensaje preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertController *modif=[UIAlertController alertControllerWithTitle:@"Modify" message:strMensaje preferredStyle:(UIAlertControllerStyleAlert)];
    
    [modif addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"Title", nil);
     }];
    [modif addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"Detail", nil);
     }];
    UIAlertAction *aceptMod=[UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){//Modificar valores.
            //Creates the new task
            PFObject *task = [PFObject objectWithClassName:@"Task"];
            task[@"title"] = ((UITextField *)[modif.textFields objectAtIndex:0]).text;
            task[@"description"] = ((UITextField *)[modif.textFields objectAtIndex:1]).text;
            task[@"category"] = self.titleText;
            [userTasks addObject:task];
            [task save];
        PFUser *user = [PFUser currentUser];
        
        PFRelation *projectForTask = [task relationForKey:@"taskProject"];
        [projectForTask addObject:_parentProject];
        [task save];
        
        PFRelation *userForTask = [task relationForKey:@"taskUser"];
        [userForTask addObject:user];
        [task save];
        
        PFRelation *taskForUser = [user relationForKey:@"userTask"];
        [taskForUser addObject:task];
        [user save];
        
        PFRelation *taskForProject = [_parentProject relationForKey:@"projectTask"];
        [taskForProject addObject:task];
        [_parentProject save];
        NSLog(@"LLegue aqui?");
        
        
        
        
        
    }];
    UIAlertAction *cancelMod=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];

    [modif addAction:cancelMod];
        [modif addAction:aceptMod];
    
    UIAlertAction *accionBorrar=[UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        //Añadir Query para quitar elemento.
        
        task[@"title"] = self.detaTabla[indexPath.row];
        task[@"description"] = self.detaComp[indexPath.row];
        
        
        NSString *taskName = self.contTabla[indexPath.row];
        //NSString *taskDesc = self.detaTabla[indexPath.row];
        PFObject *taskToDelete = nil;
        
        //NSLog(@"Eso1");
        //Obtaining the id of that project
        for (PFObject *task in userTasks){
            NSString *taskN = task[@"title"];
            //NSString *taskD = task[@"description"];
            if ([taskN isEqualToString:taskName]){
                taskToDelete = task;
            }
        }
        //NSLog(@"eso2");
        //Query to delete project
        PFQuery *query = [PFQuery queryWithClassName:@"Task"];
        if (taskToDelete != nil){
            [query getObjectInBackgroundWithId:taskToDelete.objectId block:^(PFObject *object, NSError *error) {
                if (!error){
                    [object deleteInBackground];
                    
                    [userTasks removeObject:taskToDelete];
                    
                    //Task eliminado
                    [HHAlertView showAlertWithStyle:HHAlertStyleOk inView:self.view Title:@"Success" detail:@"The changes will be shown shortly" cancelButton:nil Okbutton:@"Continue"];
                    [self.view setNeedsDisplay];
                    [self.table reloadData];
                    NSLog(@"Eso3");
                    
                }else{
                    //Error finding object in the query
                    NSLog(@"No se encontrò");
                }
            }];
        }else{
            //The task doesn't exist
            NSLog(@"El task no existe");
        }

        
        //[self.detaComp removeObject:self.detaComp[indexPath.row]];
    }];
    UIAlertAction *accionMod=[UIAlertAction actionWithTitle:@"Modify" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self presentViewController:modif animated:YES completion:nil];
    }];
    
    UIAlertAction *accionCancelar=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    
    [alerta addAction:accionMod];
    [alerta addAction:accionBorrar];
    [alerta addAction:accionCancelar];
    
    NSString *strTemp = self.contTabla[indexPath.row];
    
    if ([strTemp isEqualToString:@"Añadir"]) {
        [self presentViewController:modif animated:YES completion:nil];
    }else{
    [self presentViewController:alerta animated:YES completion:nil];
    }
}
#pragma mark TabNueva

- (IBAction)nuevaTab:(id)sender {
    NSString *strMensaje = [NSString stringWithFormat:@"Creating new table"];
    
    UIAlertController *alerta=[UIAlertController alertControllerWithTitle:@"Details" message:strMensaje preferredStyle:(UIAlertControllerStyleAlert)];
    
    [alerta addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"Title", @"Title");
     }];
    [alerta addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"Task", @"Task");
     }];
    [alerta addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"Description", @"Description");
     }];
    
    UIAlertAction *aceptMod=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){//Modificar valores.
        
        //Añadir Query para crear
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            //Creates the new task with new category
            PFObject *task = [PFObject objectWithClassName:@"Task"];
            task[@"title"] = ((UITextField *)[alerta.textFields objectAtIndex:1]).text;
            task[@"description"] = ((UITextField *)[alerta.textFields objectAtIndex:2]).text;
            
            task[@"category"] = ((UITextField *)[alerta.textFields objectAtIndex:0]).text;
            
            [userTasks addObject:task];
            
            //[task save];
            
            PFUser *user = [PFUser currentUser];
            
            PFRelation *projectForTask = [task relationForKey:@"taskProject"];
            [projectForTask addObject:_parentProject];
            //[task save];
            
            PFRelation *userForTask = [task relationForKey:@"taskUser"];
            [userForTask addObject:user];
            [task save];
            
            PFRelation *taskForUser = [user relationForKey:@"userTask"];
            [taskForUser addObject:task];
            [user save];
            
            PFRelation *taskForProject = [_parentProject relationForKey:@"projectTask"];
            [taskForProject addObject:task];
            [_parentProject save];
            
        });
    }];
    UIAlertAction *cancelMod=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alerta addAction:aceptMod];
    [alerta addAction:cancelMod];
    [self presentViewController:alerta animated:YES completion:nil];
    
    
}
#pragma mark linkUser
- (IBAction)nuevUsr:(id)sender {
    NSString *strMensaje =[NSString stringWithFormat:@"Introducir el id del usuario que se quiere ligar al proyecto."];
    UIAlertController *add=[UIAlertController alertControllerWithTitle:@"Proyecto" message:strMensaje preferredStyle:(UIAlertControllerStyleAlert)];
    [add addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"Id", nil);
     }];
    
    UIAlertAction *cancelAdd=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *aceptAdd=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"Gah1");
        PFObject *project = [PFObject objectWithClassName:@"Project"];
        project[@"name"] = self.parentProject[@"name"];
        //Retrieving the user to set the relation between user and project
        PFObject *user = [PFObject objectWithClassName:@"User"];
        
        user[@"name"]=((UITextField *)[add.textFields objectAtIndex:0]).text;
        user[@"projectsPartOf"] = self.parentProject;
        [user save];
        NSLog(@"Gah2");
        //Get the user relation
                //Add a user to the project
        NSLog(@"Gah3");
        
        NSString *mail =((UITextField *)[add.textFields objectAtIndex:0]).text;
        PFQuery *query = [PFQuery queryWithClassName:@"User"];
        [query whereKey:@"email" equalTo:mail];
        //[query getFirstObjectInBackgroundWithBlock];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *nUser, NSError *error) {
            if (error) {
                NSLog(@"The getFirstObject request failed.");
            } else {
                // The find succeeded.
                NSLog(@"Successfully retrieved the object.");
                NSLog(nUser);
                
                PFRelation *userForProjects = [_parentProject relationForKey:@"projectUsers"];
                [userForProjects addObject:nUser];
                [_parentProject save]; //Save the project with the data inserted
                //Now add a project to the user
                PFRelation *projectsForuser = [nUser relationForKey:@"userProjects"];
                [projectsForuser addObject:_parentProject];
                [nUser save];
            }
        }];
    
    }];
    
    [add addAction:cancelAdd];
    [add addAction:aceptAdd];
    [self presentViewController:add animated:YES completion:nil];
}




@end
