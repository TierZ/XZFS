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
    UIButton * _nextBtn;//点击按钮（下一步/）
     UIButton * _submitBtn;//点击按钮（提交）
    NSDate * startDate;
    NSDate * endDate;
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
    float dateViewWidth =  SCREENWIDTH*320.0/375;
    float dateViewHeight = SCREENHEIGHT*450.0/667;
    
    _dateView = [[UIView alloc]initWithFrame:CGRectMake((self.width-dateViewWidth)/2, (self.height-dateViewHeight)/2, dateViewWidth, dateViewHeight)];
    _dateView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_dateView];
    
    NSDate * currentDate = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy.MM.dd HH:mm"];
    NSString * currentDateStr = [formatter stringFromDate:currentDate];
 
    _dateLabel = [self setupLabWithFont:11 textColor:[UIColor whiteColor] backgroundColor:XZFS_TEXTORANGECOLOR frame:CGRectMake(0, 0, _dateView.width, 20) text:[[currentDateStr componentsSeparatedByString:@" "] firstObject]];
    [_dateView addSubview:_dateLabel];
    
    UIButton * closeBtn = [self setupBtnWithFont:0 title:@"" textColor:[UIColor clearColor] backgroundColor:[UIColor redColor] frame:CGRectMake(10, 2, 16, 16) selector:@selector(closeDateView)];
    [_dateView addSubview:closeBtn];
    
    _titleLab = [self setupLabWithFont:11 textColor:XZFS_TEXTORANGECOLOR backgroundColor:[UIColor whiteColor] frame:CGRectMake(0, _dateLabel.bottom, _dateView.width, 20) text:@"开始时间"];
    [_dateView addSubview:_titleLab];
    
    _timeLabel = [self setupLabWithFont:30 textColor:[UIColor whiteColor] backgroundColor:XZFS_TEXTORANGECOLOR frame:CGRectMake(0, _titleLab.bottom, _dateView.width, 60) text: [[currentDateStr componentsSeparatedByString:@" "] lastObject]];
    _timeLabel.font = XZFS_S_BOLD_FONT(30);
    [_dateView addSubview:_timeLabel];
    
    _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, _timeLabel.bottom, _dateView.width, _dateView.height-_timeLabel.bottom-BottomBtnHeight)];
    [_dateView addSubview:_datePicker];
    _datePicker.backgroundColor = [UIColor whiteColor];
    _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    //[riQidatePicker setDate:nowDate animated:YES];
    //属性：datePicker.date当前选中的时间 类型 NSDate
    
    [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents: UIControlEventValueChanged];
    
    _nextBtn = [self setupBtnWithFont:14 title:@"下一步" textColor:XZFS_TEXTORANGECOLOR backgroundColor:[UIColor whiteColor] frame:CGRectMake(0, _dateView.height-BottomBtnHeight, _dateView.width, BottomBtnHeight) selector:@selector(nextAction:)];
    [_dateView addSubview:_nextBtn];
    
    _submitBtn = [self setupBtnWithFont:14 title:@"提交约见时间" textColor:XZFS_TEXTORANGECOLOR backgroundColor:[UIColor whiteColor] frame:CGRectMake(0, _dateView.height-BottomBtnHeight, _dateView.width, BottomBtnHeight) selector:@selector(submitAction:)];
    [_dateView addSubview:_submitBtn];
    _nextBtn.hidden = NO;
    _submitBtn.hidden = YES;

}

#pragma mark datePicker 方法
- (void)dateChange:(UIDatePicker *)sender{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    [formatter setWeekdaySymbols:@[@"礼拜天",@"礼拜一",@"礼拜二",@"礼拜三",@"礼拜四",@"礼拜五",@"礼拜六"]];
    
    NSDateFormatter *formatte2 = [[NSDateFormatter alloc]init];
    [formatte2 setDateFormat:@"HH:mm"];
    
    _dateLabel.text = [formatter stringFromDate:sender.date];
    _timeLabel.text = [formatte2 stringFromDate:sender.date];
    NSLog(@"点击了时间---%@",_datePicker.date);
}

#pragma mark 按钮点击
-(void)closeDateView{
    if (self) {
        self.hidden = YES;
        [self removeFromSuperview];
    }
}

-(void)nextAction:(UIButton*)sender{
    NSLog(@"提交 开始时间---%@",_datePicker.date);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy.MM.dd HH:mm"];
    startDate = _datePicker.date;
//    NSString * startDateStr = [formatter stringFromDate:_datePicker.date];
//    if (self.block) {
//        self.block(startDateStr,YES);
//    }
    _nextBtn.hidden = YES;
    _submitBtn.hidden = NO;
    _titleLab.text = @"结束时间";
}

-(void)submitAction:(UIButton*)sender{
    NSLog(@"提交 结束时间---%@",_datePicker.date);
    endDate = _datePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy.MM.dd HH:mm"];
    
    NSString * startDateStr = [formatter stringFromDate:_datePicker.date];
    int result = [self compareDate:startDate withDate:endDate];
    if (result==1) {
        if (self.block) {
            self.block(startDate,endDate);
        }
    }
}

-(void)selectDateWithBlock:(DateClickBlock)block{
    self.block = block;
}


#pragma mark private method
-(UILabel *)setupLabWithFont:(float)font textColor:(UIColor*)color backgroundColor:(UIColor*)backgroundColor frame:(CGRect)frame text:(NSString*)text{
    UILabel * lab = [UILabel labelWithFontSize:font textColor:color];
    lab.frame = frame;
    lab.text = text;
    lab.backgroundColor = backgroundColor;
    lab.textAlignment = NSTextAlignmentCenter;
    return lab;
}

-(UIButton*)setupBtnWithFont:(float)font title:(NSString*)title textColor:(UIColor*)color backgroundColor:(UIColor*)backgroundColor frame:(CGRect)frame selector:(SEL)selector{

    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.frame = frame;
    btn.backgroundColor = backgroundColor;
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = XZFS_S_FONT(font);
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIView * line = [UIView new];
    line.frame = CGRectMake(0, 0, btn.width, 0.5);
    line.backgroundColor = XZFS_TEXTLIGHTGRAYCOLOR;
    [btn addSubview:line];
    
    return btn;
}


-(int)compareDate:(NSDate*)date1 withDate:(NSDate*)date2{
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSComparisonResult result = [date1 compare:date2];
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending:{
            long date1L = [date1 timeIntervalSince1970];
             long date2L = [date2 timeIntervalSince1970];
            if ((date2L-date1L)/3600<8) {
                return 1;
            }else{
                [ToastManager showToastOnView:self position:CSToastPositionCenter flag:NO message:@"结束时间与开始时间的间隔应在8小时内"];
                return -1;
            }
        }break;
            //date02比date01小 或者冬雨
        case NSOrderedDescending:
         case NSOrderedSame:{
            [ToastManager showToastOnView:self position:CSToastPositionCenter flag:NO message:@"结束时间应大于开始时间，且应在8小时内"];
            return -1;
        }break;
        default: {
            [ToastManager showToastOnView:self position:CSToastPositionCenter flag:NO message:@"erorr dates"];
            return 0;
        }break;
    }
    return ci;

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
