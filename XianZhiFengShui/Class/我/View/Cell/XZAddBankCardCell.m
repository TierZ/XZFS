//
//  XZAddBankCardCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/18.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZAddBankCardCell.h"

@implementation XZAddBankCardCell{
    UILabel * _title;
    UITextField * _input;
    UIImageView * _arrow;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
-(void)setupCell{
    

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
