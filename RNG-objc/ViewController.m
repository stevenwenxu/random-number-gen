//
//  ViewController.m
//  RNG-objc
//
//  Created by Steven Xu on 2016-08-13.
//  Copyright © 2016 Steven Xu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *resultview;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *resultViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *resultViewWidth;
@property (weak, nonatomic) IBOutlet UITextField *fromTextField;
@property (weak, nonatomic) IBOutlet UITextField *toTextField;
@property (weak, nonatomic) IBOutlet UIButton *generateBtn;

@property (readwrite) NSMutableArray<UIImage*> *imageArray;
@property CGFloat xSoFar;

@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.imageArray = [NSMutableArray array];
        self.xSoFar = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fromTextField.delegate = self;
    self.toTextField.delegate = self;
}

- (IBAction)didTapGenerate {
    NSNumber *num = [self getRandomNum];
    [self.imageArray removeAllObjects];
    for (UIImageView *image in self.resultview.subviews) {
        [image removeFromSuperview];
    }
    self.xSoFar = 0;

    if (num == nil) {
        self.generateBtn.enabled = NO;
    } else {
        [self.view endEditing:YES];
        CGFloat rawWidth = 0;
        CGFloat rawHeight = 0;
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat maxHeight = 120;

        for (NSUInteger i = 0; i < num.stringValue.length; i++) {
            unichar myChar = [num.stringValue characterAtIndex:i];
            UIImage *image = [UIImage imageNamed:[NSString stringWithCharacters:&myChar length:1]];
            rawWidth += image.size.width;
            rawHeight += image.size.height;
            [self.imageArray addObject:image];
        }
        rawHeight /= num.stringValue.length;

        CGFloat scale = MIN(maxWidth / rawWidth, maxHeight / rawHeight);
        CGFloat desiredHeight = rawHeight * scale;
        CGFloat desiredWidth = rawWidth * scale;

        [self.resultview layoutIfNeeded];
        [UIView animateWithDuration:1 animations:^{
            self.resultViewHeight.constant = desiredHeight;
            self.resultViewWidth.constant = desiredWidth;
            [self.resultview layoutIfNeeded];
        }];

//        NSLog(@"rawWidth: %f, rawHeight: %f, scale: %f", rawWidth, rawHeight, scale);
//        NSLog(@"desiredWidth: %f, desiredHeight: %f", desiredWidth, desiredHeight);

        for (NSUInteger i = 0; i < self.imageArray.count; i++) {
            UIImage *image = [self.imageArray objectAtIndex:i];
            CGFloat width = desiredWidth / num.stringValue.length;
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(self.xSoFar, 0, width, desiredHeight)];
            iv.image = image;
            [self.resultview addSubview:iv];
            self.xSoFar += width;
        }
    }
}

- (NSNumber*)getRandomNum {
    NSString *from = self.fromTextField.text;
    NSString *to = self.toTextField.text;
    if (from != nil && to != nil) {
        if (from.integerValue > to.integerValue) {
            return nil;
        }
        int randNum = arc4random_uniform(to.intValue - from.intValue + 1) + from.intValue;
        NSLog(@"randNum is: %d", randNum);
        return [NSNumber numberWithInt:randNum];
    }
    return nil;
}

// MARK: UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *from = self.fromTextField.text;
    NSString *to = self.toTextField.text;
    if (from == nil || to == nil) {
        return NO;
    }
    if (self.fromTextField.isFirstResponder) {
        from = [from stringByReplacingCharactersInRange:range withString:string];
    } else if (self.toTextField.isFirstResponder) {
        to = [to stringByReplacingCharactersInRange:range withString:string];
    }
    self.generateBtn.enabled = to.integerValue >= from.integerValue;
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField setText:@""];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

@end
