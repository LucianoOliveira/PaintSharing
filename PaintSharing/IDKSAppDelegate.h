//
//  IDKSAppDelegate.h
//  PaintSharing
//
//  Created by Luciano Oliveira on 28/11/13.
//  Copyright (c) 2013 IDKS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDKSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
