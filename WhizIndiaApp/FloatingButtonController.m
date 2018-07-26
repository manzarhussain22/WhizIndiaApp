//
//  FloatingButtonController.m
//  AutoIHomes
//
//  Created by Manzar_Hussain on 23/07/18.
//  Copyright © 2018 AutoI Innovations Pvt. Ltd. All rights reserved.
//

#import "FloatingButtonController.h"
#import "FloatingButtonWindow.h"

@interface FloatingButtonController ()
{
    FloatingButtonWindow *window;
}

@end

@implementation FloatingButtonController

-(id)init {
    self = [super initWithNibName:nil bundle:nil];
    window = [[FloatingButtonWindow alloc] init];
    window.windowLevel = CGFLOAT_MAX;
    window.hidden = NO;
    window.rootViewController = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *view = [[UIView alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:@"" forState:UIControlStateNormal];
    
    button.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    button.layer.shadowRadius = 3;
    button.layer.shadowOpacity = 0.8;
    button.layer.shadowOffset = CGSizeZero;
    [button sizeToFit];
    button.frame = CGRectMake(10., 10., button.bounds.size.width, button.bounds.size.height);
    [view addSubview:button];
    self.view = view;
    self.floatingButton = button;
    window.button = button;
    
    UIPanGestureRecognizer *panner = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDidFire:)];
    [button addGestureRecognizer:panner];

}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}

-(void)panDidFire:(UIPanGestureRecognizer *)panner {
    
    CGPoint offset = [panner translationInView:self.view];
    [panner setTranslation:CGPointZero inView:self.view];
    CGPoint center = _floatingButton.center;
    center.x += offset.x;
    center.y += offset.y;
    _floatingButton.center = center;
    
    if (panner.state == UIGestureRecognizerStateEnded || panner.state == UIGestureRecognizerStateCancelled) {
        [UIView animateWithDuration:0.3 animations:^{
            [self snapButtonToSocket];
        }];
    }
}

-(void)snapButtonToSocket {
    CGPoint bestSocket = CGPointZero;
    CGPoint distanceToBestSocket = cgfloat
}

//private func snapButtonToSocket() {
//    var bestSocket = CGPoint.zero
//    var distanceToBestSocket = CGFloat.infinity
//    let center = button.center
//    for socket in sockets {
//        let distance = hypot(center.x - socket.x, center.y - socket.y)
//        if distance < distanceToBestSocket {
//            distanceToBestSocket = distance
//            bestSocket = socket
//        }
//    }
//    button.center = bestSocket
//}

-(NSArray *)sockets {
    CGSize buttonSize = _floatingButton.bounds.size;
    CGRect rect = CGRectInset(self.view.bounds, 4 + buttonSize.width/2, 4 + buttonSize.height / 2 );
    
    CGFloat minX = CGRectGetMinX(rect);
    CGFloat minY = CGRectGetMinY(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    CGFloat midX = CGRectGetMidX(rect);
    CGFloat midY = CGRectGetMidY(rect);

    NSArray *sockets = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(minX, minY)],[NSValue valueWithCGPoint:CGPointMake(minX, maxY)],[NSValue valueWithCGPoint:CGPointMake(maxX, minY)],[NSValue valueWithCGPoint:CGPointMake(maxX, maxY)],[NSValue valueWithCGPoint:CGPointMake(midX, midY)], nil];
    return sockets;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

