//
//  LF_ShowTopView.m
//  LFInke
//
//  Created by slimdy on 2017/5/9.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_ShowTopView.h"
@interface LF_ShowTopView()
@property (nonatomic,strong)NSMutableArray *btnArr;
@property (nonatomic,weak)UIView *lineView;
@end
@implementation LF_ShowTopView
- (NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)setTitleNames:(NSArray *)titleNames{
    _titleNames = titleNames;
    for (NSInteger i = 0; i<titleNames.count; i++) {
        NSString *title = titleNames[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(BtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        btn.tag = i;
        [self.btnArr addObject:btn];
        [self addSubview:btn];

        
    }
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor whiteColor];
    self.lineView = line;
    [self addSubview:line];
}
-(void)BtnDidClick:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(showTopView:didClickButton:)]) {
        [self.delegate showTopView:self didClickButton:btn];
        [UIView animateWithDuration:0.5 animations:^{
            self.lineView.centerX = btn.centerX;
        }];
        
    }
}
-(void)scrolling:(NSInteger)index{
    UIButton *btn = self.btnArr[index];
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.centerX = btn.centerX;
    }];
   
}
-(void)layoutSubviews{
    NSLog(@"%s",__func__);
    [super layoutSubviews];
    CGFloat x= 0;
    CGFloat y = 0;
    CGFloat w = self.width/self.btnArr.count;
    CGFloat h = self.height;
    for (NSInteger i = 0; i<self.btnArr.count; i++) {
        x = i*w;
        UIButton *btn = self.btnArr[i];
        btn.frame = CGRectMake(x, y, w, h);
        
        if (i == 1) {
            self.lineView.top = h-12;
            self.lineView.width = [btn.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:18]].width;
            self.lineView.height = 2;
            self.lineView.centerX = btn.centerX;//先赋值宽 在赋值中心点
        }
       
    }
}
@end
