//
//  CustomSlider.h
//  Measures
//
//  Created by Michael Neuwert on 4/26/11.
//  Copyright 2011 Neuwert Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MNESliderValuePopupView;

@interface MNEValueTrackingSlider : UISlider {
    MNESliderValuePopupView *valuePopupView; 
}

@property (nonatomic, readonly) CGRect thumbRect;

@end
