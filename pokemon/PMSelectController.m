//
//  PMSelectController.m
//  pokemon
//
//  Created by 王建平 on 13-7-13.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "PMSelectController.h"
#import "SqliteHelper.h"
#import "PMTableCell.h"
#import "PMTypeColor.h"

@interface PMSelectController ()

@end

@implementation PMSelectController {
    NSMutableArray *pokemons;
    PMTypeColor *pmTypeColor;
    NSArray *searchPokemons;
}

@synthesize pmListTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    pmTypeColor = [PMTypeColor shareInstance];
    pokemons = [[SqliteHelper sharedHelper] getAllPokemon:@"SELECT * FROM Pokemon" withIndex:0];
    NSLog(@"Count:%d", pokemons.count);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView != pmListTableView) {
        return [searchPokemons count];
    } else {
        return [pokemons count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PokemonCell";
    PMTableCell *cell = [pmListTableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = (PMTableCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    PMCell *pm;
    if (tableView != pmListTableView) {
        pm = (PMCell *)[searchPokemons objectAtIndex:indexPath.row];
    } else {
        pm = (PMCell *)[pokemons objectAtIndex:indexPath.row];
    }
    
    NSString *naturalNum = [NSString stringWithFormat:@"%03d", pm.natural];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PMCell *pm;
    if (self.searchDisplayController.isActive) {
        NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        pm  = (PMCell *)[searchPokemons objectAtIndex:indexPath.row];
    } else {
        NSIndexPath *indexPath = [self.pmListTableView indexPathForSelectedRow];
        pm = (PMCell *)[pokemons objectAtIndex:indexPath.row];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectPM" object:[NSNumber numberWithInt:pm.id]];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSPredicate *_predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[0-9]+"];
    if ([_predicate evaluateWithObject:searchString]) {
        //匹配编号
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id==%d", [searchString intValue]];
        searchPokemons = [pokemons filteredArrayUsingPredicate:predicate];
    } else {
        //匹配名称
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[cd] %@", searchString];
        searchPokemons = [pokemons filteredArrayUsingPredicate:predicate];
    }
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    return YES;
}

- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
}

- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
}

@end
