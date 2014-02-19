//
//  IDKSCanvas.m
//  PaintSharing
//
//  Created by Luciano Oliveira on 28/11/13.
//  Copyright (c) 2013 IDKS. All rights reserved.
//

#import "IDKSCanvas.h"

@implementation Pair

- (id)initWithPath:(UIBezierPath *)path andColor:(UIColor *)color
{
    if (self = [self init])
    {
        self.bezierPath = path;
        self.color = color;
    }
    
    return self;
}

@end

#pragma mark - IDKSCanvas implementation.
@implementation IDKSCanvas

/*!
 @discussion drawRect method override for draw the paths in the
 view.
 */
-(void)drawRect:(CGRect)rect
{
    if (![self.delegate conformsToProtocol:@protocol (IDKSCanvasDelegate)])
        return;
    
    for (Pair *pair in [self.delegate drawPaths])
    {
        [pair.color setStroke];
        [pair.bezierPath stroke];
    }
}

- (UIImage *)getImage
{
    // The last parameter (scale factor) is 0.0 for don't lose quality.
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
