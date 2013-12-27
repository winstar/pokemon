//
//  SqliteHelper.h
//  pokemon
//
//  Created by 白彝澄源 on 13-6-21.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "PMCell.h"
#import "Pokemon.h"
#import "Property.h"
#import "Evolution.h"
#import "LvMove.h"
#import "Move.h"
#import "Feature.h"

@interface SqliteHelper : NSObject {
    sqlite3 *database;
}

+ (SqliteHelper *)sharedHelper;
- (void)createEditableCopyOfDatabaseIfNeeded;
- (void)openDatabase;
- (NSMutableArray *)getPokemon:(int)id;
- (NSMutableArray *)getAllPokemon:(NSString *)sqlQuery withIndex:(int)index;
- (NSMutableArray *)getProperty:(int)id;
- (NSMutableArray *)getEvolution:(int)id;
- (NSMutableArray *)getPokemons:(NSString *)ids;
- (NSMutableArray *)getPokemonsByMoveID:(int)id;
- (NSMutableArray *)getLvMove:(int)id;
- (NSMutableArray *)getLvMoveArray;
- (NSMutableArray *)getAllFeature;
- (NSMutableArray *)getPMByFeature:(int)id;
- (NSMutableArray *)getPMByEggId:(int)id;

- (void)closeDatabase;
@end
