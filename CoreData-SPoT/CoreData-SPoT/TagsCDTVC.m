//
//  TagsCDTVC.m
//  CoreData-SPoT
//
//  Created by Vasco Orey on 3/11/13.
//  Copyright (c) 2013 Delta Dog Studios. All rights reserved.
//

#import "TagsCDTVC.h"
#import "Tag.h"

@interface TagsCDTVC ()

@end

@implementation TagsCDTVC

-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext = managedObjectContext;
    if(_managedObjectContext)
    {
        NSLog(@"Setting up the fetchedResultsController");
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = nil; // Get all photographers !
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:_managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    }
    else
    {
        self.fetchedResultsController = nil;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Tag"];
    
    Tag *tag = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = tag.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d photos", [tag.photos count]];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = nil;
    
    if([sender isKindOfClass:[UITableViewCell class]])
    {
        indexPath = [self.tableView indexPathForCell:sender];
    }
    if(indexPath)
    {
        if([segue.identifier isEqualToString:@"setTag:"])
        {
            Tag *tag = [self.fetchedResultsController objectAtIndexPath:indexPath];
            if([segue.destinationViewController respondsToSelector:@selector(setTag:)])
            {
                [segue.destinationViewController performSelector:@selector(setTag:) withObject:tag];
            }
        }
    }
}


@end
