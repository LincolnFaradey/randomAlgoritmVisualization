//
//  ViewController.m
//  Algorithms
//
//  Created by Andrei Nechaev on 2/25/15.
//  Copyright (c) 2015 Andrei Nechaev. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController (){
    int n;
    UIView *algView;
}

@property (nonatomic, strong) NSMutableArray *layers;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    algView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 250, 250)];
    algView.center = self.view.center;
    algView.layer.borderColor = [UIColor blackColor].CGColor;
    algView.layer.borderWidth = 1.0;
    algView.transform = CGAffineTransformMakeRotation(M_PI);
//    algView.layer.shouldRasterize = YES;
//    algView.layer.drawsAsynchronously = YES;
    
    _layers = [[NSMutableArray alloc] init];
    
    [self.view addSubview:algView];
    [self.view setNeedsDisplay];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self alg];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alg
{
    CGFloat height = algView.frame.size.height;
    CGFloat width = algView.frame.size.width;
    n = 1000;
    

    
    for (int i = 0; i < n; ++i) {
        CALayer *layer = [[CALayer alloc] init];
        int tmp = arc4random_uniform((int)height);
        double x = i % (int)width;
        double y = tmp;
        
        layer.frame = CGRectMake(x, y, 1, -y);
        [_layers addObject:layer];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(addLayer) userInfo:nil repeats:YES];
    
}


- (void)addLayer
{
    static int count = 0;
    
    if (count >= n) {
        [self.timer invalidate];
        return;
    }
    CALayer *layer = _layers[count];

    layer.backgroundColor = [self randomColor].CGColor;
    
    UIGraphicsBeginImageContextWithOptions(algView.bounds.size, NO, 1.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    [algView.layer addSublayer:layer];
    [algView.layer renderInContext:context];
    
    //        [algView drawViewHierarchyInRect:algView.bounds afterScreenUpdates:YES];
    algView.layer.contents = (__bridge id) UIGraphicsGetImageFromCurrentImageContext().CGImage;
    UIGraphicsEndImageContext();
    algView.layer.sublayers = nil;
//    [self.layers removeObjectAtIndex:count];
    NSLog(@"Counter %d", count);
    count++;
}

- (UIColor *)randomColor
{
    
    float red = arc4random_uniform(255);
    float green = arc4random_uniform(255);
    float blue = arc4random_uniform(255);
    
    return [UIColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:1.0];
}

@end
