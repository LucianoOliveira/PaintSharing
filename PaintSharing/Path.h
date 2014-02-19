//
//  Path.h
//  PaintSharing
//
//  Created by Luciano Oliveira on 10/02/14.
//  Copyright (c) 2014 IDKS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Draw;

@interface Path : NSManagedObject

@property (nonatomic, retain) UIColor *color;
@property (nonatomic, retain) UIBezierPath *bezierPath;
@property (nonatomic, retain) Draw *draw;

@end
