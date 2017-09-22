//
//  LF_HotViewController.m
//  LFInke
//
//  Created by slimdy on 2017/5/8.
//  Copyright © 2017年 slimdy. All rights reserved.
//
#import "LF_PlayerController.h"
#import "LF_HotViewController.h"
#import "LF_GetHotLiveTool.h"
#import "LF_HotLiveModel.h"
#import "LF_LiveCell.h"
#import "LF_TaBbar.h"
#import "LF_TabBarController.h"
@interface LF_HotViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *hotLives;
@end

@implementation LF_HotViewController
static NSString *Identifier = @"hotCell";
-(NSMutableArray *)hotLives{
    if (!_hotLives) {
        _hotLives = [NSMutableArray array];
    }
    return _hotLives;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self loadData];
    
}
-(void)setupUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"LF_LiveCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Identifier];
    
    
}
-(void)loadData{
    [LF_GetHotLiveTool getHotLiveWithSuccess:^(id result) {
        [self.hotLives addObjectsFromArray:result];
        [self.tableView reloadData];
        
    } failure:^(id error) {
        NSLog(@"%@",error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.hotLives.count;;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LF_LiveCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier ];
    
    cell.live = self.hotLives[indexPath.row];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_WIDTH+70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LF_PlayerController *playerVC = [[LF_PlayerController alloc]init];
    playerVC.live = self.hotLives[indexPath.row];
    [self.navigationController pushViewController:playerVC animated:YES];
    
    
}

@end
