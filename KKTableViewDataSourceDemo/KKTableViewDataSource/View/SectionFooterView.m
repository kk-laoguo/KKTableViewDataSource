//
//  SectionFooterView.m
//  KKTableViewDataSource
//
//  Created by zainguo on 2020/5/8.
//  Copyright © 2020 zainguo. All rights reserved.
//

#import "SectionFooterView.h"

@implementation SectionFooterView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor magentaColor];
    }
    return self;
}
- (void)kk_configData:(id)data {
    self.textLabel.text = data;
}
@end
