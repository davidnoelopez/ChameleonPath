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
    CCSprite *camaleon, *llave, *estrella1, *estrella2, *estrella3, *mosca1, *mosca2, *mosca3, *mosca4, *puerta;
    int xCam, yCam;
    int xMos1, yMos1;
    int xMos2, yMos2;
    int xMos3, yMos3;
    int xMos4, yMos4;
    int mat[24][16];
    int direccion1, direccion2, direccion3, direccion4;
    int tengoEstrella;
    BOOL tengoLlave;
    BOOL colision;
    int offset;                 //offset para pantallas de 4"
    int nivelActual;
    
    CCLabelTTF *timerLabel;
    ccTime tiempoTotal;
    int timer;
    int tiempoActual;
    
}

+(CCScene *) scene;
+(CCScene *) sceneWithMatrix: (int [][16]) matrix nivel:(int) n time:(int) t;
-(void)moveEnemyArribaAbajo:(CCSprite *) sprite x: (int)xMos y:(int)yMos tipo:(int) t direccion: (int) d;
-(void)moveEnemyLados:(CCSprite *) enemigo x: (int)xMos y:(int)yMos tipo:(int) t direccion:(int) d;




//-(id) initWithMatrix:(int [][16]) matrix;

@end
