//
//  ViewController.m
//  KeyBoardAnimation
//
//  Created by roboca on 15/10/27.
//  Copyright © 2015年 roboca. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize backview;
@synthesize inputTX;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    backview = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 60, self.view.bounds.size.width, 60)];
    backview.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:backview];
    
    inputTX = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, backview.frame.size.width-40, 40)];
    inputTX.backgroundColor = [UIColor whiteColor];
    inputTX.layer.cornerRadius = 4.0f;
    [backview addSubview:inputTX];
    
    UIControl *backTap = [[UIControl alloc] initWithFrame:self.view.bounds];
    [backTap addTarget:self action:@selector(hideKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backTap];
    [self.view sendSubviewToBack:backTap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyBoardShow:(NSNotification *)note{
    NSDictionary *info = note.userInfo;
    CGRect keyBoardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    keyBoardFrame = [self.view convertRect:keyBoardFrame toView:nil];
    NSInteger deltaY = keyBoardFrame.size.height;
    [UIView animateWithDuration:duration delay:0 options:[[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue]<<16 animations:^{
        backview.transform = CGAffineTransformMakeTranslation(0, -deltaY);
    } completion:nil];
}

-(void)keyBoardHide:(NSNotification *)note{
    backview.transform = CGAffineTransformIdentity;
}

-(void)hideKeyBoard{
    [inputTX resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
