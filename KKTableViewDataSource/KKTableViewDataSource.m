//
//  KKTableViewDataSource.m
//  KKTableViewDataSource
//
//  Created by zainguo on 2020/5/7.
//  Copyright © 2020 zainguo. All rights reserved.
//

#import "KKTableViewDataSource.h"
#import "KKDataSourceModel.h"


@interface KKTableViewDataSource ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<KKDataSourceModel *>*datas;

#pragma mark - 不使用KKDataSourceModel来设置数据源
@property (nonatomic, assign) CGFloat cellHeight;
// 区头高度
@property (nonatomic, assign) CGFloat headerHeight;
// 区尾高度
@property (nonatomic, assign) CGFloat footerHeight;
// 重用标识符
@property (nonatomic, copy) NSString *cellIdentifier;
// 数据源
@property (nonatomic, strong) NSMutableArray *items;


@end

@implementation KKTableViewDataSource

#pragma mark - 初始化
- (instancetype)initWithTableView:(UITableView *)tableView {
    if (self = [super init]) {
        [self __setupTableView:tableView];
    }
    return self;
}
- (instancetype)initWithTableView:(UITableView *)tableView
                   cellIdentifier:(NSString *)cellIdentifier
                       cellHeight:(CGFloat)cellHeight {
    
    return [self initWithTableView:tableView
                    cellIdentifier:cellIdentifier
                        cellHeight:cellHeight
                      headerHeight:CGFLOAT_MIN
                      footerHeight:CGFLOAT_MIN];
}
- (instancetype)initWithTableView:(UITableView *)tableView
                   cellIdentifier:(NSString *)cellIdentifier
                       cellHeight:(CGFloat)cellHeight
                     headerHeight:(CGFloat)headerHeight
                     footerHeight:(CGFloat)footerHeight {
    
    if (self = [super init]) {
        [self __setupTableView:tableView];
        self.cellIdentifier = cellIdentifier;
        self.cellHeight = cellHeight;
        self.headerHeight = headerHeight ? headerHeight : CGFLOAT_MIN;
        self.footerHeight = footerHeight ? footerHeight : CGFLOAT_MIN;
    }
    return self;
    
}
#pragma mark - Private Methods

- (void)__setupTableView:(UITableView *)tableView {
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - Public Methods

- (void)kk_registerCellClass:(NSArray<NSString *> *)cellClass sectionHeaderFooterViewClass:(NSArray<NSString *> *)sectionViewClass {
    
    [cellClass enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.tableView registerClass:[NSClassFromString(obj) class] forCellReuseIdentifier:obj];
    }];
    [sectionViewClass enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.tableView registerClass:[NSClassFromString(obj) class] forHeaderFooterViewReuseIdentifier:obj];
    }];
}

- (void)kk_registerCellNib:(NSArray<NSString *> *)cellClass sectionHeaderFooterViewNib:(NSArray<NSString *> *)sectionViewClass {
    
    [cellClass enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.tableView registerNib:[UINib nibWithNibName:obj bundle:nil] forCellReuseIdentifier:obj];
    }];
    [sectionViewClass enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.tableView registerNib:[UINib nibWithNibName:obj bundle:nil] forHeaderFooterViewReuseIdentifier:obj];
    }];
}
- (void)kk_refresh:(NSArray<KKDataSourceModel *> *)data {
    
    self.datas = data.mutableCopy;
    [self.tableView reloadData];
    
}
- (void)kk_singleRefresh:(NSArray *)data {
    
    self.items = data.mutableCopy;
    [self.tableView reloadData];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.items.count) {
        return 1;
    }
    return self.datas.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.items.count) {
        return self.items.count;
    }
    KKDataSourceModel *model = self.datas[section];
    return model.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.items.count == 0) {
        KKDataSourceModel *model = self.datas[indexPath.section];
        KKCellItem *cellItem = model.datas[indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellItem.cellIdentifier forIndexPath:indexPath];
        if ([cell respondsToSelector:@selector(kk_configData:)]) {
            [(id<KKDataSource>)cell kk_configData:cellItem.data];
        }
        return cell;
    }
    // 单区
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(kk_configData:)]) {
        [(id<KKDataSource>)cell kk_configData:self.items[indexPath.row]];
    }
    return cell;

}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.items.count && self.didSelectBlock) {
        self.didSelectBlock(self.items[indexPath.row], indexPath);
        return;
    }
    KKDataSourceModel *model = self.datas[indexPath.section];
    KKCellItem *cellItem = model.datas[indexPath.row];
    if (self.didSelectBlock) {
        self.didSelectBlock(cellItem.data, indexPath);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.cellHeight) {
        return self.cellHeight;
    }
    
    KKDataSourceModel *model = self.datas[indexPath.section];
    KKCellItem *item = model.datas[indexPath.row];
    return [item.cellHeight floatValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (self.items.count && self.headerHeight) {
        return self.headerHeight;
    }
    KKDataSourceModel *model = self.datas[section];
    KKSectionHeaderFooterItem *item = model.headerItem;
    return item ? [item.height floatValue] : CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    
    if (self.items.count && self.footerHeight) {
        return self.footerHeight;
    }
    KKDataSourceModel *model = self.datas[section];
    KKSectionHeaderFooterItem *item = model.footerItem;
    return item ? [item.height floatValue] : CGFLOAT_MIN;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (self.items.count) {
        if (self.sectionHeader) {
            return self.sectionHeader(tableView, section);
        }
        return nil;
    }
    
    KKSectionHeaderFooterItem *item = self.datas[section].headerItem;
    if (item.identifier.length) {
        UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:item.identifier];
        if ([header respondsToSelector:@selector(kk_configData:)]) {
            [(id <KKDataSource>)header kk_configData:item.data];
        }
        return header;
    } else {
        return nil;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (self.items.count) {
        if (self.sectionFooter) {
            return self.sectionFooter(tableView, section);
        }
        return nil;
    }
    
    KKSectionHeaderFooterItem *item = self.datas[section].footerItem;
    if (item.identifier.length) {
        UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:item.identifier];
        if ([footer respondsToSelector:@selector(kk_configData:)]) {
            [(id <KKDataSource>)footer kk_configData:item.data];
        }
        return footer;
    } else {
        return nil;
    }
}



@end
