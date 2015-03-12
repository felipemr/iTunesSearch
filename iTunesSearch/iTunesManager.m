                //
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"
#import "Entidades/Midia.h"

@implementation iTunesManager

static iTunesManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}


- (NSMutableArray *)buscarMidias:(NSString *)termo {
    if (!termo) {
        termo = @"";
    }
    
    
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=all&limit=200", termo];
    NSURL *url=[[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    
    NSData *jsonData = [NSData dataWithContentsOfURL: url];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        return nil;
    }
    
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    
    NSMutableArray *midia,*book, *album, *featureMovie,*podcast, *song;
    
    
    
    midia= [[NSMutableArray alloc] init];
    book= [[NSMutableArray alloc] init];
    album= [[NSMutableArray alloc] init];
    featureMovie= [[NSMutableArray alloc] init];
    podcast= [[NSMutableArray alloc] init];
    song= [[NSMutableArray alloc] init];
    
    
    for (NSDictionary *item in resultados) {
        if ([[item objectForKey:@"kind"]  isEqual: @"song"]) {
            Midia *meu=[[Midia alloc]init];
            [meu setTipo:@"musica"];
            [meu setNome:[item objectForKey:@"trackName"]];
            [meu setTrackId:[item objectForKey:@"trackId"]];
            [meu setArtista:[item objectForKey:@"artistName"]];
            [meu setGenero:[item objectForKey:@"primaryGenreName"]];
            [meu setPais:[item objectForKey:@"country"]];
            [meu setPreco:[item objectForKey:@"trackPrice"]];
            [song addObject:meu];
        }
        if ([[item objectForKey:@"kind"]  isEqual: @"book"]) {
            Midia *meu=[[Midia alloc]init];
            [meu setTipo:@"book"];
            [meu setNome:[item objectForKey:@"trackName"]];
            [meu setTrackId:[item objectForKey:@"trackId"]];
            [meu setArtista:[item objectForKey:@"artistName"]];
            [meu setGenero:[item objectForKey:@"primaryGenreName"]];
            [meu setPais:[item objectForKey:@"country"]];
            [meu setPreco:[item objectForKey:@"trackPrice"]];
            [book addObject:meu];
        }
        if ([[item objectForKey:@"kind"]  isEqual: @"feature-movie"]) {
            Midia *filme = [[Midia alloc] init];
            [filme setTipo:@"filme"];
            [filme setNome:[item objectForKey:@"trackName"]];
            [filme setTrackId:[item objectForKey:@"trackId"]];
            [filme setArtista:[item objectForKey:@"artistName"]];
            //[(Filme *)filme setDuracao:[item objectForKey:@"trackTimeMillis"]];
            [filme setGenero:[item objectForKey:@"primaryGenreName"]];
            [filme setPais:[item objectForKey:@"country"]];
            [filme setPreco:[item objectForKey:@"trackPrice"]];
            [featureMovie addObject:filme];
        }
        if ([[item objectForKey:@"kind"]  isEqual: @"podcast"]) {
            Midia *meu=[[Midia alloc]init];
            [meu setTipo:@"podcast"];
            [meu setNome:[item objectForKey:@"trackName"]];
            [meu setTrackId:[item objectForKey:@"trackId"]];
            [meu setArtista:[item objectForKey:@"artistName"]];
            [meu setGenero:[item objectForKey:@"primaryGenreName"]];
            [meu setPais:[item objectForKey:@"country"]];
            [meu setPreco:[item objectForKey:@"trackPrice"]];
            [podcast addObject:meu];
        }
        
    }
    
    if ([book count]!= 0) {
        [midia addObject:book];
    }
    if ([featureMovie count]!= 0) {
        [midia addObject:featureMovie];
    }
    if ([song count]!= 0) {
        [midia addObject:song];
    }
    if ([podcast count]!= 0) {
        [midia addObject:podcast];
    }
    return midia;
}




#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[iTunesManager alloc] init];
}

- (id)mutableCopy
{
    return [[iTunesManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}


@end
