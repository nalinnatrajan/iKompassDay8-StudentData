//
//  ViewStudentControllerViewController.m
//  StudentData
//
//  Created by Nalin Natrajan on 15/3/15.
//  Copyright (c) 2015 Nalin Natrajan. All rights reserved.
//

#import "ViewStudentControllerViewController.h"

@interface ViewStudentControllerViewController ()  

@property NSArray *fetchedObjects;

@end

@implementation ViewStudentControllerViewController

@synthesize managedObjectContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadStudentData];
    // Do any additional setup after loading the view.
}

-(void)loadStudentData{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"StudentEntity" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.fetchedObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"studentInfoCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"studentInfoCell"];
    }
    StudentEntity *studentEntity = [self.fetchedObjects objectAtIndex:indexPath.row];
    UILabel *nameLabel = (UILabel *)[tableView viewWithTag:100];
    nameLabel.text = studentEntity.studentName;
    UILabel *ageLabel = (UILabel *)[tableView viewWithTag:200];
    ageLabel.text = [NSString stringWithFormat:@"%d", studentEntity.studentAge.intValue];
    UILabel *streamLabel = (UILabel *)[tableView viewWithTag:300];
    streamLabel.text = studentEntity.studentStream;
    return cell;
}

-(bool)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.managedObjectContext deleteObject:[self.fetchedObjects objectAtIndex:indexPath.row]];
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Can't Delete %@ %@", error, [error localizedDescription]);
            return;
        }
        [self loadStudentData];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
