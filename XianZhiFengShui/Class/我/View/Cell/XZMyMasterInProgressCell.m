//
//  XZMyMasterInProgressCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/16.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMyMasterInProgressCell.h"
@interface XZMyMasterInProgressCell ()

@property (nonatomic,strong)UIButton * sendMsgBtn;//私信
@property (nonatomic,strong)UIButton * cancelBtn;//取消
@property (nonatomic,strong)UIButton * modifyBtn;//修改
@end
@implementation XZMyMasterInProgressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubCell];
    }
    return self;
}

-(void)setupSubCell{
    [self.contentView sd_addSubviews:@[ self.sendMsgBtn,self.cancelBtn,self.modifyBtn ]];
    

    self.service.sd_layout
    .leftEqualToView(self.name)
    .topSpaceToView(self.name,18)
    .widthIs(SCREENWIDTH-90-93-15-20)
    .autoHeightRatio(0);
    
    self.price.sd_layout
    .leftSpaceToView(self.service,10)
    .topSpaceToView(self.name,16)
    .heightIs(11);
    [self.price setSingleLineAutoResizeWithMaxWidth:90];
    
    float rightWidth = SCREENWIDTH-93-20;
    float btnWidth = 50;
    float btnHeight = 17;
    
    float space = (rightWidth-btnWidth*3)/4;
    
    _sendMsgBtn.sd_layout
    .leftSpaceToView(self.photo,space)
    .topSpaceToView(self.service,16)
    .widthIs(btnWidth)
    .heightIs(btnHeight);
    
    _cancelBtn.sd_layout
    .leftSpaceToView(_sendMsgBtn,space)
    .topEqualToView(_sendMsgBtn)
    .widthIs(btnWidth)
    .heightIs(btnHeight);
    
    _modifyBtn.sd_layout
    .leftSpaceToView(_cancelBtn,space)
    .topEqualToView(_sendMsgBtn)
    .widthIs(btnWidth)
    .heightIs(btnHeight);
    
    
     [self.sendMsgBtn.layer addSublayer: [Tool drawCornerWithRect:self.sendMsgBtn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5) borderWidth:0.5 strokeColor:XZFS_TEXTORANGECOLOR fillColor:[UIColor clearColor]]];
    
    [self.cancelBtn.layer addSublayer: [Tool drawCornerWithRect:self.cancelBtn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5) borderWidth:0.5 strokeColor:XZFS_TEXTORANGECOLOR fillColor:[UIColor clearColor]]];
   
    [self.modifyBtn.layer addSublayer: [Tool drawCornerWithRect:self.modifyBtn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5) borderWidth:0.5 strokeColor:XZFS_TEXTORANGECOLOR fillColor:[UIColor clearColor]]];

   

}

-(void)setModel:(XZTheMasterModel *)model{
    _model = model;
    [self.photo setImageWithURL:[NSURL URLWithString:model.icon] options:YYWebImageOptionProgressive  ];
    self.name.text = model.masterName;
    self.levelLab.text = model.level;
    self.timeLab.text = model.startTime;
    self.service.text = model.service;
    self.price.text = model.price;

    
    [self setupAutoHeightWithBottomViewsArray:@[self.photo,self.sendMsgBtn] bottomMargin:10];

}

#pragma mark action
-(void)sendMsg:(UIButton*)sender{
    if (self.privateBlock) {
        self.privateBlock(self.model);
        NSLog(@"private: self.model.summary = %@/",self.model.service);
    }
    NSLog(@"私信");
}
-(void)cancel:(UIButton*)sender{
    if (self.cancelBlock) {
        self.cancelBlock(self.model);
        NSLog(@"cancel: self.model.summary = %@/",self.model.service);
    }

    NSLog(@"取消");
}
-(void)modify:(UIButton*)sender{
    if (self.modifyBlock) {
        self.modifyBlock(self.model);
        NSLog(@"modify: cancel: self.model.summary = %@/",self.model.service);
    }

    NSLog(@"修改");
}

-(void)messageWithBlock:(PrivateMessageBlock)block{
    self.privateBlock = block;
}
-(void)cancelWithBlock:(CancelBlock)block{
    self.cancelBlock = block;
}
-(void)modifyWithBlock:(ModifyBlock)block{
    self.modifyBlock = block;
}
#pragma mark getter
-(UIButton *)sendMsgBtn{
    if (!_sendMsgBtn) {
        _sendMsgBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_sendMsgBtn setTitle:@"私信" forState:UIControlStateNormal];
        [_sendMsgBtn setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateNormal];
        _sendMsgBtn.titleLabel.font = XZFS_S_FONT(12);
        [_sendMsgBtn addTarget:self action:@selector(sendMsg:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendMsgBtn;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = XZFS_S_FONT(12);
        [_cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(UIButton *)modifyBtn{
    if (!_modifyBtn) {
        _modifyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_modifyBtn setTitle:@"修改" forState:UIControlStateNormal];
        [_modifyBtn setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateNormal];
        _modifyBtn.titleLabel.font = XZFS_S_FONT(12);
        [_modifyBtn addTarget:self action:@selector(modify:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _modifyBtn;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
