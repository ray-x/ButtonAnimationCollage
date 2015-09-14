//
//  ViewController.m
//  ButtonAnimationCollage
//
//  Created by Ray Xu on 23/08/2015.
//  Copyright (c) 2015 Ray Xu. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+Effects.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *rippleButton;

@property (weak, nonatomic) IBOutlet UIButton *colorInvertButton;
@property (weak, nonatomic) IBOutlet UIButton *borderButton;
@property (weak, nonatomic) IBOutlet UIButton *RippleAndBorderButton;
@property (weak, nonatomic) IBOutlet UIButton *invertAndBorderButton;
@end

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =UIColorFromRGB(0xF8BBD0);
    // Do any additional setup after loading the view, typically from a nib.
    [self.rippleButton initButton:UIColorFromRGB(0xC51162) ];
    [self.colorInvertButton initButton:UIColorFromRGB(0xD50000)];
    [self.borderButton initButton:[UIColor magentaColor]];
    [self.RippleAndBorderButton initButton:UIColorFromRGB(0xFF1744)];
    [self.invertAndBorderButton initButton:[UIColor purpleColor]];
}
/*
 EnumEffectRipple  =1<<0,
 EnumEffectBorder =1<<1,
 EnumEffectFlip    =1<<2,
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)RippleAct:(id)sender {
    [self.rippleButton startAnimation:EnumEffectRipple];
}
- (IBAction)InvertAct:(id)sender {
    [self.colorInvertButton startAnimation:EnumEffectFlip];
}
- (IBAction)BorderAct:(id)sender {
    [self.borderButton startAnimation:EnumEffectBorder];
}
- (IBAction)RipAndBorder:(id)sender {
    [self.RippleAndBorderButton startAnimation:EnumEffectRipple|EnumEffectBorder];
}
- (IBAction)invertAndBorder:(id)sender {
    [self.invertAndBorderButton startAnimation:EnumEffectFlip|EnumEffectBorder];
}

@end
