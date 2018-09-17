//
//  ViewController.m
//  TimeDown
//
//  Created by zhen mz on 2018/9/17.
//  Copyright © 2018年 zhen mz. All rights reserved.
//

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

#import "ViewController.h"
#import "MZCountDownManager.h"
#import "TableViewCell.h"
#import "TwoViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataArr;

@property (nonatomic, strong) MZCountDownManager *manger;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"页面one";
    
    _manger = [[MZCountDownManager alloc] initWithManagerNotification:nil];
    [_manger start];
    
    [self creatData];
    [self.view addSubview:self.tableView];
    
    
}




- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableViewCell"];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    cell.infoDic = @{@"left":@(indexPath.row),@"right":self.dataArr[indexPath.row]};
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TwoViewController *vc = [TwoViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}



/**
 模拟数据
 */
- (void)creatData {
    _dataArr = [NSMutableArray array];
    for (int i = 0; i<30; i++) {
        int a = (arc4random() % 501) + 100;
        [_dataArr addObject:@(a)];
    }
}

- (void)dealloc {
    [_manger invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
