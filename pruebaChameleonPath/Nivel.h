//
//  Nivel.h
//  pruebaChameleonPath
//
//  Created by Dave on 11/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface Nivel : CCLayer {
    NSMutableArray *_tiles;
}

+(CCScene *) scene;
+(CCScene *) sceneWithMatrix: (int [][16]) matrix;

//-(id) initWithMatrix:(int [][16]) matrix;

@end
