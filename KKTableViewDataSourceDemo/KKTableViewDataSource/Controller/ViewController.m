//
//  ViewController.m
//  KKTableViewDataSource
//
//  Created by zainguo on 2020/5/7.
//  Copyright © 2020 zainguo. All rights reserved.
//

#import "ViewController.h"

#import "KKDataSourceHeader.h"

#import "SectionFooterView.h"

#import "SectionHeaderView.h"



@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) KKTableViewDataSource *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    
    self.dataSource = [[KKTableViewDataSource alloc] initWithTableView:self.tableView
                                                        cellIdentifier:@"KKTableViewCell"
                                                            cellHeight:50
                                                          headerHeight:100
                                                          footerHeight:100];
    
    [self.dataSource kk_registerCellClass:@[@"KKTableViewCell"] sectionHeaderFooterViewClass:@[@"SectionFooterView", @"SectionHeaderView"]];
    
    
    NSArray *arr = @[@"不使用KKDataSourceModel来设置数据源",
                     @"不使用KKDataSourceModel来设置数据源",
                     @"不使用KKDataSourceModel来设置数据源",
                     @"不使用KKDataSourceModel来设置数据源",
                     @"不使用KKDataSourceModel来设置数据源"];
    
    // 设置区头视图
    self.dataSource.sectionHeader = ^UIView *(UITableView *tableView, NSInteger section) {
        SectionHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SectionHeaderView"];
        header.textLabel.text = @"SectionHeaderView";
        return header;

    };
    // 设置区尾视图
    self.dataSource.sectionFooter = ^UIView *(UITableView *tableView, NSInteger section) {
        SectionFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SectionFooterView"];
        footer.textLabel.text = @"SectionFooterView";

        return footer;
    };
    // cell点击事件
    __weak typeof(self) weakSelf = self;
    self.dataSource.didSelectBlock = ^(id data, NSIndexPath *indexPath) {
        [weakSelf.navigationController pushViewController:[NSClassFromString(@"NextViewController") new] animated:YES];
    };
    
    self.dataSource.scrollViewDidScroll = ^(UIScrollView *scrollView) {
        
        if (scrollView.contentOffset.y <= -100) {
            scrollView.contentOffset = CGPointMake(0, -100);
        }
        
    };
    
    
    // 刷新数据源
    [self.dataSource kk_singleRefresh:arr];
    
}


@end
