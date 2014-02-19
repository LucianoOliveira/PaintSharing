//
//  IDKSCanvas.h
//  PaintSharing
//
//  Created by Luciano Oliveira on 28/11/13.
//  Copyright (c) 2013 IDKS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Pair : NSObject

@property(nonatomic, strong) UIBezierPath *bezierPath;
@property(nonatomic, strong) UIColor *color;


- (id)initWithPath:(UIBezierPath *)path andColor:(UIColor *)color;

@end


@protocol IDKSCanvasDelegate <NSObject>

@required
- (NSArray *) drawPaths;

@end


@interface IDKSCanvas : UIView

@property(nonatomic, weak) id<IDKSCanvasDelegate> delegate;
-(UIImage*)getImage;
@end
