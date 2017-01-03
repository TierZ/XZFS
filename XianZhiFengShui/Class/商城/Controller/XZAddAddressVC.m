//
//  XZAddAddressVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/12.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZAddAddressVC.h"
#import "ValidateTextField.h"
#import "ValidateRule.h"
#import "XZOpenProvinceDB.h"
#import "XZAddAddressCell.h"
#import "ActionSheet_UIPickerView.h"

static NSString * infoCellId = @"infoCellId";

@interface XZAddAddressVC ()<UITableViewDelegate,UITableViewDataSource,ActionSheet_UIPickerViewDelegate>
@property (nonatomic,strong)ValidateTextField * nameTf;
@property (nonatomic,strong)ValidateTextField * phoneTf;
@property (nonatomic,strong)UITableView * infoTable;
@property (nonatomic,strong)NSArray * infoArray;
@property (nonatomic,strong)ActionSheet_UIPickerView * areaPick;
@property (nonatomic,strong)ActionSheet_UIPickerView * townPick;
@property (nonatomic,strong)NSArray * provinceArray;
@property (nonatomic,strong)NSArray * cityArray;
@property (nonatomic,strong)NSArray * areaArray;
@property (nonatomic,strong)NSArray * townArray;
@property (nonatomic,weak)XZAddAddressCell * selectCell;
@end

@implementation XZAddAddressVC{
    XZOpenProvinceDB * provinceDb;
    
    /*
     各个级别 选择后 id
     */
    int provinceId;
    int cityId;
    int areaId;
    int townId;
    
    /*
     各个级别 选择后 下标
     */
    int provinceIndex;
     int cityIndex;
     int areaIndex;
     int townIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAddressData];
    [self setupInputInfo];
    
    provinceIndex = 0;
    cityIndex = 0;
    areaIndex = 0;
    townIndex = 0;
}

-(void)setupAddressData{
    if (!provinceDb) {
        provinceDb = [XZOpenProvinceDB sharedProvinceDB];
    }
    BOOL isOpen = [provinceDb OpenDatabase];
    if (isOpen) {
        NSLog(@"打开数据库");
        self.provinceArray = [provinceDb selectDBData];
        provinceId = [[[self.provinceArray firstObject]objectForKey:@"id"]intValue];
        self.cityArray = [provinceDb selectCityData:provinceId];
        
       cityId = [[[self.cityArray firstObject]objectForKey:@"id"]intValue];
        self.areaArray = [provinceDb selectAreaData:cityId];

        areaId = [[[self.areaArray firstObject]objectForKey:@"id"]intValue];
        self.townArray = [provinceDb selectTownData:areaId];
        
        townId = [[[self.townArray firstObject]objectForKey:@"id"]intValue];
        
      }else{
        [ToastManager showToastOnView:self.mainView position:CSToastPositionCenter flag:NO message:@"数据请求失败"];
    }
}

-(void)setupInputInfo{
    
    _infoTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 4, SCREENWIDTH, XZFS_MainView_H-4) style:UITableViewStylePlain];
    _infoTable.backgroundColor = self.mainView.backgroundColor;
    _infoTable.delegate = self;
    _infoTable.dataSource = self;
    [self.mainView addSubview:_infoTable];
    _infoTable.tableFooterView = [self setupFooterView];
    [_infoTable registerClass:[XZAddAddressCell class] forCellReuseIdentifier:infoCellId];
}

-(UIView*)setupFooterView{
    UIView * footerV = [UIView new];
    footerV.backgroundColor = [UIColor clearColor];
    footerV.frame = CGRectMake(0, 0, SCREENWIDTH, 130);
    
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.backgroundColor = XZFS_TEXTORANGECOLOR;
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = XZFS_S_FONT(18);
    [saveBtn addTarget:self action:@selector(saveAddress) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.frame = CGRectMake(20, 45, footerV.width-40, 45);
    saveBtn.layer.masksToBounds = YES;
    saveBtn.layer.cornerRadius = 5;
    [footerV addSubview:saveBtn];
   
    return footerV;
}

#pragma mark action
-(void)saveAddress{
    NSLog(@"保存地址");
}

#pragma mark table 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.infoArray.count>0?self.infoArray.count:1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.infoArray[section]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XZAddAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:infoCellId forIndexPath:indexPath];
    NSDictionary * dic = self.infoArray[indexPath.section][indexPath.row];
    [cell refreshCellWithDic:dic indexPath:indexPath];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==[self.infoArray[indexPath.section]count]-1) {
            return 88;
        }
    }return 36;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footerView = [UIView new];
    footerView.backgroundColor = self.mainView.backgroundColor;
    footerView.frame = CGRectMake(0, 0, SCREENWIDTH, 12);
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 12;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section==0) {
        if (indexPath.row==2) {
             XZAddAddressCell * cell = [self.infoTable cellForRowAtIndexPath:indexPath];
            self.selectCell = cell;
            self.areaPick = [ActionSheet_UIPickerView styleDefault];
            self.areaPick.delegate = self;
            [self.areaPick show:self];
            [self.areaPick selectRow:provinceIndex inComponent:0 animated:YES];
            [self.areaPick selectRow:cityIndex inComponent:1 animated:YES];
            [self.areaPick selectRow:areaIndex inComponent:2 animated:YES];
        }else if (indexPath.row==3){
            XZAddAddressCell * cell = [self.infoTable cellForRowAtIndexPath:indexPath];
            self.selectCell = cell;
            self.townPick = [ActionSheet_UIPickerView styleDefault];
            self.townPick.delegate = self;
            [self.townPick show:self];
            [self.townPick selectRow:townIndex inComponent:0 animated:YES];
        }
    }
}

#pragma mark pickviewDelegate
- (void)actionCancleWithPick:(UIPickerView *)pick{
    if (pick==self.areaPick.pickerView) {
        [self.areaPick dismiss:self];
    }else if (pick==self.townPick.pickerView){
        [self.townPick dismiss:self];
    }else{
        
    }
//    provinceIndex = 0;
//    cityIndex = 0;
//    areaIndex = 0;
//    townIndex = 0;
//    [self setupAddressData];
    
//    if (self.bankNoTf.text.length>0&&self.bankAreaLab.text.length>0&&self.bankNameLab.text.length>0&&self.bankBranchNameTf.text.length>0) {
//        addCardButton.backgroundColor = SGLC_HEX_RGB(@"#ed725e");
//        addCardButton.userInteractionEnabled = YES;
//    }else{
//        addCardButton.backgroundColor = SGLC_HEX_RGB(@"#dcdcdc");
//        addCardButton.userInteractionEnabled = NO;
//    }
    
}

- (void)actionDoneWithPick:(UIPickerView *)pick {
    
    if (pick==self.areaPick.pickerView) {
        [self.areaPick dismiss:self];
        NSString * selectProvince = [self.provinceArray[provinceIndex]objectForKey:@"name"];
        NSString * selectCity = [self.cityArray[cityIndex]objectForKey:@"name"];
        NSString * selectArea= [self.areaArray[areaIndex]objectForKey:@"name"];
       
        
        [self.selectCell refreshContent:[NSString stringWithFormat:@"%@%@%@",selectProvince,selectCity,selectArea]];
    }else if (pick==self.townPick.pickerView){
         NSString * selectTown= [self.townArray[townIndex]objectForKey:@"name"];
        [self.townPick dismiss:self];
        [self.selectCell refreshContent:selectTown];
    }
    
//    if (self.bankNoTf.text.length>0&&self.bankAreaLab.text.length>0&&self.bankNameLab.text.length>0&&self.bankBranchNameTf.text.length>0) {
//        addCardButton.backgroundColor = SGLC_HEX_RGB(@"#ed725e");
//        addCardButton.userInteractionEnabled = YES;
//    }else{
//        addCardButton.backgroundColor = SGLC_HEX_RGB(@"#dcdcdc");
//        addCardButton.userInteractionEnabled = NO;
//    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView==self.townPick.pickerView) {
        return 1;
    }
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView==self.townPick.pickerView) {
        return self.townArray.count;
    }else if (pickerView==self.areaPick.pickerView){
        if (component==0) {
            return self.provinceArray.count;
        }else if (component==1){
            return self.cityArray.count;
        }else{
            return self.areaArray.count;
        }
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView==self.townPick.pickerView) {
    
        return [[self.townArray objectAtIndex:row]objectForKey:@"name"];
    }else if (pickerView==self.areaPick.pickerView){
        if (component==0) {
            return [[self.provinceArray objectAtIndex:row] objectForKey:@"name"];
        }else if (component==1){
            return [[self.cityArray objectAtIndex:row] objectForKey:@"name"];;
        }else{
             return [[self.areaArray objectAtIndex:row]objectForKey:@"name"];;
        }
    }return nil;
    
    
}
//
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString * provinceStr;
    NSString * cityStr;
    NSString * areaStr;
    NSString * townStr;
    if (pickerView==self.townPick.pickerView) {
        townIndex =(int)row;
        townStr = [self.townArray[row] objectForKey:@"name"];
    }else if (pickerView==self.areaPick.pickerView){
       
         if (component==0) {
              provinceIndex =(int)row;
            provinceStr = [self.provinceArray[row] objectForKey:@"name"];
             provinceId = [provinceDb selectProStr:provinceStr];
            self.cityArray = [provinceDb selectCityData:provinceId];
             cityId = [[[self.cityArray firstObject]objectForKey:@"id"]intValue];
             self.areaArray = [provinceDb selectAreaData:cityId];
             areaId = [[[self.areaArray firstObject]objectForKey:@"id"]intValue];
            
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
        }else if (component==1){
             cityIndex =(int)row;
          cityStr = [self.cityArray[row] objectForKey:@"name"];
            cityId = [provinceDb selectCityStr:cityStr withProID:provinceId];
            self.areaArray = [provinceDb selectAreaData:cityId];
            areaId = [[[self.areaArray firstObject]objectForKey:@"id"]intValue];
            [pickerView reloadComponent:2];
        }else{
            areaIndex =(int)row;
            areaStr =  [self.areaArray[row] objectForKey:@"name"];
            areaId = [provinceDb selectAreaStr:areaStr withProID:provinceId withCityID:cityId];
            self.townArray = [provinceDb selectTownData:areaId];
            townId = [[[self.townArray firstObject]objectForKey:@"id"]intValue];
        }
    }
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textColor = XZFS_HEX_RGB(@"#333333");
        pickerLabel.textAlignment = NSTextAlignmentCenter ;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:XZFS_S_FONT(18)];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}



#pragma mark getter

-(NSArray *)infoArray{
    if (!_infoArray) {
        _infoArray =  @[@[@{@"收货人":@""},@{@"联系电话":@""},@{@"所在地区":@""},@{@"街道":@""},@{@"":@""}],@[@{@"设为默认":@""}]];

    }
    return _infoArray;
}

-(NSArray *)provinceArray{
    if (!_provinceArray) {
        _provinceArray = [NSArray array];
    }
    return _provinceArray;
}

-(NSArray *)cityArray{
    if (!_cityArray) {
        _cityArray = [NSArray array];
    }
    return _cityArray;
}

-(NSArray *)areaArray{
    if (!_areaArray) {
        _areaArray = [NSArray array];
    }
    return _areaArray;
}

-(NSArray *)townArray{
    if (!_townArray) {
        _townArray = [NSArray array];
    }
    return _townArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
