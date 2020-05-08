//
//  KKTableViewCell.m
//  KKTableViewDataSource
//
//  Created by zainguo on 2020/5/8.
//  Copyright © 2020 zainguo. All rights reserved.
//

#import "KKTableViewCell.h"

@implementation KKTableViewCell

- (void)kk_configData:(id)data {
    
    self.textLabel.text = data;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
