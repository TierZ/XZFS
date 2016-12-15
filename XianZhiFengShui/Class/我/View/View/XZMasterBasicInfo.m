//
//  XZMasterBasicInfo.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/9.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterBasicInfo.h"
#import "ValidateTextField.h"
#import "ValidateRule.h"

@interface XZMasterBasicInfo ()
@property (nonatomic,strong)NSArray * items;
@property (nonatomic,strong)ValidateTextField * realName;
@property (nonatomic,strong)ValidateTextField * phoneNo;
@property (nonatomic,strong)ValidateTextField * email;
@property (nonatomic,strong)ValidateTextField * city;
@property (nonatomic,strong)UITextField * location;//任职机构
@property (nonatomic,strong)UITextField * jobTitle;//头衔
@end
@implementation XZMasterBasicInfo

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBasicInfo];
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)setupBasicInfo{
    for (int i = 0; i<self.items.count; i++) {
        UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, i*44, 60, 43)];
        titleLab.text = self.items[i];
        titleLab.font = XZFS_S_FONT(14);
        titleLab.textColor = XZFS_TEXTBLACKCOLOR;
        [self addSubview:titleLab];
      
        if (i<self.items.count-1) {
            UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, 44+i*44, self.width-40, 1)];
            line.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
            [self addSubview:line];
        }
        
        if (i<(_items.count-2)) {
            UIImageView * starIv = [[UIImageView alloc]initWithFrame:CGRectMake(titleLab.right, 19+i*44, 6, 6)];
            starIv.image = XZFS_IMAGE_NAMED(@"xingxing_full");
            [self addSubview:starIv];
        }
    }
    self.realName.frame = CGRectMake(105, 0, self.width-105-20, 43);
    self.phoneNo.frame = CGRectMake(105, self.realName.bottom+1, self.width-105-20, 43);
    self.email.frame = CGRectMake(105, self.phoneNo.bottom+1, self.width-105-20, 43);
    self.city.frame = CGRectMake(105, self.email.bottom+1, self.width-105-20, 43);
    self.location.frame = CGRectMake(105, self.city.bottom+1, self.width-105-20, 43);
    self.jobTitle.frame = CGRectMake(105, self.location.bottom+1, self.width-105-20, 43);
    
    [self sd_addSubviews:@[ self.realName,self.phoneNo,self.email,self.city,self.location,self.jobTitle ]];
}

-(BOOL)validateTfInfo{
    ValidateRule * rule = [[ValidateRule alloc]init];
    BOOL isvalidate = [rule validateResultWithView:self];
    if (isvalidate) {
        self.itemsDic  = [NSMutableDictionary dictionaryWithDictionary:@{@"name":_realName.text,@"phone":_phoneNo.text,@"email":_email.text,@"city":_city.text,@"location":_location.text,@"jobTitle":_jobTitle.text}];
    }
    return isvalidate;
}

#pragma mark getter
-(NSArray *)items{
    if (!_items) {
        _items = @[ @"真实姓名",@"手机",@"邮箱",@"常驻城市",@"任职机构",@"职位头衔" ];
    }
    return _items;
}

-(ValidateTextField *)realName{
    if (!_realName) {
        _realName = [[ValidateTextField alloc]init];
        _realName.errorMsg = @"姓名格式不正确";
        _realName.emptyMsg = @"请输入姓名";
        _realName.valldataRuleStr = XZFS_RealNameRule;
//        [_realName becomeFirstResponder];
        _realName.clearButtonMode = UITextFieldViewModeWhileEditing;
        _realName.placeholder = @"请输入姓名";
        _realName.textColor = XZFS_HEX_RGB(@"#333333");
        _realName.font = XZFS_S_FONT(14);
    }
    return _realName;
}

-(ValidateTextField *)phoneNo{
    if (!_phoneNo) {
        _phoneNo = [[ValidateTextField alloc]init];
        _phoneNo.errorMsg = @"手机格式不正确";
        _phoneNo.emptyMsg = @"请输入手机号码";
        _phoneNo.valldataRuleStr = XZFS_PhoneRule;
        _phoneNo.keyboardType = UIKeyboardTypeDecimalPad;
        _phoneNo.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneNo.placeholder = @"请输入手机号码";
        _phoneNo.textColor = XZFS_HEX_RGB(@"#333333");
        _phoneNo.font = XZFS_S_FONT(14);
    }
    return _phoneNo;
}

-(ValidateTextField *)email{
    if (!_email) {
        _email = [[ValidateTextField alloc]init];
        _email.errorMsg = @"邮箱格式不正确";
        _email.emptyMsg = @"请输入邮箱";
        _email.valldataRuleStr = XZFS_EmailRule;
        _email.keyboardType = UIKeyboardTypeEmailAddress;
        _email.clearButtonMode = UITextFieldViewModeWhileEditing;
        _email.placeholder = @"请输入邮箱";
        _email.textColor = XZFS_HEX_RGB(@"#333333");
        _email.font = XZFS_S_FONT(14);
    }
    return _email;
}

-(ValidateTextField *)city{
    if (!_city) {
        _city = [[ValidateTextField alloc]init];
        _city.errorMsg = @"城市格式不正确";
        _city.emptyMsg = @"请输入城市名";
        _city.valldataRuleStr = XZFS_RealNameRule;
        _city.keyboardType = UIKeyboardTypeDefault;
        _city.clearButtonMode = UITextFieldViewModeWhileEditing;
        _city.placeholder = @"如北京、上海";
        _city.textColor = XZFS_HEX_RGB(@"#333333");
        _city.font = XZFS_S_FONT(14);
    }
    return _city;
}

-(UITextField *)location{
    if (!_location) {
        _location = [[UITextField alloc]init];
        _location.keyboardType = UIKeyboardTypeDefault;
        _location.clearButtonMode = UITextFieldViewModeWhileEditing;
        _location.placeholder = @"如:中国风水研究院、自由职业者";
        _location.textColor = XZFS_HEX_RGB(@"#333333");
        _location.font = XZFS_S_FONT(14);
    }
    return _location;
}

-(UITextField *)jobTitle{
    if (!_jobTitle) {
        _jobTitle = [[UITextField alloc]init];
        _jobTitle.keyboardType = UIKeyboardTypeDefault;
        _jobTitle.clearButtonMode = UITextFieldViewModeWhileEditing;
        _jobTitle.placeholder = @"如:商务科长";
        _jobTitle.textColor = XZFS_HEX_RGB(@"#333333");
        _jobTitle.font = XZFS_S_FONT(14);
    }
    return _jobTitle;
}

-(NSMutableDictionary *)itemsDic{
    if (!_itemsDic) {
        _itemsDic = [NSMutableDictionary dictionary];
    }
    return _itemsDic;
}

@end
