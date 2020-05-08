//
//  SectionHeaderView.m
//  KKTableViewDataSource
//
//  Created by zainguo on 2020/5/8.
//  Copyright © 2020 zainguo. All rights reserved.
//

#import "SectionHeaderView.h"

@implementation SectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor cyanColor];
    }
    return self;
}

- (void)kk_configData:(id)data {
    
    self.textLabel.text = data;
}


@end
