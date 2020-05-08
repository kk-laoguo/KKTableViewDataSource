//
//  NextViewController.m
//  KKTableViewDataSource
//
//  Created by zainguo on 2020/5/8.
//  Copyright © 2020 zainguo. All rights reserved.
//

#import "NextViewController.h"


#import "Person.h"

#import "KKDataSourceHeader.h"
#import "SectionFooterView.h"
#import "SectionHeaderView.h"

@interface NextViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) KKTableViewDataSource *dataSource;

@end

@implementation NextViewController

- (void)dealloc {
    NSLog(@"------>%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self __setupTableView];
    [self __setupDataSource];
}

- (void)__setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
}

- (void)__setupDataSource {
    
    self.dataSource = [[KKTableViewDataSource alloc] initWithTableView:self.tableView];
    
    [self.dataSource kk_registerCellClass:@[@"KKNextTableViewCell", @"KKNextOtherTableViewCell"] sectionHeaderFooterViewClass:@[@"SectionHeaderView", @"SectionFooterView"]];
    
    
    NSMutableArray *arr = [NSMutableArray array];
    
    KKDataSourceModel *model = [[KKDataSourceModel alloc] init];
    
    KKSectionHeaderFooterItem *headerItem = [[KKSectionHeaderFooterItem alloc] initWithSectionHeaderClass:@"SectionHeaderView"];
    headerItem.height = @(50);
    [headerItem kk_fillSectionHeaderFooterViewData:@"SectionHeaderView"];
    
    KKSectionHeaderFooterItem *footerItem = [[KKSectionHeaderFooterItem alloc] initWithSectionHeaderClass:@"SectionFooterView"];
     footerItem.height = @(100);
     [footerItem kk_fillSectionHeaderFooterViewData:@"SectionFooterView"];
    
    // 设置区头区尾
    model.headerItem = headerItem;
    model.footerItem = footerItem;
    
    // 设置cell数据源
    for (NSInteger i = 0; i < 10; i ++) {
        KKCellItem *itemOne = [[KKCellItem alloc] initWithCellClass: i % 2 == 0 ? @"KKNextTableViewCell": @"KKNextOtherTableViewCell"];
        
        Person *p = [[Person alloc] init];
        p.name = [NSString stringWithFormat:@"使用KKDataSourceModel来设置数据源%02zd", i];
        p.age = arc4random() % 30;
        [itemOne kk_fillCellData:p];
        
        itemOne.cellHeight = i % 2 == 0 ? @(40):@(80);
        [model.datas addObject:itemOne];
    }
    [arr addObject: model];

    // 第二区
    KKDataSourceModel *modelTwo = [[KKDataSourceModel alloc] init];
    // 设置区头区尾
    modelTwo.headerItem = headerItem;
    modelTwo.footerItem = footerItem;

    for (NSInteger i = 0; i < 10; i ++) {
          KKCellItem *itemTwo = [[KKCellItem alloc] initWithCellClass:@"KKNextTableViewCell"];

          Person *p = [[Person alloc] init];
          p.name = [NSString stringWithFormat:@"第二区使用KKDataSourceModel来设置数据源%02zd", i];
          p.age = arc4random() % 10 + 10;
          itemTwo.cellHeight = i % 2 == 0 ? @(50):@(100);
          [itemTwo kk_fillCellData:p];
          [modelTwo.datas addObject:itemTwo];
    }
    [arr addObject:modelTwo];
    
    [self.dataSource kk_refresh:arr];
    
}



@end
