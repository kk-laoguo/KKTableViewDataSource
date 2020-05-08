//
//  KKDataSourceModel.h
//  KKTableViewDataSource
//
//  Created by zainguo on 2020/5/7.
//  Copyright © 2020 zainguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KKDataSource <NSObject>

@optional
- (void)kk_configData:(id)data;
@end



@interface KKSectionHeaderFooterItem : NSObject

@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) id data;
@property (nonatomic, strong) NSNumber *height;

- (instancetype)initWithSectionHeaderClass:(NSString *)cellClass;
- (void)kk_fillSectionHeaderFooterViewData:(id)data;

@end

@interface KKCellItem : NSObject

@property (nonatomic, copy, readonly) NSString * cellIdentifier;
@property (nonatomic, strong, readonly) id data;
@property (nonatomic, strong) NSNumber *cellHeight;

- (instancetype)initWithCellClass:(NSString *)cellClass;
- (void)kk_fillCellData:(id)data;

@end


@interface KKDataSourceModel : NSObject

@property (nonatomic, strong) KKSectionHeaderFooterItem *headerItem;
@property (nonatomic, strong) KKSectionHeaderFooterItem *footerItem;
@property (nonatomic, strong) NSMutableArray<KKCellItem *> *datas;

@end




