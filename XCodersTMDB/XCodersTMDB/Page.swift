//
//  Page.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 17/8/23.
//

import Foundation

struct Page: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let image: String
    let tag: Int
}

extension Page {
    static var pagesReal: [Page] {
        [
            Page(name: "Explora un Mundo de Películas", description: "Sumérgete en un vasto océano de películas, desde clásicos atemporales hasta los últimos éxitos de taquilla. ¡Descubre historias que te emocionarán y te cautivarán!", image: "Marvel", tag: 0),
            Page(name:  "Encuentra tus Favoritas", description: "Explora y busca tus películas favoritas utilizando nuestras herramientas de búsqueda avanzada. Marca las películas que te encantan y crea tu propia lista personalizada.", image: "Inside", tag: 1),
            Page(name:  "Mantente al Día", description: "No te pierdas nunca más una nueva película. Nuestra aplicación te mantendrá informado sobre los próximos lanzamientos y te proporcionará detalles exclusivos directamente de The Movie DB.", image: "Up", tag: 2)
        ]
    }
}
