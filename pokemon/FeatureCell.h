//
//  FeatureCell.h
//  pokemon
//
//  Created by 王建平 on 13-9-14.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeatureCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *idLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *describeLabel;

@end
