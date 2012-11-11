//
//  DBConnection.h
//  CatchMe
//
//  Created by Jonathon Simister on 10/21/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "/usr/include/sqlite3.h"

@interface DBConnection : NSObject {
    NSString*   databasePath;
    sqlite3*    settingsDB;
}

- (id)init;
- (void)closeDB;
- (void)setSetting: (NSString*) name value : (NSString *) value;
- (NSString*)getSetting: (NSString*) name;

@end
