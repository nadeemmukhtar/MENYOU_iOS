//
//  Defaults.swift
//  MENYOU
//
//  Created by Appcrates_Dev on 7/29/20.
//  Copyright © 2020 Appcrates_Dev. All rights reserved.
//

import Foundation

struct Resturant: Identifiable{

    let id: Int
    let title : String
    let image : String
    let type : String
    let discount : String
    
    static let items: [Resturant] = [
        .init(
            id: 0,
            title: "The Butchers daughter",
            image: "the-butchers-daughter-img",
            type: "Vegetarian",
            discount: "80"
        ),
        .init(
            id: 1,
            title: "Gjelina",
            image: "gjelina-img",
            type: "American",
            discount: "70"
        ),
        .init(
            id: 2,
            title: "South End",
            image: "south-end-img",
            type: "Pizza",
            discount: "70"
        ),
        .init(
            id: 3,
            title: "zinque",
            image: "zinque-img",
            type: "French",
            discount: "60"
        ),
        .init(
            id: 4,
            title: "Scopg",
            image: "zinque-img",
            type: "French",
            discount: "60"
        )
    ]
    
    static let items1: [Resturant] = [
        .init(
            id: 0,
            title: "South End",
            image: "south-end-img",
            type: "Pizza",
            discount: "70"
        ),
        .init(
            id: 1,
            title: "zinque",
            image: "zinque-img",
            type: "French",
            discount: "60"
        ),
        .init(
            id: 2,
            title: "Scopg",
            image: "zinque-img",
            type: "French",
            discount: "60"
        )
    ]
    
    static let items2: [Resturant] = [
        .init(
            id: 1,
            title: "Gjelina",
            image: "gjelina-img",
            type: "American",
            discount: "70"
        ),
        .init(
            id: 2,
            title: "zinque",
            image: "zinque-img",
            type: "French",
            discount: "60"
        ),
        .init(
            id: 3,
            title: "Scopg",
            image: "zinque-img",
            type: "French",
            discount: "60"
        )
    ]
}


struct Favorite: Identifiable {

    let id: Int
    let title : String
    let image : String
    let type : String
    let discount : String
    
    static let items: [Favorite] = [
        .init(
            id: 0,
            title: "In-N-Out",
            image: "in-n-out-img",
            type: "American",
            discount: "100"
        ),
        .init(
            id: 1,
            title: "Lemonade Restaurant",
            image: "lemonade-img",
            type: "Healthy",
            discount: "92"
        ),
        .init(
            id: 2,
            title: "South End",
            image: "south-end-img",
            type: "Pizza",
            discount: "70"
        )
    ]
}

struct Food: Identifiable {

    let id: Int
    let title : String
    let image : String
    let detail : String
    let price : String
    
    static let items: [Food] = [
        .init(
            id: 0,
            title: "Lemon Shrimp",
            image: "in-n-out-img",
            detail: "16 shrimp seasoned in a lemon zest dressing",
            price: "12.99"
        ),
        .init(
            id: 1,
            title: "Avocado Burger",
            image: "lemonade-img",
            detail: "An american classic but with a twist.",
            price: "18.50"
        ),
        .init(
            id: 2,
            title: "Veggie Kabob",
            image: "south-end-img",
            detail: "All the veggies you can eat.",
            price: "15.00"
        )
    ]
    
    static let items1: [Food] = [
        .init(
            id: 0,
            title: "Avocado Burger",
            image: "lemonade-img",
            detail: "An american classic but with a twist.",
            price: "18.50"
        ),
        .init(
            id: 1,
            title: "Veggie Kabob",
            image: "south-end-img",
            detail: "All the veggies you can eat.",
            price: "15.00"
        )
    ]
    
    static let items2: [Food] = [
        .init(
            id: 0,
            title: "Lemon Shrimp",
            image: "in-n-out-img",
            detail: "16 shrimp seasoned in a lemon zest dressing",
            price: "12.99"
        ),
        .init(
            id: 1,
            title: "Veggie Kabob",
            image: "south-end-img",
            detail: "All the veggies you can eat.",
            price: "15.00"
        )
    ]
}
