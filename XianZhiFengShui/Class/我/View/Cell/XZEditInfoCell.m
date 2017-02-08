//
//  XZEditInfoCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/2/8.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZEditInfoCell.h"
@interface XZEditInfoCell ()<UITextFieldDelegate>

@end
@implementation XZEditInfoCell{
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.editTf];
    }
    return self;
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    if ([textField.text hasSuffix:self.subStr]) {
//        textField.text = [textField.text componentsSeparatedByString:self.subStr].firstObject;
//    }
    return true;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
//    NSString *originStr = textField.text;
//    if (textField.text.length != 0) {
//        textField.text = [NSString stringWithFormat:@"%@%@",textField.text,self.subStr];
//    }
    if (self.block) {
        self.block(textField.text);
    }
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}
-(void)editInfoWithBlock:(EditInfoBlock)block{
    self.block = block;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UITextField *)editTf{
    if (!_editTf) {
        _editTf = [[UITextField alloc]initWithFrame:CGRectMake(120, 12, SCREENWIDTH-130, 20)];
        _editTf.textColor = XZFS_TEXTBLACKCOLOR;
        _editTf.font = XZFS_S_FONT(14);
        _editTf.delegate = self;
    }
    return _editTf;
}

@end
