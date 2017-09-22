//
//  LF_ShowViewController.m
//  LFInke
//
//  Created by slimdy on 2017/5/8.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_ShowViewController.h"
#import "LF_ShowTopView.h"
@interface LF_ShowViewController ()<UIScrollViewDelegate,LF_ShowTopViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (nonatomic,strong)NSArray *dataList;
@property (nonatomic,strong)NSArray *titleList;
@property (nonatomic,weak)LF_ShowTopView *topView;
@end
#pragma mark ---http://116.211.167.106/api/live/gettop?&logid=185,165,205,208
@implementation LF_ShowViewController
-(NSArray *)dataList{
    if (!_dataList) {
        _dataList = @[@"LF_FocusViewController",@"LF_HotViewController",@"LF_NearViewController"];
    }
    return _dataList;
}
-(NSArray *)titleList{
    if (!_titleList) {
        _titleList = @[@"关注",@"热门",@"附近"];
    }
    return _titleList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupNavigationBar];
    [self initUI];
}
- (void)setupNavigationBar{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStyleDone target:nil action:nil];
    LF_ShowTopView *topView = [[LF_ShowTopView alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    topView.titleNames = self.titleList;
    topView.delegate = self;
    self.topView = topView;
    self.navigationItem.titleView = topView;
    
}
-(void)initUI{
    NSInteger i = 0;
    for (NSString *VCName in self.dataList) {
      UIViewController*VC = [[NSClassFromString(VCName) alloc]init];
        VC.title = self.titleList[i];
        [self addChildViewController:VC];//当执行这句话时 不会执行这个控制器的ViewDidLoad
        i++;
    }
    self.contentScrollView.contentSize = CGSizeMake(self.dataList.count*SCREEN_WIDTH, 0);
    self.contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    self.contentScrollView.pagingEnabled = YES;
    [self scrollViewDidEndDecelerating:self.contentScrollView];//让他先加载一个view
}
// 拖拽减速结束后调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat width = SCREEN_WIDTH;
//    CGFloat height = SCREEN_HEIGHT;
    NSInteger index = scrollView.contentOffset.x/width;
    [self.topView scrolling:index];
    UIViewController *VC = self.childViewControllers[index];
    if ([VC isViewLoaded]) {
        return;
    }
    VC.view.frame = CGRectMake(scrollView.contentOffset.x, 0,scrollView.frame.size.width, scrollView.frame.size.height);
//    NSLog(@"%f",scrollView.frame.size.width);
    [scrollView addSubview:VC.view];
}
//动画结束后调用
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndDecelerating:scrollView];
    
}
-(void)showTopView:(LF_ShowTopView *)topView didClickButton:(UIButton *)btn{
    NSInteger tag = btn.tag;
    CGPoint point = CGPointMake(tag * SCREEN_WIDTH, self.contentScrollView.contentOffset.y);
    [self.contentScrollView setContentOffset:point animated:YES];
}

@end
