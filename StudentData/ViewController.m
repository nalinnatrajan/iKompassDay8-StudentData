//
//  ViewController.m
//  StudentData
//
//  Created by Nalin Natrajan on 15/3/15.
//  Copyright (c) 2015 Nalin Natrajan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@property (weak, nonatomic) IBOutlet UITextField *streamTextField;

- (IBAction)addInformationButton:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addInformationButton:(id)sender {
    StudentEntity *student = [NSEntityDescription insertNewObjectForEntityForName:@"StudentEntity" inManagedObjectContext:self.managedObjectContext];
    student.studentName = self.nameTextField.text;
    student.studentAge = [NSNumber numberWithInt:self.ageTextField.text.intValue];
    student.studentStream = self.streamTextField.text;
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   
    ViewStudentControllerViewController *viewStudentsController = (ViewStudentControllerViewController *)segue.destinationViewController;
    viewStudentsController.managedObjectContext = self.managedObjectContext;
}
@end
