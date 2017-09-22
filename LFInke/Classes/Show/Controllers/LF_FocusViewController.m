//
//  LF_FocusViewController.m
//  LFInke
//
//  Created by slimdy on 2017/5/8.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_FocusViewController.h"
#import "LF_LiveCell.h"
#import "LF_HotLiveModel.h"
#import "LF_PlayerController.h"
@interface LF_FocusViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)LF_HotLiveModel *live;
@end
static NSString *Identifier = @"FocusCell";
@implementation LF_FocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    LF_HotLiveModel *live = [[LF_HotLiveModel alloc]init];
    live.creator = [[LF_CreatorModel alloc]init];
    live.creator.portrait = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495435691&di=1332c9206268b8f1a48293f0e45102f5&imgtype=jpg&er=1&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201507%2F17%2F20150717000601_hPSkF.jpeg";
    live.onlineUsers = 9999;
    live.creator.nick = @"吴彦祖";
    live.city = @"兰州市";
    live.streamAddr = @"http://live.mudu.tv/watch/ghfxba.flv";//@"hhttp://mudu.tv/?a=index&c=show&id=49997&type=pc";
    self.live = live;
    [self.tableView registerNib:[UINib nibWithNibName:@"LF_LiveCell" bundle:nil] forCellReuseIdentifier:Identifier];
    NSLog(@"%@",self.live.streamAddr);
    
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

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LF_LiveCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    
    cell.live =self.live;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_WIDTH+70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LF_PlayerController *playerVC = [[LF_PlayerController alloc]init];
    playerVC.live = self.live;
    [self.navigationController pushViewController:playerVC animated:YES];
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
