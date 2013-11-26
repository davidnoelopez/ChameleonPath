//
//  HelloWorldLayer.h
//  pruebaChameleonPath
//
//  Created by Diego de los Reyes on 13/10/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// Otras clases
#import "Puntuacion.h"
#import "Opciones.h"
#import "SimpleAudioEngine.h"
#import "Nivel.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
