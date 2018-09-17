//
//  TableViewCell.m
//  TimeDown
//
//  Created by zhen mz on 2018/9/17.
//  Copyright © 2018年 zhen mz. All rights reserved.
//

#import "TableViewCell.h"
#import "MZCountDownManager.h"

@interface TableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *leftLable;
@property (weak, nonatomic) IBOutlet UILabel *rigthLable;

@end
@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification:) name:MZCountDownDefaultNotification object:nil];
    }
    return self;
}

- (void)countDownNotification:(NSNotification*)noti {
    if ([_infoDic[@"left"] integerValue]%3 ==0 ) {  // 设置某些行不显示
        return;
    }
    
    NSInteger countDown = [_infoDic[@"right"] integerValue] - [noti.object integerValue];
    
    if (countDown <= 0 ) {
        _rigthLable.text = @"时间到";
        return;
    }
    
     NSString *time = [NSString stringWithFormat:@"%02zd:%02zd:%02zd", countDown/3600,(countDown/60)%60,countDown%60];
    _rigthLable.text = time;
    
    
}


- (void)setInfoDic:(NSDictionary *)infoDic {
    _infoDic = infoDic;
    
    _leftLable.text = [NSString stringWithFormat:@"第%@行",infoDic[@"left"]];
    
    if ([_infoDic[@"left"] integerValue]%3 ==0 ) {  // 某些行不显示
        _rigthLable.text = @"不显示";
       
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
