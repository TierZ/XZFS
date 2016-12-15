//
//  XZFeedBackVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/23.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZFeedBackVC.h"
#import "XZUserCenterService.h"

@interface XZFeedBackVC ()

@end

@implementation XZFeedBackVC{
    UITextField * emailTf;
    UITextView * feedBackTv;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupEmail];
    [self setupContent];
    [self setupSubmitFeedBack];
    [self setupTips];

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [emailTf resignFirstResponder];
        [feedBackTv resignFirstResponder];
    }];
    [self.mainView addGestureRecognizer:tap];
}

-(void)setupEmail{
    UILabel * emailLab = [UILabel new];
    emailLab.text = @"您的邮箱";
    emailLab.textColor = XZFS_TEXTBLACKCOLOR;
    emailLab.font = XZFS_S_FONT(13);
    emailLab.frame = CGRectMake(20, 12, 100, 13);
    [self.mainView addSubview:emailLab];
    
    emailTf = [UITextField new];
    emailTf.backgroundColor = [UIColor whiteColor];
    emailTf.frame = CGRectMake(emailLab.left, emailLab.bottom+13, SCREENWIDTH-40, 33);
    emailTf.placeholder = @" 请输入邮箱";
    emailTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailTf.font = XZFS_S_FONT(15);
    emailTf.textColor = XZFS_TEXTBLACKCOLOR;
    emailTf.layer.masksToBounds = YES;
    emailTf.layer.cornerRadius = 5;
    emailTf.keyboardType = UIKeyboardTypeEmailAddress;
    [self.mainView addSubview:emailTf];
}

-(void)setupContent{
    UILabel * contentLab = [UILabel new];
    contentLab.text = @"请输入您的意见和建议，我们将为您提供更好的服务";
    contentLab.textColor = XZFS_TEXTBLACKCOLOR;
    contentLab.font = XZFS_S_FONT(13);
    contentLab.frame = CGRectMake(20, emailTf.bottom+12, SCREENWIDTH-40, 13);
    [self.mainView addSubview:contentLab];
    
    feedBackTv = [UITextView new];
    feedBackTv.backgroundColor = [UIColor whiteColor];
    feedBackTv.frame = CGRectMake(contentLab.left, contentLab.bottom+13, SCREENWIDTH-40, 100);
    feedBackTv.font = XZFS_S_FONT(13);
    feedBackTv.textColor = XZFS_TEXTBLACKCOLOR;
    feedBackTv.layer.masksToBounds = YES;
    feedBackTv.layer.cornerRadius = 5;
    [self.mainView addSubview:feedBackTv];
    
}

-(void)setupSubmitFeedBack{
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(feedBackTv.left, feedBackTv.bottom+45, feedBackTv.width, 45);
    submitBtn.backgroundColor = XZFS_TEXTORANGECOLOR;
    [submitBtn setTitle:@"提交反馈" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = XZFS_S_FONT(18);
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5;
    [submitBtn addTarget:self action:@selector(submitFeedBack) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:submitBtn];
}

-(void)setupTips{
    self.mainView.userInteractionEnabled = YES;
      NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:@"有任何服务问题请致电客服电话\n"];
     NSMutableAttributedString * phoneAtt = [[NSMutableAttributedString alloc]initWithString:@"010-68523615\n"];
    YYTextHighlight *highlight = [YYTextHighlight new];
    [highlight setColor:[UIColor whiteColor]];
    highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        NSLog(@"打电话");
    };
    [phoneAtt setTextHighlight:highlight range:phoneAtt.rangeOfAll];

    
    [att appendAttributedString:phoneAtt];
    
    NSMutableAttributedString * timeAtt = [[NSMutableAttributedString alloc]initWithString:@"工作日9:00-17:00"];
     [att appendAttributedString:timeAtt];

    NSRange range = NSMakeRange(0, att.length);
    [att addAttribute:NSFontAttributeName value:XZFS_S_FONT(11) range:range];
    [att addAttribute:NSForegroundColorAttributeName value:XZFS_TEXTLIGHTGRAYCOLOR range:range];

    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = 5;
    [att addAttribute:NSParagraphStyleAttributeName value:style range:range];
   
    YYLabel * tipLab = [YYLabel new];
    tipLab.frame = CGRectMake(0, feedBackTv.bottom+150, SCREENWIDTH, 60);
    tipLab.textColor = XZFS_TEXTLIGHTGRAYCOLOR;
    tipLab.font = XZFS_S_FONT(11);
    tipLab.numberOfLines = 0;
    tipLab.attributedText = att;
    tipLab.textAlignment = NSTextAlignmentCenter;
    [self.mainView addSubview:tipLab];
//    tipLab.highlight.tapAction
//    tipLab.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//        NSLog(@"点击电话2");
//
//    };

   

}

#pragma mark action
-(void)submitFeedBack{
    if (emailTf.text.length>0&&feedBackTv.text.length>0) {
        [self feedbackService];
    }else{
        [ToastManager showToastOnView:self.mainView position:CSToastPositionCenter flag:NO message:@"内容不能为空"];
    }
    NSLog(@"提交反馈");
}

#pragma mark 网络
-(void)feedbackService{
    NSDictionary * userInfo = GETUserdefault(@"userInfo");
    NSString * userCode = [userInfo objectForKey:@"bizCode"];

    XZUserCenterService * feedbackService = [[XZUserCenterService alloc]initWithServiceTag:XZFeedBackTag];
    feedbackService.delegate = self;
   [ feedbackService feedbackWithUid:userCode content:feedBackTv.text  view:self.mainView];
}

-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    NSLog(@"feedback = %@",succeedHandle);
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
