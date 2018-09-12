//
//  ViewController.m
//  CoreAnimation-LayerGeometry-ContainsPoint
//
//  Created by 张晓琪 on 2018/9/12.
//  Copyright © 2018年 张晓琪. All rights reserved.
//

#import "ViewController.h"

#define USEHITTEST 0

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (weak, nonatomic) IBOutlet UIView *subLayerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [touches.anyObject locationInView:self.view];
    // 从根图层向上开始遍历，因为若父图层不含该 point，则子图层一定不含该 point。
#if USEHITTEST
    [self useContainsPoint:point];
#else
    [self useHitTest:point];
#endif
}

- (void)useContainsPoint:(CGPoint)point
{
    point = [self.layerView.layer convertPoint:point fromLayer:self.view.layer];
    if ([self.layerView.layer containsPoint:point]) {
        point = [self.subLayerView.layer convertPoint:point fromLayer:self.layerView.layer];
        if ([self.subLayerView.layer containsPoint:point]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"touch point is on red layer" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alertView show];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"touch point is on green layer" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alertView show];
        }
    } else {
        NSLog(@">>>not contain the touch point");
    }
}

- (void)useHitTest:(CGPoint)point
{
    CALayer *layer = [self.layerView.layer hitTest:point];
    // == 比较的是两个对象的内存地址
    if (layer == self.layerView.layer) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"touch point is on green layer" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alertView show];
    } else if (layer == self.subLayerView.layer) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"touch point is on red layer" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alertView show];
    } else {
        NSLog(@">>>not contain the touch point");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
