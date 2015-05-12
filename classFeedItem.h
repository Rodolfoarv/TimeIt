//
//  classFeedItem.h
//  ProyectoFinalDispositivosMoviles
//
//  Created by Rodolfo Andrés Ramírez Valenzuela on 12/03/15.
//  Copyright (c) 2015 Rodolfo Andrés Ramírez Valenzuela. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface classFeedItem : NSObject{
    NSString *imagePath;
    NSString *text;
}

@property (nonatomic) NSString *imagePath;
@property (nonatomic)NSString* text;

@end
