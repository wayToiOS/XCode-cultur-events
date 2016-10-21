//
//  CategoryEventsTVC.m
//  CulturEvents
//
//  Created by Vladimir Bolotov on 21.10.16.
//  Copyright © 2016 Vladimir Bolotov. All rights reserved.
//

#import "CategoryEventsTVC.h"
#import "EventTableViewCell.h"
#import "CultservFetcher.h"
#import "SubeventViewController.h"


@interface CategoryEventsTVC ()
@end

@implementation CategoryEventsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchEvents];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)fetchEvents{
    dispatch_queue_t fetchQEvents = dispatch_queue_create("events fetcher", NULL);
    dispatch_async(fetchQEvents, ^{
        NSError *error = nil;
        
        NSData *jsonResults = [NSData dataWithContentsOfURL:self.categoryEventsURL options:0 error: &error];
        
        
        NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                            options:0
                                                                              error:NULL];
        
        NSArray *events = [propertyListResults valueForKeyPath:@"message"];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.events = events;
        });
    });
}

- (void) setEvents:(NSArray *)events{
    _events = events;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return the number of rows
    return [self.events count];
}


#define EVENT_REUSE_IDENTIFIER @"categoryEventsCell"

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventTableViewCell *cell = (EventTableViewCell *)[tableView dequeueReusableCellWithIdentifier:EVENT_REUSE_IDENTIFIER
                                                                                     forIndexPath:indexPath];
    // Configure the cell...
    NSDictionary *event = self.events[indexPath.row];
    cell.eventTextLabel.text = [event valueForKeyPath:@"title"];
    cell.eventDate = [event valueForKeyPath:@"subevents.date"][0];
    NSString *img = [event valueForKeyPath:@"subevents.image"][0];
    //NSLog(@" imageFile = %@", img);
    cell.eventImageURL =  [CultservFetcher URLForSmallImage:img];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

- (void)prepareVC:(SubeventViewController *)vc toDisplaySubeventForEvent:(NSDictionary *)event {
    vc.subeventURL = [CultservFetcher URLforSubeventDescription: [[event valueForKeyPath:@"id"] intValue]];
    vc.subeventImageURL = [CultservFetcher URLForImage: [event valueForKeyPath:@"subevents.image"][0]];
    vc.title = [event valueForKeyPath:@"subevents.date"][0];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"ShowSubevent"]) {
                if ([segue.destinationViewController isKindOfClass:[SubeventViewController class]]) {
                    [self prepareVC:segue.destinationViewController
           toDisplaySubeventForEvent:self.events[indexPath.row]];
                }
            }
        }
    }
}

@end
