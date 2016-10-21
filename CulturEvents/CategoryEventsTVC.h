//
//  CategoryEventsTVC.h
//  CulturEvents
//
//  Created by Vladimir Bolotov on 21.10.16.
//  Copyright © 2016 Vladimir Bolotov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryEventsTVC : UITableViewController

@property (nonatomic, strong) NSURL *categoryEventsURL;
@property (nonatomic, strong) NSArray *events;

@end
