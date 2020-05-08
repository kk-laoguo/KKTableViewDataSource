//
//  KKNextTableViewCell.m
//  KKTableViewDataSource
//
//  Created by zainguo on 2020/5/8.
//  Copyright © 2020 zainguo. All rights reserved.
//

#import "KKNextTableViewCell.h"

#import "Person.h"
@implementation KKNextTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
    
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
