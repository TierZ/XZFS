//
//  XZDataPickerView.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/2/8.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZDataPickerView.h"

#define BottomBtnHeight 24
@implementation XZDataPickerView{
    UIView * _dateView;
    UILabel * _dateLabel;//日期
    UILabel * _timeLabel;//时间
    UILabel * _titleLab;//标题（开始时间/结束时间）
    UIDatePicker * _datePicker;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = XZFS_HEX_RGBA(@"#000000",0.5);
        [self setupDataView];
    }
    return self;
}
-(void)setupDataView{
    float dateViewWidth =  SCREENWIDTH*300.0/375;
    float dateViewHeight = SCREENHEIGHT*340.0/667;
    
    _dateView = [[UIView alloc]initWithFrame:CGRectMake((self.width-dateViewWidth)/2, (self.height-dateViewHeight)/2, dateViewWidth, dateViewHeight)];
    _dateView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_dateView];
    
    _dateLabel = [UILabel labelWithFontSize:11 textColor:[UIColor whiteColor]];
    _dateLabel.frame = CGRectMake(0, 0, _dateView.width, 20);
    _dateLabel.backgroundColor = XZFS_TEXTORANGECOLOR;
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    _dateLabel.text = @"--";
    [_dateView addSubview:_dateLabel];
    
    UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(10, 2, 16, 16);
    closeBtn.backgroundColor = [UIColor redColor];
    [closeBtn addTarget:self action:@selector(closeDateView) forControlEvents:UIControlEventTouchUpInside];
    [_dateView addSubview:closeBtn];
    
    _titleLab = [UILabel labelWithFontSize:11 textColor:XZFS_TEXTORANGECOLOR];
    _titleLab.frame = CGRectMake(0, _dateLabel.bottom, _dateView.width, 20);
    _titleLab.backgroundColor = [UIColor whiteColor];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.text = @"开始时间";
    [_dateView addSubview:_titleLab];
    
    _timeLabel = [UILabel labelWithFontSize:30 textColor:[UIColor whiteColor]];
    _timeLabel.frame = CGRectMake(0, _dateLabel.bottom, _dateView.width, 60);
    _timeLabel.font = XZFS_S_BOLD_FONT(30);
    _timeLabel.backgroundColor = XZFS_TEXTORANGECOLOR;
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.text = @"--";
    [_dateView addSubview:_timeLabel];
    
    _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, _timeLabel.bottom, _dateView.width, _dateView.height-_timeLabel.bottom-BottomBtnHeight)];
    [_dateView addSubview:_datePicker];
    _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    //[riQidatePicker setDate:nowDate animated:YES];
    //属性：datePicker.date当前选中的时间 类型 NSDate
    
    [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents: UIControlEventValueChanged];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
//    pinStr = [formatter stringFromDate:datePicker.date];
}

- (void)dateChange:(UIDatePicker *)sender{
    NSLog(@"点击了时间---%@",_datePicker.date);
}

-(void)closeDateView{
    if (self) {
        self.hidden = YES;
        [self removeFromSuperview];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
