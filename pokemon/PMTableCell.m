//
//  PMTableCell.m
//  pokemon
//
//  Created by 白彝澄源 on 13-6-22.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "PMTableCell.h"

@implementation PMTableCell

@synthesize idLabel;
@synthesize nameLabel;
@synthesize type1Label;
@synthesize type2Label;
@synthesize imageView;

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
