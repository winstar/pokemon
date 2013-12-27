//
//  MoveCell.h
//  pokemon
//
//  Created by 王建平 on 13-7-22.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoveCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *idLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *propertyLabel;
@property (nonatomic, weak) IBOutlet UILabel *categoryLabel;

@end
