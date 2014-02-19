//
//  Draw.h
//  PaintSharing
//
//  Created by Luciano Oliveira on 10/02/14.
//  Copyright (c) 2014 IDKS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Path;

@interface Draw : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSSet *paths;
@end

@interface Draw (CoreDataGeneratedAccessors)

- (void)addPathsObject:(Path *)value;
- (void)removePathsObject:(Path *)value;
- (void)addPaths:(NSSet *)values;
- (void)removePaths:(NSSet *)values;

@end
