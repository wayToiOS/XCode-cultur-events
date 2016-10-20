//
//  CultservFetcher.h
//  CulturEvents
//
//  Created by Vladimir Bolotov on 20.10.16.
//  Copyright © 2016 Vladimir Bolotov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CultservFetcher : NSObject


+(NSURL *)URLforCategories;
+(NSURL *)URLforEventsInCategory:(int)categoryId;

@end
