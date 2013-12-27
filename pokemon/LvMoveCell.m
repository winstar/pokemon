//
//  LvMoveCell.m
//  pokemon
//
//  Created by 王建平 on 13-7-9.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "LvMoveCell.h"
#import "PMTypeColor.h"

@implementation LvMoveCell {
    UILabel *levelLabel;
    UILabel *nameLabel;
    UILabel *propertyLabel;
    UILabel *categoryLabel;
    UILabel *powerLabel;
    UILabel *hitRateLabel;
    UILabel *ppLabel;
    PMTypeColor *pmTypeColor;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        pmTypeColor = [PMTypeColor shareInstance];
        self.backgroundColor = [UIColor clearColor];
        UIFont *font = [UIFont systemFontOfSize:13];
        UIColor *notBlack = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
        levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 4, 30, 20)];
        levelLabel.font = font;
        levelLabel.textColor = notBlack;
        levelLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:levelLabel];
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(52, 4, 78, 20)];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font = font;
        nameLabel.textColor = notBlack;
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        propertyLabel = [[UILabel alloc] initWithFrame:CGRectMake(132, 4, 30, 20)];
        propertyLabel.font = font;
        propertyLabel.textAlignment = NSTextAlignmentCenter;
        propertyLabel.textColor = [UIColor whiteColor];
        [self addSubview:propertyLabel];
        categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(164, 4, 40, 20)];
        categoryLabel.textColor = [UIColor whiteColor];
        categoryLabel.textAlignment = NSTextAlignmentCenter;
        categoryLabel.font = font;
        [self addSubview:categoryLabel];
        powerLabel = [[UILabel alloc] initWithFrame:CGRectMake(206, 4, 30, 20)];
        powerLabel.textAlignment = NSTextAlignmentCenter;
        powerLabel.textColor = notBlack;
        powerLabel.backgroundColor = [UIColor clearColor];
        powerLabel.font = font;
        [self addSubview:powerLabel];
        hitRateLabel = [[UILabel alloc] initWithFrame:CGRectMake(238, 4, 40, 20)];
        hitRateLabel.textAlignment = NSTextAlignmentCenter;
        hitRateLabel.font = font;
        hitRateLabel.textColor = notBlack;
        hitRateLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:hitRateLabel];
        ppLabel = [[UILabel alloc] initWithFrame:CGRectMake(280, 4, 30, 20)];
        ppLabel.textAlignment = NSTextAlignmentCenter;
        ppLabel.textColor = notBlack;
        ppLabel.backgroundColor = [UIColor clearColor];
        ppLabel.font = font;
        [self addSubview:ppLabel];
    }
    return self;
}

- (void)setLvMove:(LvMove *)move
{
    NSString *leveStr = @"基础";
    if (move.level > 0) {
        if (move.level < 100) {
            leveStr = [NSString stringWithFormat:@"Lv%02d", move.level];
        } else {
            leveStr = [NSString stringWithFormat:@"Lv%d", move.level];
        }
    }
    levelLabel.text = leveStr;
    nameLabel.text = move.name;
    propertyLabel.text = [pmTypeColor getTypeName:move.property];
    propertyLabel.backgroundColor = [pmTypeColor getTypeColor:move.property];
    categoryLabel.text = [pmTypeColor getCategoryName:move.category];
    categoryLabel.backgroundColor = [pmTypeColor getCategoryColor:move.category];
    if (move.power == -1) {
        powerLabel.text = @"变化";
    } else if (move.power == 0) {
        powerLabel.text = @"－";
    } else {
        powerLabel.text = [NSString stringWithFormat:@"%d", move.power];
    }
    if (move.hitRate == 0) {
        hitRateLabel.text = @"－";
    } else {
        hitRateLabel.text = [NSString stringWithFormat:@"%d", move.hitRate];
    }
    ppLabel.text = [NSString stringWithFormat:@"%d", move.pp];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
