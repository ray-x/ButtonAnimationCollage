//
//  UIButton+Effects.m
//  ButtonAnimationCollage
//
//  Created by Ray Xu on 23/08/2015.
//  Copyright (c) 2015 Ray Xu. All rights reserved.
//
/* LICENSE:
 The MIT License (MIT)
 
 Copyright (c) 2015 Ray, Xu
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 the Software, and to permit persons to whom the Software is furnished to do so,
 subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
#import "UIButton+Effects.h"

//style and color setting. change to suit your needs
#define BORDER_COLOR [UIColor blackColor].CGColor
#define CORNER_RADIUS 6.0f
#define RIPPLE_RADIUS 100.0f
#define BORDER_WIDTH 1.0f



@implementation UIButton (Effects)

-(CALayer *)RippleLayer{
    return objc_getAssociatedObject(self, @selector(RippleLayer));
}
-(void)setRippleLayer:(CALayer *)RippleLayer
{
    objc_setAssociatedObject(self, @selector(RippleLayer), RippleLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CALayer *)BorderLayer{
    return objc_getAssociatedObject(self, @selector(BorderLayer));
}
-(void)setBorderLayer:(CALayer *)BorderLayer
{
    objc_setAssociatedObject(self, @selector(BorderLayer), BorderLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(void)initButton:(UIColor *)backgrdcolor
{
    
    
    //[self performSelector:@selector(setvibrancyEffect:) withObject:vibrancyEffect];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius=CORNER_RADIUS;
    
    CGFloat radius = RIPPLE_RADIUS;
    //CGPoint tempPos = self.position;
    CGFloat diameter = radius * 2;
    CGRectMake(0, 0, diameter, diameter);
    //NSLog(@"position %f",tempPos);
    self.RippleLayer=[[CALayer alloc]init];
    self.RippleLayer.frame=CGRectMake(0, 0, diameter, diameter);
    self.RippleLayer.cornerRadius = radius;
    //self.RippleLayer.position=self.layer.position;
    self.RippleLayer.position=CGPointMake( self.layer.frame.origin.x/2, self.layer.frame.size.height/2);

    //self.RippleLayer.frame=self.layer.bounds;
    self.RippleLayer.backgroundColor = [backgrdcolor CGColor];
    self.RippleLayer.opacity=0;
    

    self.BorderLayer=[[CALayer alloc]init];
    self.BorderLayer.frame=self.layer.bounds;
    self.BorderLayer.borderColor=BORDER_COLOR;
    self.BorderLayer.borderWidth=BORDER_WIDTH;
    self.BorderLayer.cornerRadius=CORNER_RADIUS;
    self.BorderLayer.opacity=0;
}

-(void)startAnimation:(EnumEffect)effects;
{
    
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 1;
    animationGroup.repeatCount = 0;
    animationGroup.removedOnCompletion = YES;
    animationGroup.timingFunction = defaultCurve;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    
    scaleAnimation.fromValue = @0.1f;
    scaleAnimation.toValue = @1;
    scaleAnimation.duration = 1;//self.animationDuration;
    scaleAnimation.autoreverses = NO;
    
    
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = 1;//self.animationDuration;

    opacityAnimation.values = @[@0.2, @0.5, @0.1];
    opacityAnimation.keyTimes = @[@0, @0.3, @1];
    opacityAnimation.removedOnCompletion = YES;
    
    CAKeyframeAnimation *borderAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    borderAnimation.duration = 1;//self.animationDuration;
    borderAnimation.values = @[@0.2, @0.8, @0.1];
    borderAnimation.keyTimes = @[@0, @0.5, @1];
    borderAnimation.removedOnCompletion = YES;
    
    
    //EnumEffectRipple EnumEffectBorder EnumEffectFlip

    NSMutableArray *animations = [NSMutableArray arrayWithCapacity:3];
    NSMutableArray *animationsBorder = [NSMutableArray arrayWithCapacity:1];
    
    if (effects&EnumEffectRipple)
    {
        [animations addObject:scaleAnimation];
        [animations addObject:opacityAnimation];

    }else if (effects&EnumEffectFlip)
    {
        [animations addObject:opacityAnimation];
    }
    if (effects&EnumEffectBorder)
    {
        [self.layer insertSublayer:self.BorderLayer above:self.layer];
        [self.BorderLayer addAnimation: borderAnimation forKey:nil];
    }
    
    animationGroup.animations = animations;
    [self.RippleLayer addAnimation:animationGroup forKey:nil];
    [self.layer insertSublayer:self.RippleLayer above:self.layer];
    
}



@end
