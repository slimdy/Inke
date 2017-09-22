//
//  LF_MeViewController.m
//  LFInke
//
//  Created by slimdy on 2017/5/16.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_MeViewController.h"
#import "LF_UserInfoView.h"
#import "LF_SettingModel.h"
@interface LF_MeViewController ()
@property (nonatomic,strong)LF_UserInfoView *UserInfoView;
@property (nonatomic,strong)NSArray *settings;
@end

@implementation LF_MeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
-(LF_UserInfoView *)UserInfoView{
    if (!_UserInfoView) {
        LF_UserInfoView *infoView = [LF_UserInfoView loadUserInfoView];
        _UserInfoView = infoView;
    }
    return _UserInfoView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [[UIColor alloc]initWithRed:32/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);
    self.tableView.rowHeight = 60;
    [self loadData];
}
-(void)loadData{
    LF_SettingModel * setting1 = [self createOneSettingWithTitle:@"映客贡献榜" SubTitle:@"" VCName:@""];
    LF_SettingModel * setting2 = [self createOneSettingWithTitle:@"收益" SubTitle:@"0 映票" VCName:@""];
    LF_SettingModel * setting3 = [self createOneSettingWithTitle:@"账户" SubTitle:@"0 钻石" VCName:@""];
    LF_SettingModel * setting4 = [self createOneSettingWithTitle:@"等级" SubTitle:@"3 级" VCName:@""];
    LF_SettingModel * setting5 = [self createOneSettingWithTitle:@"设置" SubTitle:@"" VCName:@""];
    NSArray *section1 = @[setting1,setting2,setting3];
    NSArray *section2 = @[setting4];
    NSArray *section3 = @[setting5];
    self.settings = @[section1,section2,section3];
}
-(LF_SettingModel *)createOneSettingWithTitle:(NSString *)title SubTitle:(NSString *)subTitle VCName:(NSString *)VCname{
    LF_SettingModel *setting = [[LF_SettingModel alloc]init];
    setting.title = title;
    setting.subTitle = subTitle;
    setting.VCName = VCname;
    return setting;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.settings.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.settings[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    LF_SettingModel *setting = self.settings[indexPath.section][indexPath.row];
    cell.textLabel.text = setting.title;
    cell.detailTextLabel.text = setting.subTitle;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
////    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
//    self.UserInfoView.height = self.UserInfoView.height-scrollView.contentSize.height;
//    NSLog(@"%f",self.UserInfoView.top);
//    
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [LF_UserInfoView loadUserInfoView];
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return SCREEN_HEIGHT * 0.5;
    }
    return 10;
}
@end
