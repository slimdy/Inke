//
//  LF_LiveChatViewController.m
//  LFInke
//
//  Created by slimdy on 2017/5/12.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_LiveChatViewController.h"
#import "LF_HotLiveModel.h"
@interface LF_LiveChatViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *watchNumer;
@property (weak, nonatomic) IBOutlet UIButton *giftBtn;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic,strong)NSTimer *timer;
@end

@implementation LF_LiveChatViewController
-(void)setLive:(LF_HotLiveModel *)live{
    _live = live;
    //因为这里是setlive的方法，在外部调用时，是在懒加载中调用的 在调用的时候由于 控件还没有加载 所以不能在这里设置
    
//    __weak typeof(self) weakself = self;//防治block循环，下面是使用苹果原生代码检测
//    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        
//        //获取网络数据图片
//        
//        NSURL *URL = [NSURL URLWithString:live.creator.portrait];
//        
//        NSData *data = [NSData dataWithContentsOfURL:URL];
//        
//        UIImage *image = [UIImage imageWithData:data];
//        
//        //回调到主线程进行UI更新
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            weakself.iconView.image = image;
//            
//        });
//        
//    });

    
}
- (IBAction)giftClick:(id)sender {
    [self showMoreLoveAnimation];
}
-(void)showMoreLoveAnimation{
    //设置图片  随机图片
    NSString *imageName = @"heart_";
    //随机图片
    NSInteger random = arc4random()%6;
    UIImageView *loveView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%ld",imageName,(long)random]]];
    //设置图片大小
    loveView.bounds = CGRectMake(0, 0, 30, 25);
    //设置图片中心点，因为self.giftBtn.center 是以footerview 为坐标系的，所以手动装换成self.view的坐标
    CGPoint position = CGPointMake(self.giftBtn.centerX, self.giftBtn.centerY+(self.view.height-self.footerView.height)-5);
    loveView.center = position;
    //图片缩放从小到大
    loveView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:1 animations:^{
        loveView.transform =CGAffineTransformIdentity;
    } completion:nil];
     [self.view addSubview:loveView];
    
    
    //设置贝塞尔曲线
    UIBezierPath *Bpath = [UIBezierPath bezierPath];
    //起始点
    [Bpath moveToPoint:position];
    //随机左右
    CGFloat leftOrRight = arc4random()%2==1?1:-1;
    //随机偏移 幅度是200
    CGFloat randomOffset = (arc4random()%50+arc4random()%150)*leftOrRight;
    //绘制曲线  第一个点是终点，第二个和第三个是基准点
    [Bpath addCurveToPoint:CGPointMake(position.x, position.y-300) controlPoint1:CGPointMake(position.x-randomOffset, position.y-150) controlPoint2:CGPointMake(position.x+randomOffset,position.y-150 )];
    
    //帧动画
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.path = Bpath.CGPath;
    CGFloat duration = 3+arc4random()%5;
    keyFrameAnimation.repeatCount = 1;
    keyFrameAnimation.duration = duration;
    //完成后是否移除
    keyFrameAnimation.removedOnCompletion = NO;
    //上面如果添加 下面这条就得添加
    keyFrameAnimation.fillMode = kCAFillModeForwards;
    [loveView.layer addAnimation:keyFrameAnimation forKey:@"keyFrame"];
    [UIView animateWithDuration:duration animations:^{
        loveView.layer.opacity = 0;
    } completion:^(BOOL finished) {
        [loveView removeFromSuperview];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.iconView.layer.cornerRadius = 15;
    self.iconView.layer.masksToBounds = YES;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.live.creator.portrait] placeholderImage:[UIImage imageNamed:@"default_room"] options:0];
    [NSTimer scheduledTimerWithTimeInterval:2 block:^(NSTimer * _Nonnull timer) {
        self.watchNumer.text = [NSString stringWithFormat:@"%d",arc4random_uniform(10000)];
    } repeats:YES];
    
    //心形动画自动播放
    [self setupTimer];
}
-(void)setupTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
        [self showMoreLoveAnimation];
    } repeats:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    self.timer = nil;
    [self.timer invalidate];
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
