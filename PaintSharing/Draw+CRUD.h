//
//  Draw+CRUD.h
//  PaintSharing
//
//  Created by Luciano Oliveira on 10/02/14.
//  Copyright (c) 2014 IDKS. All rights reserved.
//

#import "Draw.h"

/*!
 @discussion Category for Draw managed object.
 Contains the operations for perform the CRUD operations.
 */
@interface Draw (CRUD)

/*!
 @discussion Create operation.
 @param name    The unique name of the draw.
 @param context The managed object context (DB).
 @return The created draw.
 */
+ (Draw *)createWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context;

/*!
 @discussion Read operation.
 @param name    The unique name of the draw.
 @param context The managed object context (DB).
 */
+ (Draw *)readByName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context;


+ (void)deleteDraw:(Draw *)draw inManagedObjectContext:(NSManagedObjectContext *)context;

// TODO: implement the other operations.

@end