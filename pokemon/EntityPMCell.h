//
//  EntityPMCell.h
//  pokemon
//
//  Created by 王建平 on 13-7-13.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntityPMCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *idLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *pmImageView;

@end
