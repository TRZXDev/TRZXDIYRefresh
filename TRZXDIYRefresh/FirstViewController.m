//
//  FirstViewController.m
//  TRZXDIYRefresh
//
//  Created by N年後 on 2017/2/16.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "FirstViewController.h"
#import "TRZXDIYRefresh.h"
@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


    [self TRZXDIYRefresh];

}


#pragma mark UITableView + 下拉刷新 隐藏状态和时间
- (void)TRZXDIYRefresh
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
     self.tableView.mj_header = [TRZXGifHeader headerWithRefreshingBlock:^{
        // 刷新数据

         [self.tableView.mj_footer resetNoMoreData];

        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0/*延迟执行时间*/ * NSEC_PER_SEC));

        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            // 结束刷新状态
            [ self.tableView.mj_header endRefreshing];
            
        });

    }];


    // 马上进入刷新状态
//    [header beginRefreshing];











    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadLastData方法）
    self.tableView.mj_footer = [TRZXGifFooter footerWithRefreshingBlock:^{

        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0/*延迟执行时间*/ * NSEC_PER_SEC));

        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            // 结束刷新状态
            [self.tableView.mj_footer endRefreshing];

            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        });


    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld -",indexPath.row];

    return cell;
}


@end
