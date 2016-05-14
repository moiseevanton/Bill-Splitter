//
//  ViewController.m
//  Bill Splitter
//
//  Created by Anton Moiseev on 2016-05-13.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;

@property (weak, nonatomic) IBOutlet UITextField *tipPercentageTextField;

@property (weak, nonatomic) IBOutlet UISlider *numberOfPeopleSlider;

@property (weak, nonatomic) IBOutlet UILabel *splitAmountLabel;

@property (weak, nonatomic) IBOutlet UILabel *numberOfPeopleLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.numberOfPeopleSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    self.numberOfPeopleLabel.text = [NSString stringWithFormat:@"%d people splitting", (int)self.numberOfPeopleSlider.value];
    self.billAmountTextField.delegate = self;
    self.tipPercentageTextField.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)calculateSplitAmount {
    
    NSNumberFormatter *firstFormatter = [[NSNumberFormatter alloc] init];
    
    
    if ([firstFormatter numberFromString:self.billAmountTextField.text] != nil && [firstFormatter numberFromString:self.tipPercentageTextField.text] != nil) {
        
        NSDecimalNumber *billAmountWithoutTip = [NSDecimalNumber decimalNumberWithString:self.billAmountTextField.text];
        
        NSDecimalNumber *tipPercentage = [NSDecimalNumber decimalNumberWithString:self.tipPercentageTextField.text];
        
        NSDecimalNumber *base = [[NSDecimalNumber alloc] initWithFloat:100.0];
        
        NSDecimalNumber *tipPercentageAsDecimal = [tipPercentage decimalNumberByDividingBy:base];
        
        NSDecimalNumber *totalPercentage = [[[NSDecimalNumber alloc] initWithFloat:1.0] decimalNumberByAdding:tipPercentageAsDecimal];
        
        NSDecimalNumber *billAmountWithTip = [billAmountWithoutTip decimalNumberByMultiplyingBy:totalPercentage];
    
        NSDecimalNumber *numberOfPeople = [[NSDecimalNumber alloc] initWithFloat:self.numberOfPeopleSlider.value];
    
        NSDecimalNumber *amountPerPersonWithTip =  [billAmountWithTip decimalNumberByDividingBy:numberOfPeople];
    
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
        [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
        NSString *amountPerPersonString = [formatter stringFromNumber:amountPerPersonWithTip];
    
        self.splitAmountLabel.text = [NSString stringWithFormat:@"It will be %@ per person!", amountPerPersonString];
    
    } else if (self.billAmountTextField.text.length == 0 && self.tipPercentageTextField.text.length == 0) {
        
        UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"Enter bill amount and tip percentage!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^ (UIAlertAction * action) {}];
        [myAlert addAction:defaultAction];
        
        [self presentViewController:myAlert animated:YES completion:nil];

        
    } else if (self.billAmountTextField.text.length == 0) {
        
        UIAlertController *myAlert2 = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"Enter your bill amount!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction2 = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^ (UIAlertAction * action) {}];
        [myAlert2 addAction:defaultAction2];
        
        [self presentViewController:myAlert2 animated:YES completion:nil];
        
    } else if (self.tipPercentageTextField.text.length == 0) {
        
        UIAlertController *myAlert3 = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"Enter your tip!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction3 = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^ (UIAlertAction * action) {}];
        [myAlert3 addAction:defaultAction3];
        
        [self presentViewController:myAlert3 animated:YES completion:nil];
        
    } else if ([firstFormatter numberFromString:self.billAmountTextField.text] == nil && [firstFormatter numberFromString:self.tipPercentageTextField.text] == nil) {
        
        UIAlertController *myAlert4 = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"Bill amount and tip percentage must be numbers!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction4 = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^ (UIAlertAction * action) {}];
        [myAlert4 addAction:defaultAction4];
        
        [self presentViewController:myAlert4 animated:YES completion:nil];

        
    } else if ([firstFormatter numberFromString:self.billAmountTextField.text] == nil) {
        
        UIAlertController *myAlert5 = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"Bill amount must be a number!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction5 = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^ (UIAlertAction * action) {}];
        [myAlert5 addAction:defaultAction5];
        
        [self presentViewController:myAlert5 animated:YES completion:nil];
        
        
    } else if ([firstFormatter numberFromString:self.tipPercentageTextField.text] == nil) {
        
        UIAlertController *myAlert6 = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"Tip percentage must be a number!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction6 = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^ (UIAlertAction * action) {}];
        [myAlert6 addAction:defaultAction6];
        
        [self presentViewController:myAlert6 animated:YES completion:nil];
        
    }
    
}

- (void)valueChanged:(UISlider *)slider {
    
    int discreteValue = roundf(slider.value);
    [slider setValue:(float)discreteValue];
    self.numberOfPeopleLabel.text = [NSString stringWithFormat:@"%d people splitting", (int)self.numberOfPeopleSlider.value];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    [self calculateSplitAmount];
    
    return YES;
    
}


@end
