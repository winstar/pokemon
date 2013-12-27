//
//  TestCell.m
//  pokemon
//
//  Created by 王建平 on 13-7-10.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "TestCell.h"

@implementation TestCell

@synthesize nameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
