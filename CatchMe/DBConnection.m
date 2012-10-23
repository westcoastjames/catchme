//
//  DBConnection.m
//  CatchMe
//
//  Created by Jonathon Simister on 10/21/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "DBConnection.h"

@implementation DBConnection
- (id) init {
    self = [super init];
    if (self != nil) {
        NSString *docsDir;
        NSArray *dirPaths;
        
        // Get the documents directory
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        docsDir = [dirPaths objectAtIndex:0];
        
        // Build the path to the database file
        databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"settings.db"]];
        
        const char *dbpath = [databasePath UTF8String];
        
        NSFileManager *filemgr = [NSFileManager defaultManager];
        
        if ([filemgr fileExistsAtPath: databasePath ] == NO)
        {
            if (sqlite3_open(dbpath, &settingsDB) == SQLITE_OK)
            {
                char *errMsg;
                const char *sql_stmt = "CREATE TABLE IF NOT EXISTS SETTINGS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, VALUE TEXT)";
                
                if (sqlite3_exec(settingsDB, sql_stmt, NULL, NULL, &errMsg) == SQLITE_OK) {
                    NSLog(@"table created successfully");
                } else {
                    NSLog(@"TABLE FAILED");
                    sqlite3_close(settingsDB);
                    return nil;
                }
                
                
            } else {
                NSLog(@"Database failed");
                return nil;
            }
        } else {
            // if the database file did not need to be created newly, then open the existing file
            sqlite3_open(dbpath, &settingsDB);
            
            NSLog(@"opened existing");
        }
        
    }
    return self;
}

-(void)setSetting:(NSString *)name value:(NSString *)value {
    NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM settings WHERE name=\"%@\"", name];
    const char *query_stmt = [querySQL UTF8String];
    sqlite3_stmt    *statement;
    NSString* updateSQL;
    NSString* insertSQL;
    
    if (sqlite3_prepare_v2(settingsDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
            sqlite3_finalize(statement);
            
            NSLog(@"to update");
            
            updateSQL = [NSString stringWithFormat: @"UPDATE settings SET value=\"%@\" WHERE name=\"%@\"",value,name];
            
            query_stmt = [updateSQL UTF8String];
            
            if(sqlite3_prepare_v2(settingsDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
                sqlite3_step(statement);
            }
        } else {
            sqlite3_finalize(statement);
            
            NSLog(@"to insert");
            
            insertSQL = [NSString stringWithFormat: @"INSERT INTO SETTINGS (name, value) VALUES (\"%@\",\"%@\")",name,value];
            
            query_stmt = [insertSQL UTF8String];
            
            if(sqlite3_prepare_v2(settingsDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
                sqlite3_step(statement);
            }
        }
    } else {
        NSLog(@"failed");
    }
}

/**
 *  getSetting          retrieve a setting value from the SQLite database by it's name
 *
 *  NSString* name      the name of the setting to retrieve
 *  
 *  return              the value (NSString*)
 */
-(NSString*)getSetting:(NSString*)name {
    NSString *querySQL = [NSString stringWithFormat: @"SELECT name,value FROM settings WHERE name=\"%@\"", name];
    const char *query_stmt = [querySQL UTF8String];
    sqlite3_stmt    *statement;
    const char* result;
    
    if (sqlite3_prepare_v2(settingsDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
            //NSLog(@"got row");
            
            result = (const char *)sqlite3_column_text(statement, 1);
            
            NSString *valueField = [[NSString alloc] initWithUTF8String:result];
            
            sqlite3_finalize(statement);
            
            return valueField;
        } else {
            sqlite3_finalize(statement);
            
            //NSLog(@"no row found");
            
            return nil;
        }
    } else {
        return nil;
    }
}

-(void) closeDB {
    sqlite3_close(settingsDB);
}

@end
