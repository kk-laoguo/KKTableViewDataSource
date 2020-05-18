//
//  KKTableViewDataSource.h
//  KKTableViewDataSource
//
//  Created by zainguo on 2020/5/7.
//  Copyright © 2020 zainguo. All rights reserved.
//

#import <UIKit/UIKit.h>


@class KKDataSourceModel;

#pragma mark - 不使用KKDataSourceModel来设置数据源

typedef void(^DidSelectCellBlock)(id data, NSIndexPath *indexPath);
typedef void(^ScrollViewDidScrollBlock)(UIScrollView *scrollView);

typedef UIView *(^SectionHeaderViewBlock)(UITableView *tableView, NSInteger section);
typedef UIView *(^SectionFooterViewBlock)(UITableView *tableView, NSInteger section);


@interface KKTableViewDataSource : NSObject

@property (nonatomic, copy) DidSelectCellBlock didSelectBlock;
@property (nonatomic, copy) SectionHeaderViewBlock sectionHeader;
@property (nonatomic, copy) SectionFooterViewBlock sectionFooter;
@property (nonatomic, copy) ScrollViewDidScrollBlock scrollViewDidScroll;

#pragma mark - identifier必须和注册的类名一致


/// 初始化 结合 KKDataSourceModel 使用
/// @param tableView tableView
- (instancetype)initWithTableView:(UITableView *)tableView;

/// 初始化
/// @param tableView tableView
/// @param cellIdentifier 重用标识符
/// @param cellHeight 行高
- (instancetype)initWithTableView:(UITableView *)tableView
                   cellIdentifier:(NSString *)cellIdentifier
                       cellHeight:(CGFloat)cellHeight;

/// 初始化
/// @param tableView tableView
/// @param cellIdentifier 重用标识符
/// @param cellHeight 行高
/// @param headerHeight 区头高度
/// @param footerHeight 区尾高度
- (instancetype)initWithTableView:(UITableView *)tableView
                   cellIdentifier:(NSString *)cellIdentifier
                       cellHeight:(CGFloat)cellHeight
                     headerHeight:(CGFloat)headerHeight
                     footerHeight:(CGFloat)footerHeight;

/// 注册纯代码Cell 和 sectionHeaderFooterView
/// @param cellClass Cell数组
/// @param sectionViewClass sectionViewClass 数组
- (void)kk_registerCellClass:(NSArray<NSString *> *)cellClass
            sectionHeaderFooterViewClass:(NSArray<NSString *> *)sectionViewClass;


/// 注册XIB创建的 Cell 和 sectionHeaderFooterView
/// @param cellClass Cell 数组
/// @param sectionViewClass sectionViewClass 数组
- (void)kk_registerCellNib:(NSArray<NSString *> *)cellClass
sectionHeaderFooterViewNib:(NSArray<NSString *> *)sectionViewClass;

/// 刷新tableView
/// @param data 数据源
- (void)kk_refresh:(NSArray<KKDataSourceModel *> *)data;

/// 刷新tableView
/// @param data 数据源
- (void)kk_singleRefresh:(NSArray *)data;

@end

