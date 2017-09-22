//
//  LF_TaBbar.m
//  LFInke
//
//  Created by slimdy on 2017/5/8.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_TaBbar.h"
@interface LF_TaBbar()
@property (nonatomic,weak)UIImageView *tabBarBackgroundView;
@property (nonatomic,strong)UIButton *lastBtn;
@property (nonatomic,weak)UIButton *cameraBtn;
@property (nonatomic,strong)NSMutableArray *nomalBtns;
@end
@implementation LF_TaBbar
-(NSMutableArray *)nomalBtns{
    if (!_nomalBtns) {
        _nomalBtns = [NSMutableArray array];
    }
    return _nomalBtns;
}
-(UIButton *)cameraBtn{
    if (!_cameraBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        [btn sizeToFit];
        [btn addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = LFItemTypeLaunch;
        _cameraBtn = btn;
        
        [self addSubview:btn];
    }
    return _cameraBtn;
}
-(UIImageView *)tabBarBackgroundView{
    if (!_tabBarBackgroundView) {
        UIImageView *view = [[UIImageView alloc]init];
        _tabBarBackgroundView = view;
        [self addSubview:view];
    }
    return _tabBarBackgroundView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.tabBarBackgroundView.image = [UIImage imageNamed:@"global_tab_bg"];
    }
    return self;
}
-(void)setImagesNameArr:(NSArray *)imagesNameArr{
    _imagesNameArr = imagesNameArr;
    [self setupButtons];
}
-(void)setupButtons{
    for (NSInteger i = 0; i< self.imagesNameArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:self.imagesNameArr[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_p",self.imagesNameArr[i]]] forState:UIControlStateSelected];
        btn.adjustsImageWhenHighlighted = NO;//禁止图片在搞两下改变
        btn.tag = i;
        [self.nomalBtns addObject:btn];
        if(i == 0){
            btn.selected = YES;
            self.lastBtn = btn;
        }
        [btn addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}
-(void)ClickBtn:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(tabbar:DidClickedButton:)]) {
        [self.delegate tabbar:self DidClickedButton:btn.tag];
    }
    if (btn.tag == LFItemTypeLaunch) {
        return;
    }
    self.lastBtn.selected = NO;
    btn.selected = YES;
    self.lastBtn = btn;
    [UIView animateWithDuration:0.2 animations:^{
        btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            btn.transform = CGAffineTransformIdentity;
        }];
    }];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _tabBarBackgroundView.frame = self.bounds;
    NSInteger i = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.bounds.size.width/self.nomalBtns.count;
    CGFloat h = self.bounds.size.height;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            x = w *i;
            view.frame = CGRectMake(x, y, w, h);
            i++;
        }
        
    }
    [self.cameraBtn sizeToFit];
    self.cameraBtn.center = CGPointMake(self.bounds.size.width/2,10);
    
}
//用于检测之间的cameraBTN 点击上版权也能跳转到拍摄界面
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    //把点击的点 装换成 camera按钮上的点，如果点击的不在camera上 则返回的点
    CGPoint newPoint = [self convertPoint:point toView:self.cameraBtn];
    if ([self.cameraBtn pointInside:newPoint withEvent:event]) {
        return self.cameraBtn;
    }
    return [super hitTest:point withEvent:event];
    
}
@end
