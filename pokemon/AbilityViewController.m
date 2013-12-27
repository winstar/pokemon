//
//  AbilityViewController.m
//  pokemon
//
//  Created by 王建平 on 13-7-11.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "AbilityViewController.h"
#import "NVSlideMenuController.h"
#import "SqliteHelper.h"
#import "Feature.h"
#import "FeatureCell.h"
#import "PMClassViewController.h"

@interface AbilityViewController ()

@end

@implementation AbilityViewController {
    NSMutableArray *features;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonSystemItemAction target:self.slideMenuController action:@selector(toggleMenuAnimated:)];
    features = [[SqliteHelper sharedHelper] getAllFeature];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return features.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"FeatureCell";
    
    FeatureCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[FeatureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Feature *feature = (Feature *)[features objectAtIndex:indexPath.row];
    NSString *idStr = [NSString stringWithFormat:@"%03d", feature.ID];
    NSString *nameStr = [NSString stringWithFormat:@"%@", feature.name];
    NSString *describeStr = [NSString stringWithFormat:@"%@", feature.describe];
    
    cell.idLabel.text = idStr;
    cell.nameLabel.text = nameStr;
    cell.describeLabel.text = describeStr;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.abilityTableView indexPathForSelectedRow];
    Feature *feature = [features objectAtIndex:indexPath.row];
    PMClassViewController *destViewController = segue.destinationViewController;
    destViewController.ID = feature.ID;
    [destViewController setTitle:feature.name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
