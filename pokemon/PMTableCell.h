//
//  PMTableCell.h
//  pokemon
//
//  Created by 白彝澄源 on 13-6-22.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *idLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *type1Label;
@property (nonatomic, weak) IBOutlet UILabel *type2Label;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end
