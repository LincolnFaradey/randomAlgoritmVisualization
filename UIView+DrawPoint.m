//
//  UIView+DrawPoint.m
//  Algorithms
//
//  Created by Andrei Nechaev on 2/25/15.
//  Copyright (c) 2015 Andrei Nechaev. All rights reserved.
//

#import "UIView+DrawPoint.h"

@implementation UIView (DrawPoint)

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor * redColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    
    CGContextSetFillColorWithColor(context, redColor.CGColor);
    CGContextFillRect(context, self.bounds);
}

@end
