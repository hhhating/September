//
//  Config.h
//  DYIDou
//
//  Created by ByteDance on 2023/9/22.
//

#ifndef Config_h
#define Config_h
#define ScreenFrame [UIScreen mainScreen].bounds
//size
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define ColorBlackAlpha60 [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6]
#define ColorBlackAlpha10 [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1]
#define ColorWhiteAlpha10 [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.1]
#define ColorWhiteAlpha60 [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.6]
#define ColorGrayLight [UIColor colorWithRed:40.0 green:40.0 blue:40.0 alpha:1.0]
#define ColorGray  [UIColor grayColor]
#define ColorWhite [UIColor whiteColor]
#define SmallFont [UIFont systemFontOfSize:12.0]
#define SmallBoldFont [UIFont boldSystemFontOfSize:12.0]
#define BigFont [UIFont systemFontOfSize:16.0]
#define BigBoldFont [UIFont boldSystemFontOfSize:16.0]
#define MediumFont [UIFont systemFontOfSize:14.0]

#define SafeAreaBottomHeight ((ScreenHeight >= 812.0) && [[UIDevice currentDevice].model isEqualToString:@"iPhone"]  ? 30 : 0)
#endif /* Config_h */
