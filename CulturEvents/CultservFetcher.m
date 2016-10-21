//
//  CultservFetcher.m
//  CulturEvents
//
//  Created by Vladimir Bolotov on 20.10.16.
//  Copyright © 2016 Vladimir Bolotov. All rights reserved.
//

#import "CultservFetcher.h"

#define CULTSETV_SERVER @"https://api.cultserv.ru/"
#define CULTSERV_SESSION @"sesson_iphone_2015_ponominalu_msk"

@implementation CultservFetcher


+ (NSURL *)URLForQuery:(NSString *)query
{
    query = [NSString stringWithFormat:@"%@%@session=%@", CULTSETV_SERVER, query, CULTSERV_SESSION];
    return [NSURL URLWithString:query];
}

+ (NSURL *)URLforCategories{
    return [self URLForQuery:[NSString stringWithFormat:@"v4/categories/list?"]];
}

+ (NSURL *)URLforEventsInCategory:(int)categoryId{
    return [self URLForQuery:[NSString stringWithFormat:@"v4/events/list?category_id=%d&", categoryId]];
}




@end
