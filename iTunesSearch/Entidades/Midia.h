//
//  Midia.h
//  iTunesSearch
//
//  Created by Felipe Marques Ramos on 12/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Midia : NSObject

@property (nonatomic, strong) NSString *tipo;
@property (nonatomic, strong) NSString *nome;
@property (nonatomic, strong) NSString *preco;
@property (nonatomic, strong) NSString *pais;
@property (nonatomic, strong) NSString *artista;
@property (nonatomic, strong) NSString *trackId;
@property (nonatomic, strong) NSString *genero;
@property (nonatomic, strong) NSString *imgUrl;

@end
