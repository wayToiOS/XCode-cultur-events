//
//  CultservFetcher.m
//  CulturEvents
//
//  Created by Vladimir Bolotov on 20.10.16.
//  Copyright © 2016 Vladimir Bolotov. All rights reserved.
//

#import "CultservFetcher.h"

#define CULTSERV_SERVER @"https://api.cultserv.ru/"
#define CULTSERV_SESSION @"sesson_iphone_2015_ponominalu_msk"
#define CULTSERV_IMAGE_SERVER @"http://media.cultserv.ru/i/"
#define CULTSERV_IMAGE_SIZE_SMALL @"55x55/"

@implementation CultservFetcher


+ (NSURL *)URLForQuery:(NSString *)query
{
    query = [NSString stringWithFormat:@"%@%@session=%@", CULTSERV_SERVER, query, CULTSERV_SESSION];
    return [NSURL URLWithString:query];
}

+ (NSURL *)URLforCategories{
    return [self URLForQuery:[NSString stringWithFormat:@"v4/categories/list?"]];
}

+ (NSURL *)URLforEventsInCategory:(int)categoryId{
    return [self URLForQuery:[NSString stringWithFormat:@"v4/events/list?category_id=%d&", categoryId]];
}


+ (NSURL *)URLforImageQuery:(NSString *)query withSize:(NSString *)size{
    query = [NSString stringWithFormat:@"%@%@%@", CULTSERV_IMAGE_SERVER, size, query];
    return [NSURL URLWithString:query];
}

+ (NSURL *)URLForSmallImage:(NSString *)image{
    return [self URLforImageQuery:image withSize:CULTSERV_IMAGE_SIZE_SMALL];
}

@end
