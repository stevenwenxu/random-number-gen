//
//  ExceptionsViewController.m
//  Whats-for-lunch
//
//  Created by Steven Xu on 2016-08-15.
//  Copyright © 2016 Steven Xu. All rights reserved.
//

#import "ExceptionsViewController.h"
#import "RNGModel.h"

@interface ExceptionsViewController ()

@property (strong, nonatomic) IBOutlet UISwitch *addRangeSwitch;
@property (strong, nonatomic) IBOutlet UITextField *fromTextField;
@property (strong, nonatomic) IBOutlet UILabel *toLabel;
@property (strong, nonatomic) IBOutlet UITextField *toTextField;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ExceptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.addRangeSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)switchChanged:(UISwitch *)sender {
    self.toLabel.hidden = !sender.on;
    self.toTextField.hidden = !sender.on;
}

- (IBAction)addClicked {
    if (self.addRangeSwitch.on) {
        if (self.fromTextField.text != nil && self.toTextField.text != nil) {
            for (int i = self.fromTextField.text.intValue; i <= self.toTextField.text.intValue; i++) {
                [[RNGModel sharedInstance].exceptions addObject:[NSNumber numberWithInt:i]];
            }
        }
    } else {
        if (self.fromTextField.text != nil) {
            [[RNGModel sharedInstance].exceptions addObject:[NSNumber numberWithInt:self.fromTextField.text.intValue]];
        }
    }

    [self.view endEditing:YES];
    [self.tableView reloadData];
}

- (IBAction)clearClicked {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are you sure?"
                                                                   message:@"Clear everything?"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"Yes"
                                              style:UIAlertActionStyleDestructive
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                [[RNGModel sharedInstance].exceptions removeAllObjects];
                                                [self.tableView reloadData];
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                              style:UIAlertActionStyleCancel
                                            handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)doneClicked:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// MARK: UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [RNGModel sharedInstance].exceptions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"item"];
    cell.textLabel.text = [[RNGModel sharedInstance].exceptions.allObjects objectAtIndex:indexPath.row].stringValue;
    return cell;
}

@end
