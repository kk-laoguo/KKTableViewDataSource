//
//  KKNextOtherTableViewCell.m
//  KKTableViewDataSource
//
//  Created by zainguo on 2020/5/8.
//  Copyright © 2020 zainguo. All rights reserved.
//

#import "KKNextOtherTableViewCell.h"
#import "Person.h"

@implementation KKNextOtherTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor grayColor];
    }
    return self;
}
- (void)kk_configData:(id)data {
    Person *p = data;
    self.textLabel.text = p.name;
    self.detailTextLabel.text = [NSString stringWithFormat:@"年龄: %zd", p.age];
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
