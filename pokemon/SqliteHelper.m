//
//  SqliteHelper.m
//  pokemon
//
//  Created by 白彝澄源 on 13-6-21.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "SqliteHelper.h"

static SqliteHelper *sharedHelper = nil;

@implementation SqliteHelper

+ (SqliteHelper *)sharedHelper
{
    @synchronized(self)
    {
        if (sharedHelper == nil) {
            sharedHelper = [[SqliteHelper alloc] init];
        }
    }
    return sharedHelper;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self)
    {
        if (sharedHelper == nil) {
            sharedHelper = [super allocWithZone:zone];
            return sharedHelper;
        }
    }
    return nil;
}

- (void)createEditableCopyOfDatabaseIfNeeded {
    
    NSString *dbFileName = @"data.sqlite";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:dbFileName];
    
    BOOL success = [fileManager fileExistsAtPath:writableDBPath];
    if (success){
        NSLog(@"数据库存在");
        return;
    }
    
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbFileName];
    [fileManager removeItemAtPath:writableDBPath error:NULL];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:NULL];
    if (success) {
        NSLog(@"createEditableCopyOfDatabaseIfNeeded 初始化成功");
    } else {
        NSLog(@"Fail");
    }
}

- (void)openDatabase
{
    NSArray *documentsPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *databaseFilePath = [[documentsPaths objectAtIndex:0] stringByAppendingPathComponent:@"data.sqlite"];

    if (sqlite3_open([databaseFilePath UTF8String], &database) == SQLITE_OK) {
        //NSLog(@"SQLites is opened.");
    } else {
        NSLog(@"SQLites open Error.");
    }
}

- (NSMutableArray *)getPokemon:(int)id {
    sqlite3_stmt * statement;
    NSMutableArray *pmList;
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM Pokemon where Index_National=%d", id];
    [self openDatabase];
    if (sqlite3_prepare_v2(database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        pmList = [NSMutableArray arrayWithCapacity:1];

        while (sqlite3_step(statement) == SQLITE_ROW) {
            int id = sqlite3_column_int(statement, 0);
            Pokemon *cell = [[Pokemon alloc] init];
            cell.id = id;
            cell.natural = id;
            cell.shapeID = sqlite3_column_int(statement, 1);
            cell.kanto = sqlite3_column_int(statement, 2);
            cell.johto = sqlite3_column_int(statement, 3);
            cell.hoenn = sqlite3_column_int(statement, 4);
            cell.sinnoh = sqlite3_column_int(statement, 5);
            cell.unova = sqlite3_column_int(statement, 6);
            char *name = (char*)sqlite3_column_text(statement, 7);
            cell.name = [[NSString alloc] initWithUTF8String:name];
            char *shape = (char*)sqlite3_column_text(statement, 8);
            cell.shape = [[NSString alloc] initWithUTF8String:shape];
            cell.type1 = sqlite3_column_int(statement, 9);
            cell.type2 = sqlite3_column_int(statement, 10);
            cell.ability1ID = sqlite3_column_int(statement, 11);
            char *ability1Name = (char*)sqlite3_column_text(statement, 12);
            cell.ability1Name = [[NSString alloc] initWithUTF8String:ability1Name];
            cell.ability2ID = sqlite3_column_int(statement, 13);
            char *ability2Name = (char*)sqlite3_column_text(statement, 14);
            cell.ability2Name = [[NSString alloc] initWithUTF8String:ability2Name];
            cell.abilityHID = sqlite3_column_int(statement, 15);
            char *abilityHName = (char*)sqlite3_column_text(statement, 16);
            cell.abilityHName = [[NSString alloc] initWithUTF8String:abilityHName];
            cell.egg1ID = sqlite3_column_int(statement, 17);
            cell.egg2ID = sqlite3_column_int(statement, 18);
            cell.catchRate = sqlite3_column_int(statement, 19);
            cell.hatchStep = sqlite3_column_int(statement, 20);
            cell.bodyStyle = sqlite3_column_int(statement, 21);
            char *gender = (char*)sqlite3_column_text(statement, 22);
            cell.gender = [[NSString alloc] initWithUTF8String:gender];
            cell.color = sqlite3_column_int(statement, 23);
            char *height = (char*)sqlite3_column_text(statement, 24);
            cell.height = [[NSString alloc] initWithUTF8String:height];
            char *weight = (char*)sqlite3_column_text(statement, 25);
            cell.weight = [[NSString alloc] initWithUTF8String:weight];
            cell.exp = sqlite3_column_int(statement, 26);
            cell.baseHP = sqlite3_column_int(statement, 27);
            cell.baseAttack = sqlite3_column_int(statement, 28);
            cell.baseDefense = sqlite3_column_int(statement, 29);
            cell.baseSpAttack = sqlite3_column_int(statement, 30);
            cell.baseSpDefense = sqlite3_column_int(statement, 31);
            cell.baseSpeed = sqlite3_column_int(statement, 32);
            cell.evHP = sqlite3_column_int(statement, 33);
            cell.evAttack = sqlite3_column_int(statement, 34);
            cell.evDefense = sqlite3_column_int(statement, 35);
            cell.evSpAttack = sqlite3_column_int(statement, 36);
            cell.evSpDefense = sqlite3_column_int(statement, 37);
            cell.evSpeed = sqlite3_column_int(statement, 38);
            [pmList addObject:cell];
        }
    }
    [self closeDatabase];
    return pmList;
}

- (NSMutableArray *)getAllPokemon:(NSString *)sqlQuery withIndex:(int)index
{
    sqlite3_stmt * statement;
    NSMutableArray *pmList;
    
    [self openDatabase];
    if (sqlite3_prepare_v2(database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        pmList = [NSMutableArray arrayWithCapacity:649];
        NSMutableSet *pmIdSet = [NSMutableSet setWithCapacity:649];
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int id = sqlite3_column_int(statement, 0);
            NSNumber *ID = [NSNumber numberWithInt:id];
            if ([pmIdSet containsObject:ID]) {
                continue;
            } else {
                [pmIdSet addObject:ID];
            }
            PMCell *cell = [[PMCell alloc] init];
            cell.id = sqlite3_column_int(statement, index);
            cell.natural = id;
            cell.kanto = sqlite3_column_int(statement, 2);
            cell.johto = sqlite3_column_int(statement, 3);
            cell.hoenn = sqlite3_column_int(statement, 4);
            cell.sinnoh = sqlite3_column_int(statement, 5);
            cell.unova = sqlite3_column_int(statement, 6);
            char *name = (char*)sqlite3_column_text(statement, 7);
            cell.name = [[NSString alloc] initWithUTF8String:name];
            cell.type1 = sqlite3_column_int(statement, 9);
            cell.type2 = sqlite3_column_int(statement, 10);
            [pmList addObject:cell];
        }
    }
    [self closeDatabase];
    return pmList;
}

- (NSMutableArray *)getProperty:(int)id {
    
    sqlite3_stmt * statement;
    NSMutableArray *pmList;
    
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM Property where ID=%d", id];
    [self openDatabase];
    if (sqlite3_prepare_v2(database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        pmList = [NSMutableArray arrayWithCapacity:1];
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            Property *cell = [[Property alloc] init];
            cell.id = sqlite3_column_int(statement, 0);
            char *shape = (char*)sqlite3_column_text(statement, 1);
            cell.shape = [[NSString alloc] initWithUTF8String:shape];
            
            cell.type1 = sqlite3_column_int(statement, 2);
            cell.type2 = sqlite3_column_int(statement, 3);
            
            for (int i=4; i<21; i++) {
                [cell addProperty:sqlite3_column_int(statement, i)];
            }
            
            [pmList addObject:cell];
        }
    }
    [self closeDatabase];
    return pmList;
}

- (NSMutableArray *)getEvolution:(int)id
{
    [self openDatabase];
    NSMutableArray *pmList;
    sqlite3_stmt * statement;
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM Evolution WHERE (FromID in (SELECT FromID FROM Evolution WHERE FromID=%d OR ToID=%d) OR ToID in (SELECT ToID FROM Evolution WHERE FromID=%d OR ToID=%d) OR FromID in (SELECT ToID FROM Evolution WHERE FromID=%d OR ToID=%d) OR ToID in (SELECT FromID FROM Evolution WHERE FromID=%d OR ToID=%d)) AND IconID!=0 ORDER BY Level", id, id, id, id, id, id, id, id];
    
    if (sqlite3_prepare_v2(database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        pmList = [NSMutableArray arrayWithCapacity:2];
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            Evolution *cell = [[Evolution alloc] init];
            cell.fromId = sqlite3_column_int(statement, 0);
            cell.toId = sqlite3_column_int(statement, 1);
            char *method = (char*)sqlite3_column_text(statement, 2);
            cell.method = [[NSString alloc] initWithUTF8String:method]; 
            cell.level = sqlite3_column_int(statement, 3);
            cell.iconId = sqlite3_column_int(statement, 4);
            
            [pmList addObject:cell];
        }
    }
    [self closeDatabase];
    return pmList;
}

- (NSMutableArray *)getPokemons:(NSString *)ids
{
    sqlite3_stmt * statement;
    NSMutableArray *pmList;
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM Pokemon where Index_National in (%@)", ids];
    [self openDatabase];
    if (sqlite3_prepare_v2(database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        pmList = [NSMutableArray arrayWithCapacity:3];
        NSMutableSet *pmIdSet = [NSMutableSet setWithCapacity:1];
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int id = sqlite3_column_int(statement, 0);
            NSNumber *ID = [NSNumber numberWithInt:id];
            if ([pmIdSet containsObject:ID]) {
                continue;
            } else {
                [pmIdSet addObject:ID];
            }
            PMCell *cell = [[PMCell alloc] init];
            cell.id = id;
            char *name = (char*)sqlite3_column_text(statement, 7);
            cell.name = [[NSString alloc] initWithUTF8String:name];
            cell.type1 = sqlite3_column_int(statement, 9);
            cell.type2 = sqlite3_column_int(statement, 10);
            [pmList addObject:cell];
        }
    }
    [self closeDatabase];
    return pmList;
}

- (NSMutableArray *)getPokemonsByMoveID:(int)id
{
    sqlite3_stmt * statement;
    NSMutableArray *pmList;
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT Pokemon.* FROM LvMove, Pokemon WHERE LvMove.PMID = Pokemon.Index_National AND MoveID = %d", id];
    [self openDatabase];
    if (sqlite3_prepare_v2(database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        pmList = [NSMutableArray arrayWithCapacity:30];
        NSMutableSet *pmIdSet = [NSMutableSet setWithCapacity:1];
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int id = sqlite3_column_int(statement, 0);
            NSNumber *ID = [NSNumber numberWithInt:id];
            if ([pmIdSet containsObject:ID]) {
                continue;
            } else {
                [pmIdSet addObject:ID];
            }
            PMCell *cell = [[PMCell alloc] init];
            cell.id = id;
            char *name = (char*)sqlite3_column_text(statement, 7);
            cell.name = [[NSString alloc] initWithUTF8String:name];
            cell.type1 = sqlite3_column_int(statement, 9);
            cell.type2 = sqlite3_column_int(statement, 10);
            [pmList addObject:cell];
        }
    }
    [self closeDatabase];
    return pmList;
}

- (NSMutableArray *)getLvMove:(int)id
{
    sqlite3_stmt * statement;
    NSMutableArray *moveList;
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM LvMove where PMID=%d order by level", id];
    [self openDatabase];
    if (sqlite3_prepare_v2(database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        moveList = [NSMutableArray arrayWithCapacity:15];
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            LvMove *move = [[LvMove alloc] init];
            move.pmId = id;
            move.level = sqlite3_column_int(statement, 1);
            move.moveId = sqlite3_column_int(statement, 2);
            char *name = (char*)sqlite3_column_text(statement, 3);
            move.name = [[NSString alloc] initWithUTF8String:name];
            move.property = sqlite3_column_int(statement, 4);
            move.category = sqlite3_column_int(statement, 5);
            move.power = sqlite3_column_int(statement, 6);
            move.hitRate = sqlite3_column_int(statement, 7);
            move.pp = sqlite3_column_int(statement, 8);
            [moveList addObject:move];
        }
    }
    [self closeDatabase];
    return moveList;
}

- (NSMutableArray *)getLvMoveArray
{
    sqlite3_stmt * statement;
    NSMutableArray *moveList;
    NSString *sqlQuery = @"SELECT * FROM Move";
    [self openDatabase];
    if (sqlite3_prepare_v2(database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        moveList = [NSMutableArray arrayWithCapacity:15];
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            Move *move = [[Move alloc] init];
            move.ID = sqlite3_column_int(statement, 0);
            char *name = (char*)sqlite3_column_text(statement, 1);
            move.name = [[NSString alloc] initWithUTF8String:name];
            move.property = sqlite3_column_int(statement, 3);
            move.category = sqlite3_column_int(statement, 4);
            move.power = sqlite3_column_int(statement, 5);
            move.hitRate = sqlite3_column_int(statement, 6);
            move.pp = sqlite3_column_int(statement, 7);
            [moveList addObject:move];
        }
    }
    [self closeDatabase];
    return moveList;
}

- (NSMutableArray *)getAllFeature
{
    sqlite3_stmt * statement;
    NSMutableArray *featureList;
    NSString *sqlQuery = @"SELECT * FROM Feature";
    [self openDatabase];
    if (sqlite3_prepare_v2(database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        featureList = [NSMutableArray arrayWithCapacity:100];
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            Feature *feature = [[Feature alloc] init];
            feature.ID = sqlite3_column_int(statement, 0);
            char *name = (char*)sqlite3_column_text(statement, 1);
            char *enname = (char*)sqlite3_column_text(statement, 2);
            char *describe = (char*)sqlite3_column_text(statement, 3);
            feature.name = [[NSString alloc] initWithUTF8String:name];
            feature.enName = [[NSString alloc] initWithUTF8String:enname];
            feature.describe = [[NSString alloc] initWithUTF8String:describe];
            [featureList addObject:feature];
        }
    }
    [self closeDatabase];
    return featureList;
}

- (NSMutableArray *)getPMByFeature:(int)id
{
    sqlite3_stmt * statement;
    NSMutableArray *pmList;
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM Pokemon WHERE Ability_1_ID = %d OR Ability_2_ID = %d OR Ability_H_ID = %d", id, id, id];
    [self openDatabase];
    if (sqlite3_prepare_v2(database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        pmList = [NSMutableArray arrayWithCapacity:30];
        NSMutableSet *pmIdSet = [NSMutableSet setWithCapacity:1];
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int id = sqlite3_column_int(statement, 0);
            NSNumber *ID = [NSNumber numberWithInt:id];
            if ([pmIdSet containsObject:ID]) {
                continue;
            } else {
                [pmIdSet addObject:ID];
            }
            PMCell *cell = [[PMCell alloc] init];
            cell.id = id;
            char *name = (char*)sqlite3_column_text(statement, 7);
            cell.name = [[NSString alloc] initWithUTF8String:name];
            cell.type1 = sqlite3_column_int(statement, 9);
            cell.type2 = sqlite3_column_int(statement, 10);
            [pmList addObject:cell];
        }
    }
    [self closeDatabase];
    return pmList;
}

- (NSMutableArray *)getPMByEggId:(int)id
{
    sqlite3_stmt * statement;
    NSMutableArray *pmList;
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM Pokemon WHERE EggGroup_1_ID = %d OR EggGroup_2_ID = %d", id, id];
    [self openDatabase];
    if (sqlite3_prepare_v2(database, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        pmList = [NSMutableArray arrayWithCapacity:30];
        NSMutableSet *pmIdSet = [NSMutableSet setWithCapacity:1];
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int id = sqlite3_column_int(statement, 0);
            NSNumber *ID = [NSNumber numberWithInt:id];
            if ([pmIdSet containsObject:ID]) {
                continue;
            } else {
                [pmIdSet addObject:ID];
            }
            PMCell *cell = [[PMCell alloc] init];
            cell.id = id;
            char *name = (char*)sqlite3_column_text(statement, 7);
            cell.name = [[NSString alloc] initWithUTF8String:name];
            cell.type1 = sqlite3_column_int(statement, 9);
            cell.type2 = sqlite3_column_int(statement, 10);
            [pmList addObject:cell];
        }
    }
    [self closeDatabase];
    return pmList;
}

- (void)closeDatabase
{
    sqlite3_close(database);
}

@end
