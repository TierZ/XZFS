//
//  XZLectureDetailVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/1.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZLectureDetailVC.h"

CGFloat maxContentLabelHeight = 150; // 讲座介绍 高度
CGFloat showAllBtnHeight = 12; // 讲座介绍 高度
@interface XZLectureDetailVC ()
@property (nonatomic,strong)UIScrollView * mainScroll;
@property (nonatomic,strong)UIView * baseInfo;//基本信息
@property (nonatomic,strong)UIView * lectureInfo;//讲座详情
@property (nonatomic,strong)UILabel * lectureTitle;//讲座标题
@property (nonatomic,strong)UIView * smallInfo;//时间，地点
@property (nonatomic,strong)UILabel * lectureDetail;//讲座介绍
@property (nonatomic,strong)UIButton * showAllBtn;//显示全部
@property (nonatomic,strong)UIView * masterInfo;//大师详情
@property (nonatomic,strong)UILabel * masterTitle;//关于大师
@property (nonatomic,strong)UILabel * masterDetail;//大师介绍
@property (nonatomic,strong)UIButton* collectLecture;//收藏
@property (nonatomic,strong)UIButton * enrollBtn;//报名

@property (nonatomic,strong)UIView * firstLine;//第一条线

@property (nonatomic,strong)UIView * secondLine;//第二条线
@end

@implementation XZLectureDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self setupMainScroll];
    [self setupBaseView];
    [self setupLectureInfo];
    [self setupMasterInfo];
    [self setupBottomBtn];
    
//    [self layoutView];
    
    [self updateData];
    // Do any additional setup after loading the view.
}

-(void)setupNavi{
    self.titelLab.text = @"讲座详情";
}

-(void)setupMainScroll{
    _mainScroll = [[UIScrollView alloc]init];
    _mainScroll.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:_mainScroll];
    
   
    
}
-(void)setupBaseView{
    _baseInfo = [[UIView alloc]init];
    _baseInfo.backgroundColor = RandomColor(1);
    [_mainScroll addSubview:_baseInfo];

    _firstLine = [[UIView alloc]init];
    _firstLine.backgroundColor = XZFS_HEX_RGB(@"#F1EEEF");
    [_mainScroll addSubview:_firstLine];
}

-(void)setupLectureInfo{

    
    _lectureTitle = [[UILabel alloc]init];
    _lectureTitle.backgroundColor = [UIColor clearColor];
    _lectureTitle.textColor =  XZFS_TEXTBLACKCOLOR;
    _lectureTitle.textAlignment =NSTextAlignmentCenter;
    _lectureTitle.font = XZFS_S_FONT(14);
    
    _smallInfo = [[UIView alloc]init];
    _smallInfo.backgroundColor = RandomColor(1);
    
    _lectureDetail = [[UILabel alloc]init];
    _lectureDetail.backgroundColor = [UIColor greenColor];
    _lectureDetail.textColor =  XZFS_TEXTLIGHTGRAYCOLOR;
    _lectureDetail.textAlignment =NSTextAlignmentLeft;
    _lectureDetail.font = XZFS_S_FONT(12);
    _lectureDetail.numberOfLines  =4;
    
    
     _showAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_showAllBtn setTitle:@"显示全部" forState:UIControlStateNormal];
    [_showAllBtn setTitleColor:XZFS_HEX_RGB(@"#C2A865") forState:UIControlStateNormal];
    [_showAllBtn addTarget:self action:@selector(showAll:) forControlEvents:UIControlEventTouchUpInside];
    _showAllBtn.titleLabel.font = XZFS_S_FONT(12);
    
//    [self.mainScroll addSubview:_lectureInfo];
    [self.mainScroll sd_addSubviews:@[ _lectureTitle,_smallInfo,_lectureDetail,_showAllBtn ]];
 
}

-(void)setupMasterInfo{
    
    _secondLine = [[UIView alloc]init];
    _secondLine.backgroundColor = XZFS_HEX_RGB(@"#F1EEEF");
 
    
    _masterInfo = [[UIView alloc]init];
    _masterInfo.backgroundColor = [UIColor whiteColor];
    
    _masterTitle = [[UILabel alloc]init];
    _masterTitle.backgroundColor = [UIColor clearColor];
    _masterTitle.textColor =  XZFS_TEXTBLACKCOLOR;
    _masterTitle.textAlignment =NSTextAlignmentCenter;
    _masterTitle.font = XZFS_S_FONT(14);
    _masterTitle.text = @"关于大师";
    
    _masterDetail = [[UILabel alloc]init];
    _masterDetail.backgroundColor = [UIColor clearColor];
    _masterDetail.textColor =  XZFS_TEXTLIGHTGRAYCOLOR;
    _masterDetail.textAlignment =NSTextAlignmentLeft;
    _masterDetail.font = XZFS_S_FONT(12);
    _masterDetail.numberOfLines  =0;
    [self.mainScroll sd_addSubviews:@[ _secondLine, _masterTitle,_masterDetail ]];
    
  }

-(void)setupBottomBtn{
    _collectLecture = [UIButton buttonWithType:UIButtonTypeCustom];
    _collectLecture.backgroundColor = XZFS_TEXTORANGECOLOR;
    [_collectLecture setTitle:@"收藏讲座" forState:UIControlStateNormal];
    [_collectLecture setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _collectLecture.titleLabel.font = XZFS_S_FONT(19);
    
    _enrollBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _enrollBtn.backgroundColor = XZFS_HEX_RGB(@"#FD0F00");
    [_enrollBtn setTitle:@"报名" forState:UIControlStateNormal];
    [_enrollBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _enrollBtn.titleLabel.font = XZFS_S_FONT(19);
    
    [self.mainView sd_addSubviews:@[ _collectLecture,_enrollBtn]];

    _collectLecture.frame = CGRectMake(0, SCREENHEIGHT-45-XZFS_STATUS_BAR_H, SCREENWIDTH*0.6, 45);
    _enrollBtn.frame = CGRectMake(_collectLecture.right_sd, SCREENHEIGHT-45-XZFS_STATUS_BAR_H, SCREENWIDTH*0.4, 45);
  }

-(void)layoutView{
    _mainScroll.sd_layout
    .leftSpaceToView(self.mainView,0)
    .rightSpaceToView(self.mainView,0)
    .topSpaceToView(self.mainView,0)
    .bottomSpaceToView(self.mainView,45);
    
    _baseInfo.sd_layout
    .leftSpaceToView(_mainScroll,0)
    .rightSpaceToView(_mainScroll,0)
    .topSpaceToView(_mainScroll,0)
    .heightIs(165);
    
    _firstLine.sd_layout
    .leftEqualToView(self.mainScroll)
    .rightEqualToView(self.mainScroll)
    .widthIs(SCREENWIDTH)
    .heightIs(7)
    .topSpaceToView(_baseInfo,0);

    // 讲座详情
    
    _lectureTitle.sd_layout
    .leftEqualToView(self.mainScroll)
    .rightEqualToView(self.mainScroll)
    .topSpaceToView(_firstLine,14)
    .heightIs(14);
    
    _smallInfo.sd_layout
    .leftEqualToView(self.mainScroll)
    .rightEqualToView(self.mainScroll)
    .topSpaceToView(_lectureTitle,14)
    .heightIs(14);
//
    _lectureDetail.sd_layout
    .leftSpaceToView(self.mainScroll,20)
    .rightSpaceToView(self.mainScroll,20)
    .topSpaceToView(_smallInfo,14)
    .autoHeightRatio(0)
    .maxHeightIs(maxContentLabelHeight);
//
    _showAllBtn.sd_layout
    .leftEqualToView(self.mainScroll)
    .rightEqualToView(self.mainScroll)
    .topSpaceToView(_lectureDetail,20)
    .heightIs(showAllBtnHeight);
    
    
    //关于大师

    _secondLine.sd_layout
    .leftEqualToView(self.mainScroll)
    .rightEqualToView(self.mainScroll)
    .widthIs(SCREENWIDTH)
    .heightIs(7)
    .topSpaceToView(_showAllBtn,16);
    
    _masterTitle.sd_layout
    .leftSpaceToView(_mainScroll,20)
    .rightSpaceToView(_mainScroll,20)
    .topSpaceToView(_secondLine,14)
    .heightIs(14);
    
    _masterDetail.sd_layout
    .leftSpaceToView(_mainScroll,20)
    .rightSpaceToView(_mainScroll,20)
    .topSpaceToView(_masterTitle,14)
    .autoHeightRatio(0);
        
    [_mainScroll setupAutoContentSizeWithBottomView:_masterDetail bottomMargin:20];
    




}

#pragma mark update
-(void)updateData{
    self.lectureTitle.text = @"聊聊买房的那些事";
    self.lectureDetail.text = @"MVC（Model-View-Controller）是最老牌的的思想，老牌到4人帮的书里把它归成了一种模式，其中Model就是作为数据管理者，View作为数据展示者，Controller作为数据加工者，Model和View又都是由Controller来根据业务需求调配，所以Controller还负担了一个数据流调配的功能。正在我写这篇文章的时候，我看到InfoQ发了这篇文章，里面提到了一个移动开发中的痛点是：对MVC架构划分的理解。我当时没能够去参加这个座谈会，也没办法发表个人意见，所以就只能在这里写写了。    在iOS开发领域，我们应当如何进行MVC的划分？    这里面其实有两个问题：    为什么我们会纠结于iOS开发领域中MVC的划分问题？在iOS开发领域中，怎样才算是划分的正确姿势？为什么我们会纠结于iOS开发领域中MVC的划分问题？关于这个，每个人纠结的点可能不太一样，我也不知道当时座谈会上大家的观点。但请允许我猜一下：是不是因为UIViewController中自带了一个View，且控制了View的整个生命周期（viewDidLoad,viewWillAppear...），而在常识中我们都知道Controller不应该和View有如此紧密的联系，所以才导致大家对划分产生困惑？，下面我会针对这个猜测来给出我的意见。";
    self.masterDetail.text = @"MVVM去年在业界讨论得非常多，无论国内还是国外都讨论得非常热烈，尤其是在ReactiveCocoa这个库成熟之后，ViewModel和View的信号机制在iOS下终于有了一个相对优雅的实现。MVVM本质上也是从MVC中派生出来的思想，MVVM着重想要解决的问题是尽可能地减少Controller的任务。不管MVVM也好，MVCS也好，他们的共识都是Controller会随着软件的成长，变很大很难维护很难测试。只不过两种架构思路的前提不同，MVCS是认为Controller做了一部分Model的事情，要把它拆出来变成Store，MVVM是认为Controller做了太多数据加工的事情，所以MVVM把数据加工的任务从Controller中解放了出来，使得Controller只需要专注于数据调配的工作，ViewModel则去负责数据加工并通过通知机制让View响应ViewModel的改变。MVVM是基于胖Model的架构思路建立的，然后在胖Model中拆出两部分：Model和ViewModel。关于这个观点我要做一个额外解释：胖Model做的事情是先为Controller减负，然后由于Model变胖，再在此基础上拆出ViewModel，跟业界普遍认知的MVVM本质上是为Controller减负这个说法并不矛盾，因为胖Model做的事情也是为Controller减负。另外，我前面说MVVM把数据加工的任务从Controller中解放出来，跟MVVM拆分的是胖Model也不矛盾。要做到解放Controller，首先你得有个胖Model，然后再把这个胖Model拆成Model和ViewModel。";
    [self textlengthWithText:self.lectureDetail.text];
    
    
    [self layoutView];
}

#pragma mark private
-(void)textlengthWithText:(NSString * )text{
    CGFloat contentW = SCREENWIDTH - 40;

        CGRect textRect = [text boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil];
        if (textRect.size.height > maxContentLabelHeight) {
            _showAllBtn.hidden = NO;
            showAllBtnHeight = 12;
        } else {
             _showAllBtn.hidden = YES;
            showAllBtnHeight = 0;
        }

}

#pragma mark action
-(void)showAll:(UIButton*)sender{
    sender.selected = !sender.selected;
    maxContentLabelHeight = sender.selected?1000:100;
//    [_lectureInfo setupAutoHeightWithBottomView:_showAllBtn bottomMargin:showAllBtnHeight];
    
//    [_mainScroll layoutSubviews];
    _lectureDetail.sd_layout.maxHeightIs(maxContentLabelHeight);
    [_lectureDetail updateLayout];
    [_mainScroll updateLayout];
//    [self layoutView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
