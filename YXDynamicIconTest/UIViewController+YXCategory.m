//
//  UIViewController+YXCategory.m
//  YXDynamicIconTest
//
//  Created by ios on 2020/4/15.
//  Copyright © 2020 August. All rights reserved.
//

#import "UIViewController+YXCategory.h"

@implementation UIViewController (YXCategory)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method presentM = class_getInstanceMethod(self.class, @selector(presentViewController:animated:completion:));
        Method presentSwizzlingM = class_getInstanceMethod(self.class, @selector(yxPresentViewController:animated:completion:));
        
        method_exchangeImplementations(presentM, presentSwizzlingM);
    });
}

- (void)yxPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    
    if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {
        UIAlertController *alertController = (UIAlertController *)viewControllerToPresent;
        if (alertController.title == nil && alertController.message == nil) {
            return;
        }
    }
    
    [self yxPresentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
