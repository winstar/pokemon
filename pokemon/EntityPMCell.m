//
//  EntityPMCell.m
//  pokemon
//
//  Created by 王建平 on 13-7-13.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "EntityPMCell.h"

@implementation EntityPMCell

@synthesize idLabel;
@synthesize nameLabel;
@synthesize pmImageView;

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
