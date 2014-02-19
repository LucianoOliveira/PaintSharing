//
//  Path+CRUD.m
//  PaintSharing
//
//  Created by Luciano Oliveira on 10/02/14.
//  Copyright (c) 2014 IDKS. All rights reserved.
//

#import "Path+CRUD.h"
#import "Draw+CRUD.h"

@implementation Path (CRUD)

+ (void)createWithBezierPath:(UIBezierPath *)path color:(UIColor *)color andDrawName:(NSString *)drawName inManagedObjectContext:(NSManagedObjectContext *)context
{
    Path *newPath = [NSEntityDescription insertNewObjectForEntityForName:@"Path"
                                                  inManagedObjectContext:context];
    
    newPath.bezierPath = path;
    newPath.color = color;
    Draw *draw = [Draw readByName:drawName inManagedObjectContext:context];
    newPath.draw = (draw)? draw : [Draw createWithName:drawName inManagedObjectContext:context];
}

@end
