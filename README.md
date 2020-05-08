# KKTableViewDataSource
解耦`tableView`的数据源方法和代理方法，不再需要每次都设置代理和数据源方法。`KKTableViewDataSource`可以帮助我们管理`tableView`的代理方法、数据源方法。


### 特性
- 支持单个`Cell`、多个`Cell`
- 支持多区设置
- 支持自定义行高、区头视图高度、区尾视图高度
- 支持模型数据源

### 使用

> 简单使用


```
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
    
    self.dataSource.sectionHeader = ^UIView *(UITableView *tableView, NSInteger section) {
        SectionHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SectionHeaderView"];
        header.textLabel.text = @"SectionHeaderView";
        return header;

    };
    // 设置区头视图
    self.dataSource.sectionFooter = ^UIView *(UITableView *tableView, NSInteger section) {
        SectionFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SectionFooterView"];
        footer.textLabel.text = @"SectionFooterView";

        return footer;
    };
    // 设置区尾视图
    __weak typeof(self) weakSelf = self;
    self.dataSource.didSelectBlock = ^(id data, NSIndexPath *indexPath) {
        [weakSelf.navigationController pushViewController:[NSClassFromString(@"NextViewController") new] animated:YES];
    };
    // 刷新数据源
    [self.dataSource kk_singleRefresh:arr];    
```    


![效果图](https://gitee.com/Tangchi/ZainPhotoCloud/raw/master/blogimage/20200508153452.png)


> 使用`KKTableViewDataSource`来设置数据源

```
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
```

![效果图](https://gitee.com/Tangchi/ZainPhotoCloud/raw/master/blogimage/20200508162303.png)