//
//  NumberCell.m
//  ProyectoFinalDispositivosMoviles
//
//  Created by Rodolfo Andrés Ramírez Valenzuela on 12/03/15.
//  Copyright (c) 2015 Rodolfo Andrés Ramírez Valenzuela. All rights reserved.
//

#import "NumberCell.h"

@implementation NumberCell

-(id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        
    }
    return self;
}

-(void) loadCell: (classFeedItem*) feedItem{
    [txtText setText:feedItem.text];
    [imgPicture setImage:[UIImage imageNamed:feedItem.imagePath]];
}

@end
