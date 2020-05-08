//
//  KKDataSourceModel.m
//  KKTableViewDataSource
//
//  Created by zainguo on 2020/5/7.
//  Copyright © 2020 zainguo. All rights reserved.
//

#import "KKDataSourceModel.h"

@interface KKSectionHeaderFooterItem ()

@property (nonatomic, copy, readwrite) NSString *identifier;
@property (nonatomic, strong, readwrite) id data;

@end

@implementation KKSectionHeaderFooterItem

- (instancetype)initWithSectionHeaderClass:(NSString *)cellClass {
    
    if (self = [super init]) {
        _identifier = [cellClass copy];
    }
    return self;
}
- (void)kk_fillSectionHeaderFooterViewData:(id)data {
    _data = data;
}

@end




@interface KKCellItem ()
@property (nonatomic, copy, readwrite) NSString * cellIdentifier;
@property (nonatomic, strong, readwrite) id data;

@end




@implementation KKCellItem

- (instancetype)initWithCellClass:(NSString *)cellClass {
    if (self = [super init]) {
        _cellIdentifier = [cellClass copy];
    }
    return self;
}

- (void)kk_fillCellData:(id)data {
    _data = data;
}

@end




@implementation KKDataSourceModel

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}


@end
