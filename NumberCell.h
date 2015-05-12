//
//  NumberCell.h
//  ProyectoFinalDispositivosMoviles
//
//  Created by Rodolfo Andrés Ramírez Valenzuela on 12/03/15.
//  Copyright (c) 2015 Rodolfo Andrés Ramírez Valenzuela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "classFeedItem.h"

@interface NumberCell : UICollectionViewCell{
    IBOutlet UIImageView *imgPicture;
    IBOutlet UILabel *txtText;
}

-(void) loadCell: (classFeedItem*) feedItem;


@end
