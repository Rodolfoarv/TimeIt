//
//  MapViewController.h
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>{
    NSMutableArray *items;
    IBOutlet UICollectionView *itemsTable;
    
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
