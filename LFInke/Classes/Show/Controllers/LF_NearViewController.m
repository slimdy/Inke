//
//  LF_NearViewController.m
//  LFInke
//
//  Created by slimdy on 2017/5/8.
//  Copyright © 2017年 slimdy. All rights reserved.
//
#define  ItemWidth 100
#define  Margin 10
#import "LF_NearViewController.h"
#import "LF_GetHotLiveTool.h"
#import "LF_NearLiveCell.h"
#import "LF_PlayerController.h"
#import "LF_HotLiveModel.h"

@interface LF_NearViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *nearLives;
@end
@implementation LF_NearViewController
-(NSMutableArray *)nearLives{
    if (_nearLives == nil) {
        _nearLives = [NSMutableArray array];
    }
    return _nearLives;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
    [self loadData];
}
-(void)setupUI{
    [self.collectionView registerNib:[UINib nibWithNibName:@"LF_NearLiveCell" bundle:nil] forCellWithReuseIdentifier:@"NearCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.contentInset = UIEdgeInsetsMake(5, 5, 0, 5);

}
-(void)loadData{
    [LF_GetHotLiveTool getNearLiveWithSuccess:^(id result) {
        [self.nearLives addObjectsFromArray:result];
        [self.collectionView reloadData];
    } failure:^(id error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
}
#pragma mark --- UICollectionView的代理和数据源
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.nearLives.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LF_NearLiveCell *nearLiveCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NearCell" forIndexPath:indexPath];
    nearLiveCell.live = self.nearLives[indexPath.row];
    return nearLiveCell;
}
#pragma  mark --- uiconllectionView布局代理
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger count = self.collectionView.width/ ItemWidth;
    CGFloat  w = (self.collectionView.width - (count +1)*Margin)/count;
    return CGSizeMake(w, w+30);
}
#pragma mark --- UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    LF_PlayerController *playerVC = [[LF_PlayerController alloc]init];
    playerVC.live = self.nearLives[indexPath.row];
    [self.navigationController pushViewController:playerVC animated:YES];
}
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    LF_NearLiveCell *nearCell = (LF_NearLiveCell *)cell;
    if (!nearCell.live.isShow) {
        [nearCell startAnimation];
    }
    
    
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
