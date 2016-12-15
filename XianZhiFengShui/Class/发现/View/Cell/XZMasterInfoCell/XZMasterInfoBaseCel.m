//
//  XZMasterInfoBaseCel.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/25.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterInfoBaseCel.h"

@implementation XZMasterInfoBaseCel

- (void)drawRect:(CGRect)rect
{
        CGContextRef context = UIGraphicsGetCurrentContext();
    
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        CGContextFillRect(context, rect);
        //下分割线
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"#E6E6E7"].CGColor);
        CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width , 1));

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
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
