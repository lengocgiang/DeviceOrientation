# DeviceOrientation
Using CoreMotion to detect device orientation, and post notification when device changed status


// Init
````objective-c
[DeviceOrientation sharedInstance]create];
````
````objective-c
// observer notification
// viewDidLoad or anywhere you want listerner
[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(orientationChanged:) name:@"kDeviveChangeOrientation" object:nil];
````

// listener
````objective-c
- (void)orientationChanged:(NSNotification *)notification{
    UIInterfaceOrientation currentOrientation = (UIInterfaceOrientation)[[notification.userInfo objectForKey:@"orientation"] integerValue];
    switch (currentOrientation) {
        case UIInterfaceOrientationUnknown: {
            NSLog(@"UIInterfaceOrientationUnknown");
            break;
        }
        case UIInterfaceOrientationPortrait: {
            NSLog(@"UIInterfaceOrientationPortrait");
            break;
        }
        case UIInterfaceOrientationPortraitUpsideDown: {
            rotation = M_PI;
            NSLog(@"UIInterfaceOrientationPortraitUpsideDown");
            break;
        }
        case UIInterfaceOrientationLandscapeLeft: {
            rotation = 3*M_PI/2;
            NSLog(@"UIInterfaceOrientationLandscapeLeft");
            break;
        }
        case UIInterfaceOrientationLandscapeRight: {
            rotation = M_PI/2;
            NSLog(@"UIInterfaceOrientationLandscapeRight");
            break;
        }
        default: {
            break;
        }
    }
````
