//
//  XZHomeView.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/24.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZHomeView.h"
#import "XZTheMasterCell.h"
#import "XZLectureCell.h"
#import "SDCycleScrollView.h"
#import "UIButton+XZImageTitleSpacing.h"
#import "XZLectureDetailVC.h"
#import "XZMasterDetailVC.h"
@interface XZHomeView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation XZHomeView{
    SDCycleScrollView *scrollView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpTable];
        [self setupHeaderView];
    }
    return self;
}

#pragma mark setup
-(void)setUpTable{
//    _xzHomeTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//    _xzHomeTable.backgroundColor = XZFS_HEX_RGB(@"#ffffff");
//    _xzHomeTable.dataSource = self;
//    _xzHomeTable.delegate = self;
//    _xzHomeTable.backgroundColor = [UIColor whiteColor];
//    _xzHomeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.xzHomeTable.frame = CGRectMake(0, 0, self.width, self.height);
    [self addSubview:self.xzHomeTable];
    

    
}

//设置tableview 的headerview
- (void)setupHeaderView
{
    UIView *header = [UIView new];
    
    // 由于tableviewHeaderView的特殊性，在使他高度自适应之前你最好先给它设置一个宽度
    header.width = SCREENWIDTH;
    
    
    scrollView = [SDCycleScrollView new];
    if (self.xzHomeData.count>0) {
        scrollView.localizationImageNamesGroup = self.xzHomeData[0];
    }else{
        scrollView.localizationImageNamesGroup = @[];
    }
    [header addSubview:scrollView];
    
    UILabel *tagLabel = [UILabel new];
    tagLabel.font = [UIFont systemFontOfSize:13];
    tagLabel.textColor = XZFS_TEXTBLACKCOLOR;
    tagLabel.text = @"办公室如何装扮才会财运亨通";
    [header addSubview:tagLabel];
    
    UILabel *detailLabel = [UILabel new];
    detailLabel.font = [UIFont systemFontOfSize:11];
    detailLabel.textColor = XZFS_HEX_RGB(@"#C0C0C1");
    detailLabel.text = @"中国风水协会会长。。。。";
    [header addSubview:detailLabel];
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [header addSubview:bottomLine];
    
    scrollView.sd_layout
    .leftSpaceToView(header, 0)
    .topSpaceToView(header, 0)
    .rightSpaceToView(header, 0)
    .heightIs(150);
    
    tagLabel.sd_layout
    .leftSpaceToView(header, 23)
    .topSpaceToView(scrollView, 6)
    .heightIs(13)
    .rightSpaceToView(header, 0);
    
    detailLabel.sd_layout
    .leftEqualToView(tagLabel)
    .topSpaceToView(tagLabel, 10)
    .heightIs(11)
    .rightSpaceToView(header, 0);
    
    bottomLine.sd_layout
    .topSpaceToView(detailLabel, 0)
    .leftSpaceToView(header, 0)
    .rightSpaceToView(header, 0)
    .heightIs(1);
    
    [header setupAutoHeightWithBottomView:bottomLine bottomMargin:0];
    [header layoutSubviews];
    
    self.xzHomeTable.tableHeaderView = header;
}


#pragma mark action
//换一批
-(void)seeAnother:(UIButton*)sender{
    NSLog(@"换一批");
}

//标签选择
-(void)selectStyle:(UIButton*)sender{
    NSLog(@"标签选择 sender.tag = %ld",(long)sender.tag);
}

-(void)refreshHeadView{
    NSArray * picUrl = self.xzHomeData.count>0? [self.xzHomeData firstObject]:@[];
    NSMutableArray * imageUrlArr = [NSMutableArray array];
    NSMutableArray * jumpUrlArr = [NSMutableArray array];
#warning 这个数据不对。。先不添加
    for (int i=0; i<picUrl.count; i++) {
//        [imageUrlArr addObject:[picUrl[i] objectForKey:@"picUrl"]];
//        [jumpUrlArr addObject:[picUrl[i] objectForKey:@"url"]];
    }
    
    scrollView.imageURLStringsGroup = imageUrlArr;;

}

#pragma mark tabledelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.xzHomeData&&[self.xzHomeData count]>1) {
        return [self.xzHomeData count]-1;
    }return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.xzHomeData count]>1) {
        return [self.xzHomeData[section+1]count];
    }return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * stylesCellId = @"homeStyleCellId";
    static NSString * masterCellId = @"homeMasterCellId";
    static NSString * lectureCellId = @"homeLectureCellId";
    
    if (indexPath.section==0) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:stylesCellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stylesCellId];
        }
        NSDictionary * tagsDic = self.xzHomeData[indexPath.section+1];
        UIView * styleView = [self setUpStyleCellWithItems:[tagsDic objectForKey:@"tags"]];
        [cell.contentView addSubview:styleView];
        cell.height = styleView.bottom;
        return cell;
    }else if (indexPath.section==1){
        XZTheMasterCell * cell = [tableView dequeueReusableCellWithIdentifier:masterCellId];
        if (!cell) {
            cell = [[XZTheMasterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:masterCellId];
        }
        
        [cell refreshMasterCellWithModel:self.xzHomeData [indexPath.section+1][indexPath.row]];
        return cell;
    }else{
        XZLectureCell * cell = [tableView dequeueReusableCellWithIdentifier:lectureCellId];
        if (!cell) {
            cell = [[XZLectureCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lectureCellId];
        }
        
        [cell refreshLectureCellWithModel:self.xzHomeData [indexPath.section+1][indexPath.row]];
        return cell;

    }
    
//    switch (indexPath.section) {
//        case 0:{
//            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:stylesCellId];
//            if (!cell) {
//                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stylesCellId];
//            }
//            NSDictionary * tagsDic = self.xzHomeData[indexPath.section+1];
//            UIView * styleView = [self setUpStyleCellWithItems:[tagsDic objectForKey:@"tags"]];
//            [cell.contentView addSubview:styleView];
//            cell.height = styleView.bottom;
//            return cell;
//        }
//            break;
//        case 1:{
//            XZTheMasterCell * cell = [tableView dequeueReusableCellWithIdentifier:masterCellId];
//            if (!cell) {
//                cell = [[XZTheMasterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:masterCellId];
//            }
//            
//            [cell refreshMasterCellWithModel:self.xzHomeData [indexPath.section+1][indexPath.row]];
//            return cell;
//        }
//            break;
//        case 2:{
//            XZLectureCell * cell = [tableView dequeueReusableCellWithIdentifier:lectureCellId];
//            if (!cell) {
//                cell = [[XZLectureCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lectureCellId];
//            }
//            
//            [cell refreshLectureCellWithModel:self.xzHomeData [indexPath.section+1][indexPath.row]];
//            return cell;
//        }
//            break;
//            
//        default:{
//            UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"otherCell"];
//            return cell;
//        }
//            
//            break;
//    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
        return 103;
    }
    UITableViewCell * cell = [self tableView:self.xzHomeTable cellForRowAtIndexPath:indexPath];
    return cell.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:{
            
        }
            break;
        case 1:{
            XZTheMasterModel * model = self.xzHomeData [indexPath.section+1][indexPath.row];
            XZMasterDetailVC * detailvc = [[XZMasterDetailVC alloc]initWithMasterCode:model.masterCode];
            [self.curretnVC.navigationController pushViewController:detailvc animated:YES
             ];
        }
            break;
        case 2:{
              XZTheMasterModel * model = self.xzHomeData [indexPath.section+1][indexPath.row];
            XZLectureDetailVC * detailvc = [[XZLectureDetailVC alloc]initWithModel:model];
            [self.curretnVC.navigationController pushViewController:detailvc animated:YES
             ];

        }
            break;
            
        default:
            break;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headview = [UIView new];
    if (section==0) {
        headview.frame = CGRectMake(0, 0, tableView.width, 10);
        headview.backgroundColor = XZFS_TEXTORANGECOLOR;

    }else{
        NSArray * headTitleArray = @[@"推荐大师",@"精品讲座"];
        headview.frame = CGRectMake(0, 0, tableView.width, 43);
        UILabel * headTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, headview.width, 43)];
        headTitle.backgroundColor = [UIColor whiteColor];
        headTitle.textColor = XZFS_TEXTBLACKCOLOR;
        headTitle.font = XZFS_S_FONT(14);
        headTitle.textAlignment = NSTextAlignmentCenter;
        headTitle.text  =headTitleArray[section-1];
        [headview addSubview:headTitle];
        if (section==1) {
            UIButton * seeAnotherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            seeAnotherBtn.frame = CGRectMake(SCREENWIDTH-70-20, 11.5, 70, 20);
            [seeAnotherBtn setTitle:@"换一批" forState:UIControlStateNormal];
            [seeAnotherBtn setTitleColor:XZFS_TEXTBLACKCOLOR forState:UIControlStateNormal];
            [seeAnotherBtn setImage:XZFS_IMAGE_NAMED(@"huanyipi") forState:UIControlStateNormal];
            seeAnotherBtn.titleLabel.font = XZFS_S_FONT(14);
            [seeAnotherBtn layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleLeft imageTitleSpace:5];
            [seeAnotherBtn addTarget:self action:@selector(seeAnother:) forControlEvents:UIControlEventTouchUpInside];
            [headview addSubview:seeAnotherBtn];
        }
    }
    return headview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }
    return 43;
}

#pragma mark private

//设置标签cell
-(UIView*)setUpStyleCellWithItems:(NSArray*)items{
    UIView * styleView = [UIView new];
    styleView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i<items.count; i++) {
        NSDictionary * item = items[i];
        UIButton* styleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        styleBtn.frame = CGRectMake(i%4*(self.width/4),98* (i/4), self.width/4, 98);
        styleBtn.layer.masksToBounds = YES;
        [styleBtn setImageWithURL:[NSURL URLWithString:[item objectForKey:@"remark"]] forState:UIControlStateNormal options:YYWebImageOptionProgressive];
//        [styleBtn setImage:XZFS_IMAGE_NAMED(@"level1") forState:UIControlStateNormal];
        styleBtn.backgroundColor = [UIColor whiteColor];
        [styleBtn setTitle:[item objectForKey:@"name"] forState:UIControlStateNormal];
        [styleBtn setTitleColor:XZFS_TEXTBLACKCOLOR forState:UIControlStateNormal];
        [styleBtn layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleTop imageTitleSpace:5];
        [styleBtn addTarget:self action:@selector(selectStyle:) forControlEvents:UIControlEventTouchUpInside];
        
        styleBtn.tag = 10+i;
                                                  
        styleBtn.titleLabel.font = XZFS_S_FONT(11);
        [styleView addSubview:styleBtn];
    }
    
    if (items.count==0) {
        styleView.frame = CGRectMake(0, 0, self.width, 10);
    }else{
        styleView.frame = CGRectMake(0, 0, self.width, 98*items.count/4);
    }
    
    return styleView;
}

#pragma mark getter
-(XZRefreshTable *)xzHomeTable{
    if (!_xzHomeTable) {
        _xzHomeTable = [[XZRefreshTable alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _xzHomeTable.backgroundColor = XZFS_HEX_RGB(@"#ffffff");
        _xzHomeTable.dataSource = self;
        _xzHomeTable.delegate = self;
        _xzHomeTable.backgroundColor = [UIColor whiteColor];
        _xzHomeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _xzHomeTable.mj_footer.hidden = YES;
        UIView * footerView = [[UIView alloc]initWithFrame:CGRectZero];;
        footerView.backgroundColor = [UIColor clearColor];
        _xzHomeTable.tableFooterView = footerView;
    }
    
    return _xzHomeTable;
}
-(NSMutableArray *)xzHomeData{
    if (!_xzHomeData) {
        _xzHomeData = [NSMutableArray array];
    }
    return _xzHomeData;
}
@end
