//
//  IDKSViewController.m
//  PaintSharing
//
//  Created by Luciano Oliveira on 28/11/13.
//  Copyright (c) 2013 IDKS. All rights reserved.
//

#import "IDKSViewController.h"
#import "IDKSShareViewController.h"
#import "IDKSCanvas.h"
#import "Path+CRUD.h"
#import "IDKSAppDelegate.h"
#import "Draw.h"


@interface IDKSViewController () <IDKSCanvasDelegate, UIActionSheetDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet IDKSCanvas *canvas;
@property(nonatomic, strong) UIColor *lineColor;
@property(nonatomic, strong) NSMutableArray *paths;

@end

@implementation IDKSViewController


- (NSMutableArray *)paths
{
    if (!_paths)
    {
        _paths = [[NSMutableArray alloc] init];
        
        if (self.draw)
        {
            // Open an existing draw.
            self.navigationItem.title = self.draw.name;
            for (Path *path in self.draw.paths)
                [_paths addObject:[[Pair alloc] initWithPath:path.bezierPath andColor:path.color]];
            
            // Redraw the canvas with the news bezier paths.
            [self.canvas setNeedsDisplay];
        }
    }
    
    return _paths;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.canvas.layer setBorderWidth:5.0];
    [self.canvas.layer setBorderColor:[UIColor grayColor].CGColor];
    
    [self.canvas setDelegate:self];
}


- (IBAction)selectColor:(UIButton *)sender
{
    self.lineColor = sender.backgroundColor;
}


- (IBAction)openDrawOptions:(id) sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Options"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Save", @"Share Draw", nil];
    
    [actionSheet showFromBarButtonItem:sender animated:YES];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // If the color is white, the line width is superior (eraser).
    CGFloat width = (self.lineColor == [UIColor whiteColor])? 70.0 : 2.0;
    [path setLineWidth:width];
    
    // Set the starting point of the draw line.
    [path moveToPoint:[[touches anyObject] locationInView:self.canvas]];
    
    // Add the pair path/color to array.
    [self.paths addObject:[[Pair alloc] initWithPath:path andColor:self.lineColor]];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Draw line.
    [[[self.paths lastObject] bezierPath] addLineToPoint:[[touches anyObject] locationInView:self.canvas]];
    // Redraw the view.
    [self.canvas setNeedsDisplay];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Do the same thing as touchesMoved.
    [self touchesMoved:touches withEvent:event];
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Do the same thing as touchesMoved.
    [self touchesMoved:touches withEvent:event];
}

#pragma mark - IDKSCanvasDelegate methods.
- (NSArray *)drawPaths
{
    return self.paths;
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:// Save.
            [self saveAction];
            break;
            
        case 1:// Share the draw.
            [self shareAction];
            break;
            
        default:
            break;
    }
}


- (void)saveAction
{
    // If the draw have a name, so it's for update.
    if (![self.navigationItem.title isEqualToString:@"Paint"])
    {
        [self saveInDB:self.navigationItem.title];
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"draw name" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}


- (void)shareAction
{
    /*
     Opens the share options table using the UINavigationController programmatically.
     Also instantiates the table view controller with the storyboard.
     */
    IDKSShareViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ShareOptions"];
    controller.draw = [self.canvas getImage];
    
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
        return;
    
    // Create in DB.
    [self saveInDB: [[alertView textFieldAtIndex:0] text]];
}


- (void)saveInDB:(NSString *)drawName
{
    IDKSAppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.managedObjectContext performBlock:^{
        for (Pair *pair in self.paths)
            [Path createWithBezierPath:pair.bezierPath color:pair.color andDrawName:drawName inManagedObjectContext:app.managedObjectContext];
        
        NSError *error;
        [app.managedObjectContext save:&error];
        if (error)
            NSLog(@"ERROR DURING SAVING THE DRAW: %@", error.localizedDescription);
    }];
}

@end
