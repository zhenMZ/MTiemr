//
//  TwoViewController.m
//  TimeDown
//
//  Created by zhen mz on 2018/9/17.
//  Copyright © 2018年 zhen mz. All rights reserved.
//

#import "TwoViewController.h"
#import "MZCountDownManager.h"
#import "TwoTableViewCell.h"

@interface TwoViewController ()<UITableViewDelegate,UITableViewDataSource>
/**
 xib
 */
@property (weak, nonatomic) IBOutlet UILabel *lable1;
@property (weak, nonatomic) IBOutlet UILabel *lable2;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 数据源
 */
@property (nonatomic, retain) NSMutableArray *dataArr;
@property (nonatomic, strong) MZCountDownManager *manger;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"页面two";
    
    _manger = [[MZCountDownManager alloc] initWithManagerNotification:@"TwoViewControllerNotification"];
    [_manger start];
    
    [self creatData];
    
    [self setUI];
}



- (void)setUI {
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView registerNib:[UINib nibWithNibName:@"TwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"TwoTableViewCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification:) name:@"TwoViewControllerNotification" object:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwoTableViewCell" forIndexPath:indexPath];
    cell.infoDic = @{@"left":@(indexPath.row),@"right":self.dataArr[indexPath.row]};
    return cell;
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





/**
 定时器倒计时
 */
- (void)countDownNotification:(NSNotification*)noti {
    
    NSInteger countDown1 = [self.dataArr[1] integerValue] - [noti.object integerValue];
    [self setLableText:countDown1 withLable:_lable1];
   
    NSInteger countDown2 = [self.dataArr[2] integerValue] - [noti.object integerValue];
    [self setLableText:countDown2 withLable:_lable2];
    
}
- (void)setLableText:(NSInteger)countDwon withLable:(UILabel *)lable {
    if (countDwon <= 0 ) {
        lable.text = @"时间到";
        return;
    }
    NSString *time = [NSString stringWithFormat:@"%02zd:%02zd:%02zd", countDwon/3600,(countDwon/60)%60,countDwon%60];
    lable.text = time;
}

- (void)dealloc {
    [_manger invalidate];
    NSLog(@"释放定时器");
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
