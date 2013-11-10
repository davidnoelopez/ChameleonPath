//
//  Nivel.m
//  pruebaChameleonPath
//
//  Created by Dave on 11/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//
//

#import "Nivel.h"
#import "HelloWorldLayer.h"
#import "Pared.h"

@implementation Nivel

+(CCScene *) scene{
    CCScene *scene = [CCScene node];
    
    Nivel *layer = [Nivel node];
    
    [scene addChild: layer];
    
    return scene;
}

+(CCScene *) sceneWithMatrix:(int [][16])matrix{
    CCScene *scene = [CCScene node];
    
    Nivel *layer = [[Nivel alloc] initWithMatrix:matrix];
    
    //[[self alloc] initWithMatrix:matrix];
    
    [scene addChild: layer];
    
    return scene;
    
}

-(id) initWithMatrix:(int [][16])matrix
{
	if((self=[super init])) {
        self.isTouchEnabled = YES;
        
        direccion1 = 1;
        direccion2 = 1;
        direccion3 = 1;
        direccion4 = 1;

        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        CCSprite *background = [CCSprite spriteWithFile:@"arena.png"];
        background.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:background z:-2];
        
        _tiles = [[NSMutableArray alloc] init];
        
        //crea paredes que se van a usar en el nivel
        Pared *p1 = [[Pared alloc] init];
        [p1 setParedSprite:[[NSString alloc] initWithString:@"tile.png"]];
        
        [p1 setTipo:1];
        [_tiles addObject:p1];
        
        
        for (int x = 0; x < 24; x++) {
            for (int y = 0; y < 16; y++) {
                mat[x][y] = matrix[x][y];
                int selectedTile = 0;
                Pared *auxPared = [_tiles objectAtIndex:selectedTile];
                
                CCSprite *tile = [[CCSprite alloc] initWithFile:[auxPared paredSprite]];
                //tile.tag = [auxPared tag];
                if (matrix[x][y] == 1) {
                    tile.position = ccp(x*20+tile.contentSize.width/2,y*20+tile.contentSize.height/2);
                    //tile.position = ccp(0,0);
                    [self addChild:tile z:0];
                }
                else if (matrix[x][y] == 9){
                    xCam = x;
                    yCam = y;
                }
                else if (matrix[x][y] == 8){
                    llave = [CCSprite spriteWithFile:@"Key.png"];
                    llave.position = ccp(x*20+llave.contentSize.width/2,y*20+llave.contentSize.height/2);
                    [self addChild:llave z:1];
                }
                else if (matrix[x][y] == 7){
                    estrella = [CCSprite spriteWithFile:@"star.png"];
                    estrella.position = ccp(x*20+estrella.contentSize.width/2,y*20+estrella.contentSize.height/2);
                    [self addChild:estrella z:1];
                }
                else if (matrix[x][y] == 3){
                    xMos1 = x;
                    yMos1 = y;
                    mosca1 = [CCSprite spriteWithFile:@"fly.png"];
                    mosca1.position = ccp(x*20+mosca1.contentSize.width/2,y*20+mosca1.contentSize.height/2);
                    [self addChild:mosca1 z:1];
                    [self moveEnemyLados:mosca1 x:xMos1 y:yMos1 tipo:3 direccion:direccion1];

                }
                else if (matrix[x][y] == 4){
                    xMos2 = x;
                    yMos2 = y;
                    mosca2 = [CCSprite spriteWithFile:@"fly.png"];
                    mosca2.position = ccp(x*20+mosca2.contentSize.width/2,y*20+mosca2.contentSize.height/2);
                    [self addChild:mosca2 z:1];
                    [self moveEnemyLados:mosca2 x:xMos2 y:yMos2 tipo: 4 direccion:direccion2];
                    
                }
                else if (matrix[x][y] == 5){
                    xMos3 = x;
                    yMos3 = y;
                    mosca3 = [CCSprite spriteWithFile:@"fly.png"];
                    mosca3.position = ccp(x*20+mosca3.contentSize.width/2,y*20+mosca3.contentSize.height/2);
                    [self addChild:mosca3 z:1];
                    [self moveEnemyArribaAbajo:mosca3 x:xMos3 y:yMos3 tipo: 5 direccion:direccion3];
                    
                }
                else if (matrix[x][y] == 6){
                    xMos4 = x;
                    yMos4 = y;
                    mosca4 = [CCSprite spriteWithFile:@"fly.png"];
                    mosca4.position = ccp(x*20+mosca4.contentSize.width/2,y*20+mosca4.contentSize.height/2);
                    [self addChild:mosca4 z:1];
                    [self moveEnemyArribaAbajo:mosca4 x:xMos4 y:yMos4 tipo: 6 direccion:direccion4];
                    
                }
            }
        }
        camaleon = [CCSprite spriteWithFile:@"camaleon.png"];
        camaleon.position =  ccp(xCam*20+camaleon.contentSize.width/2,yCam*20+camaleon.contentSize.height/2);
        
        // add the label as a child to this Layer
        [self addChild:camaleon z:2];
        

	}
	return self;
}

-(id) init
{
    if((self=[super init])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        CCSprite *background = [CCSprite spriteWithFile:@"BlurryBackground.png"];
        background.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:background z:-2];
		
        CCSprite *opciones = [CCSprite spriteWithFile:@"OptionsButton.png"];
        opciones.position =  ccp(winSize.width/2 , 270 );
        [self addChild: opciones];
	}
	return self;

}

-(void)registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self
                                                              priority:0
                                                       swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	return YES;
}

-(void)setPlayerPosition:(CGPoint)position {
	camaleon.position = position;
}

-(void)setMoscaPosition:(CGPoint)position {
	//mosca.position = position;
}

-(void)moveEnemyLados:(CCSprite *) enemigo x: (int)xMos y:(int)yMos tipo:(int) t direccion:(int) d{
    CGPoint moscaPos = enemigo.position;
    
    
        if (mat[xMos + d][yMos] == 0) {
            mat[xMos][yMos] = 0;
            moscaPos.x+= enemigo.contentSize.width*d;
            CCLOG(@"Mosca %d: [%.0f][%.0f]", t, moscaPos.x, moscaPos.y);
            xMos += d;
            enemigo.position = moscaPos;
            
            mat[xMos][yMos] = t;
        }else if (mat[xMos+d][yMos] == 1){
            d = d * -1;
        }
    

    [enemigo runAction:[CCSequence actions:[CCMoveTo actionWithDuration:.3 position:ccp(moscaPos.x, moscaPos.y)],[CCCallBlock actionWithBlock:^{
        [self moveEnemyLados:enemigo x:xMos y:yMos tipo:t direccion:d];
    }], nil]];

}


-(void)moveEnemyArribaAbajo:(CCSprite *) enemigo x: (int)xMos y:(int)yMos tipo:(int) t direccion:(int)d{
    CGPoint moscaPos = enemigo.position;
    
    
    if (mat[xMos][yMos + d] == 0) {
        mat[xMos][yMos] = 0;
        moscaPos.y+= enemigo.contentSize.width*d;
        CCLOG(@"Entro aqui: %.0f, %.0f", moscaPos.x, moscaPos.y);
        yMos += d;
        enemigo.position = moscaPos;
        
        mat[xMos][yMos] = t;
    }else if (mat[xMos][yMos+d] == 1){
        d = d * -1;
    }
    
    
    [enemigo runAction:[CCSequence actions:[CCMoveTo actionWithDuration:.3 position:ccp(moscaPos.x, moscaPos.y)],[CCCallBlock actionWithBlock:^{
        [self moveEnemyArribaAbajo:enemigo x:xMos y:yMos tipo:t direccion:d];
    }], nil]];
    
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView:touch.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
    
    CGPoint playerPos = camaleon.position;
    //CGPoint diff = ccpSub(touchLocation, playerPos);
    int cambioX = 0, cambioY = 0;

    if( (touchLocation.x > 0 && touchLocation.x < 160 ) && (touchLocation.y > 107 && touchLocation.y < 213 ))
        cambioX = -1;
    
    if( (touchLocation.x > 320 && touchLocation.x < 480 ) && (touchLocation.y > 107 && touchLocation.y < 213 ))
        cambioX = +1;
    
    if( (touchLocation.x > 160 && touchLocation.x < 320 ) && (touchLocation.y > 213 && touchLocation.y < 320 ))
        cambioY = +1;
    
    if( (touchLocation.x > 160 && touchLocation.x < 320 ) && (touchLocation.y > 0 && touchLocation.y < 107 ))
        cambioY = -1;

    
   /* Movimiento viejo
    
    if ( abs(diff.x) > abs(diff.y) ) {
        if (diff.x > 0) {
            cambioX = 1;
            //playerPos.x += camaleon.contentSize.width;
            //xCam++;
        } else if (diff.x < 0){
            cambioX = -1;
            //playerPos.x -= camaleon.contentSize.width;
            //xCam--;
        }
    } else {
        if (diff.y > 0) {
            cambioY = 1;
            //playerPos.y += camaleon.contentSize.height;
            //yCam++;
        } else if (diff.y < 0){
            cambioY = -1;
            //playerPos.y -= camaleon.contentSize.height;
            //yCam--;
        }
    }

    */
    
    
    //Cambia las posiciones
    if (!((xCam == 0 && cambioX < 0) || (yCam == 0 && cambioY < 0)))
        if (mat[xCam+cambioX][yCam+cambioY] == 0 || mat[xCam+cambioX][yCam+cambioY] == 8 || mat[xCam+cambioX][yCam+cambioY] == 7) {
            mat[xCam][yCam] = 0;
            playerPos.x += camaleon.contentSize.width*cambioX;
            xCam += cambioX;
            playerPos.y += camaleon.contentSize.height*cambioY;
            yCam += cambioY;
            [self setPlayerPosition:playerPos];
            
            switch (mat[xCam][yCam]) {
                case 8:
                    [self removeChild:llave cleanup:YES];
                    break;
                    
                case 7:
                    [self removeChild:estrella cleanup:YES];
                    break;
                    
                default:
                    break;
            }
            mat[xCam][yCam] = 9;
        }
    
    
    
}

@end