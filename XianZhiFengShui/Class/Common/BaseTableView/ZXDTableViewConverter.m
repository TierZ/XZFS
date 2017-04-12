//
//  ZXDTableViewConverter.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/4/11.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "ZXDTableViewConverter.h"
#import "ZXDBaseTableViewCell.h"

@interface ZXDTableViewConverter ()

@property (nonatomic, weak) id tableViewCarrier;

@property (nonatomic, strong) NSMutableArray *dataArr;

//key:selector     value:block
@property (nonatomic, strong) NSMutableDictionary *selectorsDic;

@end

@implementation ZXDTableViewConverter

- (instancetype)initWithTableViewCarrier:(id)carrier dataSource:(NSMutableArray*)dataSource
{
    self = [super init];
    if (self) {
        self.tableViewCarrier = carrier;
        self.dataArr = dataSource;
    }
    return self;
}

-(void)registTableviewWithMethod:(SEL)selector Params:(paramsBlock)block{
    [self.selectorsDic setObject:block forKey:NSStringFromSelector(selector)];
}

-(id)invocationWithSelector:(SEL)selector params:(NSArray*)params{
/*    在 iOS中可以直接调用某个对象的消息方式有两种：
    一种是performSelector:withObject；再一种就是NSInvocation。
    第一种方式比较简单，能完成简单的调用。但是对于大于2个的参数或者有返回值的处理，那performSelector:withObject就显得有点有心无力了，那么在这种情况下，我们就可以使用NSInvocation来进行这些相对复杂的操作
    */
    
    
    
    //1、根据方法来初始化NSMethodSignature
    NSMethodSignature * signature = [_tableViewCarrier methodSignatureForSelector:selector];
    
    // NSInvocation中保存了方法所属的对象/方法名称/参数/返回值
    //其实NSInvocation就是将一个方法变成一个对象
    //2、创建NSInvocation对象
    NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
    if (signature == nil) {
        //selector为传进来的方法
        NSString *info = [NSString stringWithFormat:@"%@方法找不到", NSStringFromSelector(selector)];
        [NSException raise:@"方法调用出现异常" format:info, nil];
        return nil;
    }
    invocation.target = _tableViewCarrier;
    invocation.selector = selector;
    
    //此处不能通过遍历参数数组来设置参数，因为外界传进来的参数个数是不可控的
    //因此通过numberOfArguments方法获取的参数个数,是包含self和_cmd的，然后比较方法需要的参数和外界传进来的参数个数，并且取它们之间的最小值
    NSUInteger argsCount = signature.numberOfArguments - 2;
    NSUInteger arrCount = params.count;
    NSUInteger count = MIN(argsCount, arrCount);
    for (int i = 0; i < count; i++) {
        id obj = params[i];
        // 判断需要设置的参数是否是NSNull, 如果是就设置为nil
        if ([obj isKindOfClass:[NSNull class]]) {
            obj = nil;
        }
          //atIndex的下标必须从2开始。原因为：因为0跟1已经被占据了，分别是self（target）,selector(_cmd)
        [invocation setArgument:&obj atIndex:i + 2];
    }
    //retain 所有参数，防止参数被释放dealloc
    [invocation retainArguments];
    //3、调用invoke方法
    [invocation invoke];
    
    //获得返回值类型
    const char *returnType = signature.methodReturnType;
    //声明返回值变量
    id returnValue;
    
    if( !strcmp(returnType, @encode(void)) ){
        //如果没有返回值，也就是消息声明为void，那么returnValue=nil
        returnValue =  nil;
    }else if( !strcmp(returnType, @encode(id)) ){
        [invocation getReturnValue:&returnValue];
    }else {
        //如果返回值为普通类型NSInteger、BOOL、CGFloat
        //返回值长度
        NSUInteger length = [signature methodReturnLength];
        
        //根据长度申请内存
        void *buffer = (void *)malloc(length);
        
        //为变量赋值
        [invocation getReturnValue:buffer];
        
        if( !strcmp(returnType, @encode(BOOL)) ) {
            returnValue = [NSNumber numberWithBool:*((BOOL*)buffer)];
        }
        else if( !strcmp(returnType, @encode(NSInteger)) ){
            returnValue = [NSNumber numberWithInteger:*((NSInteger*)buffer)];
        }
        else if ( !strcmp(returnType, @encode(CGFloat)) ) {
            returnValue = [NSNumber numberWithFloat:*((NSInteger*)buffer)];
        }
    }
    return returnValue;
}

-(id)convertorWithFunction:(NSString*)fuc params:(NSArray*)params{
    if (_convertType==ZXDTableViewConverter_Register ) {
        SEL selector = NSSelectorFromString(fuc);
        if ([_tableViewCarrier respondsToSelector:selector]) {
            return [self invocationWithSelector:selector params:params];
        }
        return nil;
    }else if (_convertType==ZXDTableViewConverter_Response){
        if ([[self.selectorsDic allKeys]containsObject:fuc]) {
            paramsBlock block = [_selectorsDic objectForKey:fuc];
            return block(params);
        }
    }
    return nil;
}

#pragma mark tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger sections = [[self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView]] integerValue];
    return sections>0?:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = [[self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,@(section)]]integerValue];
    return rows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXDBaseTableViewCell * cell = [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]];
    return cell;
}


- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,@(section)]];
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
     return [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,@(section)]];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
     return [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]];
}


- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView __TVOS_PROHIBITED{
    return [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView]];
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index __TVOS_PROHIBITED{
    return [[self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,title,@(index)]] integerValue];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,@(editingStyle),indexPath]];
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,sourceIndexPath,destinationIndexPath]];
}

#pragma mark tableviewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,cell,indexPath]];
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0){
    [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,view,@(section)]];
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0){
    [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,view,@(section)]];
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0){
    [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,cell,indexPath]];
}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0){
     [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,view,@(section)]];
}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0){
    [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,view,@(section)]];
}

// Variable height support

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]] floatValue];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  [[self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,@(section)]] floatValue];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
      return  [[self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,@(section)]] floatValue];
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0){
    return [[self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]] floatValue];
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0){
    return  [[self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,@(section)]] floatValue];
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0){
    return  [[self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,@(section)]] floatValue];
}

// Section header & footer information. Views are preferred over title should you decide to provide both

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,@(section)]];
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,@(section)]];
}
- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED{
     return [[self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]] floatValue];
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]] ;
}

// Selection

// -tableView:shouldHighlightRowAtIndexPath: is called when a touch comes down on a row.
// Returning NO to that message halts the selection process and does not cause the currently selected row to lose its selected look while the touch is down.
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0){
    return [[self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]]boolValue];
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0){
    [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]];
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0){
    [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]];
}

// Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return   [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]];

}
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0){
     return   [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]];
}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0){
     [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]] intValue];
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED{
    return [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]];
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED{
    return  [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]];
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return  [[self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]]boolValue];
}

// The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath __TVOS_PROHIBITED{
     [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]];
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath __TVOS_PROHIBITED{
     [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]];
}

// Moving/reordering

// Allows customization of the target row for a particular row as it is being moved/reordered
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    return  [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,sourceIndexPath,proposedDestinationIndexPath]];
}

// Indentation

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  [[self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]] integerValue];
}

// Copy/Paste.  All three methods must be implemented by the delegate.

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(5_0){
    return [[self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]] boolValue];
}
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0){
    return [[self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,NSStringFromSelector(action),indexPath,sender]] boolValue];
}
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0){
    [[self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,NSStringFromSelector(action),indexPath,sender]] boolValue];
}

// Focus

- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0){
    return [[self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,indexPath]] boolValue];
}
- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context NS_AVAILABLE_IOS(9_0){
    return [[self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,context]] boolValue];
}
- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator NS_AVAILABLE_IOS(9_0){
    [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView,context,coordinator]];
}
- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView NS_AVAILABLE_IOS(9_0){
    return [self convertorWithFunction:NSStringFromSelector(_cmd) params:@[tableView]];
}

#pragma mark getter
-(NSMutableDictionary *)selectorsDic{
    if (!_selectorsDic) {
        _selectorsDic = [NSMutableDictionary dictionary];
    }
    return _selectorsDic;
}
@end





@implementation UITableView (ZXDIdentificerCell)

-(ZXDBaseTableViewCell *)setupCellWithIndexPath:(NSIndexPath *)indexPath cellClass:(Class)cellClass{
    if ([cellClass isSubclassOfClass:[ZXDBaseTableViewCell class]]) {
         NSString * cellId = [NSString stringWithFormat:@"%@Id",NSStringFromClass(cellClass)];
        ZXDBaseTableViewCell * cell = [self dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            [self registerClass:cellClass forCellReuseIdentifier:cellId];
            cell = [[ZXDBaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        return cell;
    }return [ZXDBaseTableViewCell new];

}

@end
