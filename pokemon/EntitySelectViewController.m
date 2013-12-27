//
//  EntitySelectViewController.m
//  pokemon
//
//  Created by 王建平 on 13-7-14.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "EntitySelectViewController.h"
#import "Globle.h"

@interface EntitySelectViewController ()

@end

@implementation EntitySelectViewController {
    NSArray *nuliArrray;
    NSArray *natureArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"initWithNibName");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    nuliArrray = [[Globle shareInstance] getNuLiArray];
    natureArray = [[Globle shareInstance] getNatureArray];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.index == 2) {
        return nuliArrray.count;
    } else if (self.index == 1) {
        return natureArray.count;
    } else if (self.index == 0) {
        return 100;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SelectCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if (self.index == 2) {
        cell.textLabel.text = [nuliArrray objectAtIndex:indexPath.row];
    } else if (self.index == 1) {
        cell.textLabel.text = [natureArray objectAtIndex:indexPath.row];
    } else if (self.index == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
    }
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.index == 2) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectNuli" object:[nuliArrray objectAtIndex:indexPath.row]];
    } else if (self.index == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectNature" object:[natureArray objectAtIndex:indexPath.row]];
    } else if (self.index == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectLevel" object:[NSString stringWithFormat:@"%d", indexPath.row + 1]];
    }
    return indexPath;
}

@end
