//
//  XZLectureCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/12.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZLectureCell.h"
#import "UIButton+XZImageTitleSpacing.h"
@interface XZLectureCell()
@property (nonatomic,strong)UIImageView * photo;
@property (nonatomic,strong)UILabel * title;
@property (nonatomic,strong)UILabel * price;
@property (nonatomic,strong)UILabel * name;
@property (nonatomic,strong)UILabel * remain;
@property (nonatomic,strong)UIImageView * clock;
@property (nonatomic,strong)UILabel * time;
@property (nonatomic,strong)UILabel * collectionState;
@property (nonatomic,strong)UIButton * collection;
@end
@implementation XZLectureCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
        [self layoutCell];
    }
    return self;
}

#pragma mark draw
-(void)setupCell{
    [self.contentView addSubview:self.photo];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.price];
    [self.contentView addSubview:self. name];
    [self.contentView addSubview:self.remain];
    [self.contentView addSubview:self.clock];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.collection];
}

-(void)layoutCell{
    self.photo.frame = CGRectMake(20, 8, 85, 85);
    self.title.frame = CGRectMake(self.photo.right+8, 18, SCREENWIDTH-(self.photo.right+8)-80, 14);
    self.price.frame = CGRectMake(0, 24, SCREENWIDTH-40, 11);
    self.name.frame = CGRectMake(self.title.left, self.title.bottom+13.5, SCREENWIDTH-self.title.left-80, 11);
    self.remain.frame = CGRectMake(0, self.price.bottom+13.5, SCREENWIDTH-32, 10);
    self.clock .frame = CGRectMake(self.title.left, self.name.bottom+12, 15, 15);
    self.time.frame = CGRectMake(self.clock.right+7, self.clock.top+2, 200, 11);
    self.collection.frame = CGRectMake(SCREENWIDTH-50-32, self.clock.top, 50, 20);

}

#pragma mark action
-(void)collection:(UIButton*)sender{
    sender.selected = !sender.selected;
    NSLog(@"收藏");
}


#pragma mark refresh
-(void)refreshLectureCellWithModel:(XZTheMasterModel*)model{
    if (model) {
        [self.photo setImageWithURL:[NSURL URLWithString:model.masterIcon] options:YYWebImageOptionProgressive ];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.photo.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.photo.bounds.size];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        //设置大小
        maskLayer.frame = self.photo.bounds;
        //设置图形样子
        maskLayer.path = maskPath.CGPath;
        self.photo.layer.mask = maskLayer;
        
        
        self.title.text = model.title;
        self.name.text = [NSString stringWithFormat:@"%@  %@",model.masterName,model.masterDesc];
        self.remain.text = model.remainSeats;
        self.price.text = model.price;
        self.time.text = model.startTime;
        self.collection.selected = model.isCollected;
    }
}

-(void)showPrice:(BOOL)isShow{
    self.remain.hidden = !isShow;
    self.price.hidden = !isShow;
//    self.collection.hidden = !isShow;
}
-(void)openCollectionUserInterfaced:(BOOL)isOpen{
    self.collection.userInteractionEnabled = isOpen;
}
#pragma mark getter
-(UIImageView *)photo{
    if (!_photo) {
        _photo = [[UIImageView alloc]init];
    }
    return _photo;
}
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.backgroundColor = [UIColor clearColor];
        _title.textColor =  XZFS_TEXTBLACKCOLOR;
        _title.textAlignment =NSTextAlignmentLeft;
        _title.font = XZFS_S_FONT(14);
    }
    return _title;
}
-(UILabel *)price{
    if (!_price) {
        _price = [[UILabel alloc]init];
        _price.backgroundColor = [UIColor clearColor];
        _price.textColor =  XZFS_TEXTORANGECOLOR;
        _price.textAlignment =NSTextAlignmentRight;
        _price.font = XZFS_S_FONT(10);
    }
    return _price;
}

-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc]init];
        _name.backgroundColor = [UIColor clearColor];
        _name.textColor =  XZFS_TEXTGRAYCOLOR;
        _name.textAlignment =NSTextAlignmentLeft;
        _name.font = XZFS_S_FONT(11);
    }
    return _name;
}

-(UILabel *)remain{
    if (!_remain) {
        _remain = [[UILabel alloc]init];
        _remain.backgroundColor = [UIColor clearColor];
        _remain.textColor =  XZFS_TEXTBLACKCOLOR;
        _remain.textAlignment =NSTextAlignmentRight;
        _remain.font = XZFS_S_FONT(10);
    }
    return _remain;
}

-(UIImageView *)clock{
    if (!_clock) {
        _clock = [[UIImageView alloc]init];
        _clock.image = XZFS_IMAGE_NAMED(@"kaishishijian");
    }
    return _clock;
}

-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]init];
        _time.backgroundColor = [UIColor clearColor];
        _time.textColor =  XZFS_TEXTBLACKCOLOR;
        _time.textAlignment =NSTextAlignmentLeft;
        _time.font = XZFS_S_FONT(11);
    }
    return _time;
}
//-(UILabel *)collectionState{
//    if (!_collectionState) {
//        _collectionState = [[UILabel alloc]init];
//        _collectionState.backgroundColor = [UIColor clearColor];
//        _collectionState.textColor =  XZFS_TEXTGRAYCOLOR;
//        _collectionState.textAlignment =NSTextAlignmentLeft;
//        _collectionState.font = XZFS_S_FONT(11);
//    }
//    return _collectionState;
//    
//}
-(UIButton *)collection{
    if (!_collection) {
        _collection = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collection setTitle:@"收藏" forState:UIControlStateNormal];
        [_collection setTitleColor:XZFS_TEXTGRAYCOLOR forState:UIControlStateNormal];
          [_collection setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateSelected];
        [_collection setImage:XZFS_IMAGE_NAMED(@"weishoucang") forState:UIControlStateNormal];
         [_collection setImage:XZFS_IMAGE_NAMED(@"yishoucang") forState:UIControlStateSelected];
        [_collection layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleRight imageTitleSpace:5];
        _collection.titleLabel.font = XZFS_S_FONT(11);
        [_collection addTarget:self action:@selector(collection:) forControlEvents:UIControlEventTouchUpInside];
        _collection.userInteractionEnabled = YES;
    }
    return _collection;
}

#pragma mark ..
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
