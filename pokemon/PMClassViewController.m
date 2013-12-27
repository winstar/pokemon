//
//  PMClassViewController.m
//  pokemon
//
//  Created by 王建平 on 13-9-14.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "PMClassViewController.h"
#import "PMTableCell.h"
#import "PMCell.h"
#import "PMTypeColor.h"
#import "SqliteHelper.h"
#import "PokemonInfoViewController.h"
#import "NVSlideMenuController.h"

@implementation PMClassViewController {
    NSMutableArray *pmArray;
    PMTypeColor *pmTypeColor;
}

@synthesize ID;
@synthesize category;
@synthesize FromPM;

- (void)viewDidLoad
{
    [super viewDidLoad];
    pmTypeColor = [PMTypeColor shareInstance];
    NSLog(@"》》》%d", ID);
    if (category == 0) {
        pmArray = [[SqliteHelper sharedHelper] getPMByFeature:ID];
    } else {
        pmArray = [[SqliteHelper sharedHelper] getPMByEggId:ID];
    }
    
    if (FromPM == 1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonSystemItemAction target:self.slideMenuController action:@selector(toggleMenuAnimated:)];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return pmArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"PokemonCell";
    
    PMTableCell *cell = (PMTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = (PMTableCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    PMCell *pm = (PMCell *)[pmArray objectAtIndex:indexPath.row];
    
    NSString *naturalNum = [NSString stringWithFormat:@"%03d", pm.id];
    cell.idLabel.text = naturalNum;
    cell.nameLabel.text = pm.name;
    cell.imageView.image = [UIImage imageNamed:naturalNum];
    cell.imageView.layer.cornerRadius = 20;
    cell.imageView.backgroundColor = [UIColor grayColor];
    if (pm.type1 != 0) {
        cell.type1Label.text = [pmTypeColor getTypeName:pm.type1];
        UIColor *color = [pmTypeColor getTypeColor:pm.type1];
        cell.type1Label.backgroundColor = color;
        cell.type1Label.highlightedTextColor = color;
    } else {
        cell.type1Label.text = @"";
        cell.type1Label.backgroundColor = [UIColor clearColor];
    }
    if (pm.type2 != 0) {
        cell.type2Label.text = [pmTypeColor getTypeName:pm.type2];
        UIColor *color = [pmTypeColor getTypeColor:pm.type2];
        cell.type2Label.backgroundColor = color;
        cell.type2Label.highlightedTextColor = color;
    } else {
        cell.type2Label.text = @"";
        cell.type2Label.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PokemonInfoViewController *destViewController = segue.destinationViewController;
    NSIndexPath *indexPath = [self.PMTableView indexPathForSelectedRow];
    PMCell *pm = (PMCell *)[pmArray objectAtIndex:indexPath.row];
    destViewController.pokemonId = pm.id;
    destViewController.pokemonName = pm.name;
    destViewController.pokemonType = pm.type1;
    [destViewController setTitle:pm.name];
    self.slideMenuController.panGestureEnabled = NO;
}

@end
