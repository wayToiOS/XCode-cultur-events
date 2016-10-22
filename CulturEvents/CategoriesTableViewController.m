//
//  CategoriesTableViewController.m
//  CulturEvents
//
//  Created by Vladimir Bolotov on 19.10.16.
//  Copyright © 2016 Vladimir Bolotov. All rights reserved.
//

#import "CategoriesTableViewController.h"
#import "CultservFetcher.h"
#import "CategoryEventsTVC.h"


@interface CategoriesTableViewController ()

@end

@implementation CategoriesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchCategories];
}


- (void)fetchCategories{
    NSURL *url = [CultservFetcher URLforCategories];
    
    dispatch_queue_t fetchQ = dispatch_queue_create("categories fetcher", NULL);
    dispatch_async(fetchQ, ^{
        NSError *error = nil;
        
        NSData *jsonResults = [NSData dataWithContentsOfURL:url options:0 error: &error];
        
        
        NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                            options:0
                                                                              error:NULL];
        
        NSArray *categories = [propertyListResults valueForKeyPath:@"message"];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.categories = categories;
        });
    });
}

- (void) setCategories:(NSArray *)categories{
    _categories = categories;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return the number of rows
    return [self.categories count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoriesCell"
                                                            forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *category = self.categories[indexPath.row];
    cell.textLabel.text = [category valueForKeyPath:@"title"];
    cell.detailTextLabel.text = [[category valueForKeyPath:@"events_count"] stringValue];
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareTVC:(CategoryEventsTVC *)tvc toDisplayEventsInCategory:(NSDictionary *)category {
    tvc.categoryEventsURL = [CultservFetcher URLforEventsInCategory: [[category valueForKeyPath:@"id"] intValue]];
    tvc.title = [category valueForKeyPath:@"title"];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"ShowCategoryEvents"]) {
                if ([segue.destinationViewController isKindOfClass:[CategoryEventsTVC class]]) {
                    [self prepareTVC:segue.destinationViewController
           toDisplayEventsInCategory:self.categories[indexPath.row]];
                }
            }
        }
    }

}


@end
