//
//  BrandDomainResolve.swift
//  FinSub
//
//  Created by Michael on 12/03/26.
//

import Foundation

struct BrandDomainResolve{
    private static let mapping: [String: String] = [
        // ========== STREAMING VIDEO ==========
        "netflix": "netflix.com",
        "netflix premium": "netflix.com",
        "disney": "disneyplus.com",
        "disney plus": "disneyplus.com",
        "disney+": "disneyplus.com",
        "hulu": "hulu.com",
        "hulu plus": "hulu.com",
        "amazon prime": "amazon.com", // Prime Video
        "prime video": "amazon.com",
        "paramount": "paramountplus.com",
        "paramount plus": "paramountplus.com",
        "peacock": "peacocktv.com",
        "max": "max.com", // HBO Max
        "hbo": "max.com",
        "hbo max": "max.com",
        "apple tv": "apple.com", // Apple TV+
        "apple tv plus": "apple.com",
        "espn": "espn.com", // ESPN+
        "espn plus": "espn.com",
        
        // ========== MUSIC & AUDIO ==========
        "spotify": "spotify.com",
        "spotify premium": "spotify.com",
        "apple music": "apple.com",
        "youtube music": "youtube.com",
        "tidal": "tidal.com",
        "deezer": "deezer.com",
        "soundcloud": "soundcloud.com", // SoundCloud Go
        "audible": "audible.com", // Audiobooks
        
        // ========== SOFTWARE & CLOUD ==========
        "adobe": "adobe.com", // Creative Cloud
        "adobe creative cloud": "adobe.com",
        "photoshop": "adobe.com",
        "microsoft 365": "microsoft.com",
        "office 365": "microsoft.com",
        "dropbox": "dropbox.com",
        "google drive": "google.com",
        "google one": "google.com",
        "icloud": "apple.com",
        "icloud plus": "apple.com",
        "figma": "figma.com",
        "canva": "canva.com", // Canva Pro
        "notion": "notion.so",
        
        // ========== FOOD & MEAL KITS ==========
        "hellofresh": "hellofresh.com",
        "hello fresh": "hellofresh.com",
        "blue apron": "blueapron.com",
        "butcherbox": "butcherbox.com",
        "butcher box": "butcherbox.com",
        "dollar shave club": "dollarshaveclub.com",
        "hungryroot": "hungryroot.com",
        "factor": "factor75.com", // Factor Meals
        "factor75": "factor75.com",
        "daily harvest": "dailyharvest.com",
        "thrive market": "thrivemarket.com",
        "imperfect foods": "imperfectfoods.com",
        "misfits market": "misfitsmarket.com",
        
        // ========== SNACKS & BEVERAGES ==========
        "graze": "graze.com",
        "beer52": "beer52.com",
        "brewser": "brewser.beer",
        "cocktail kit": "tipplebox.com", // Tipple Box
        "tipplebox": "tipplebox.com",
        "cocktail box": "tipplebox.com",
        "trade coffee": "tradecoffee.com",
        "atlas coffee": "atlascoffeeclub.com",
        "winc": "winc.com", // Wine subscription
        "bright cellars": "brightcellars.com",
        
        // ========== HEALTH & WELLNESS ==========
        "peloton": "onepeloton.com",
        "apple fitness": "apple.com", // Fitness+
        "fitness plus": "apple.com",
        "classpass": "classpass.com",
        "headspace": "headspace.com",
        "calm": "calm.com",
        "betterhelp": "betterhelp.com",
        "therabox": "therabox.com",
        "vitamin": "careof.com", // Care/of
        "careof": "careof.com",
        "ritual": "ritual.com",
        
        // ========== FASHION & BEAUTY ==========
        "stitch fix": "stitchfix.com",
        "meundies": "meundies.com",
        "oddballs": "myoddballs.com",
        "bombas": "bombas.com",
        "ipsy": "ipsy.com",
        "boxycharm": "boxycharm.com",
        "birchbox": "birchbox.com",
        "allbirds": "allbirds.com", // Shoes
        "rent the runway": "renttherunway.com",
        "nuuly": "nuuly.com", // Urban Outfitters rental
        "haverdash": "haverdash.com",
        "le teinte": "leteinte.com", // Foundation subscription
        
        // ========== PETS ==========
        "barkbox": "barkbox.com",
        "bark box": "barkbox.com",
        "meowbox": "meowbox.com",
        "chewy": "chewy.com", // Chewy Autoship
        "petco": "petco.com",
        "petsmart": "petsmart.com",
        
        // ========== KIDS & EDUCATION ==========
        "kiwico": "kiwico.com",
        "kiwi co": "kiwico.com",
        "little passports": "littlepassports.com",
        "lovevery": "lovevery.com", // Play kits
        "abcmouse": "abcmouse.com",
        "brilliant": "brilliant.org",
        "masterclass": "masterclass.com",
        "skillshare": "skillshare.com",
        "coursera": "coursera.org", // Coursera Plus
        "udemy": "udemy.com", // Personal plan
        
        // ========== BOOKS & LITERATURE ==========
        "book of the month": "bookofthemonth.com",
        "bookofthemonth": "bookofthemonth.com",
        "scribd": "scribd.com",
        "blinkist": "blinkist.com",
        "everand": "everand.com", // Scribd's new name
        "kindle unlimited": "amazon.com",
        "amazon kindle": "amazon.com",
        
        // ========== PRODUCTIVITY & BUSINESS ==========
        "linkedin premium": "linkedin.com",
        "linkedin": "linkedin.com",
        "slack": "slack.com", // Slack Pro
        "zoom": "zoom.us", // Zoom Pro
        "miro": "miro.com",
        "asana": "asana.com", // Asana Premium
        "trello": "trello.com", // Trello Premium
        "evernote": "evernote.com",
        "bear": "bear.app", // Bear Pro
        
        // ========== GAMING ==========
        "xbox game pass": "xbox.com",
        "xbox": "xbox.com",
        "playstation plus": "playstation.com",
        "ps plus": "playstation.com",
        "nintendo switch online": "nintendo.com",
        "nintendo": "nintendo.com",
        "ea play": "ea.com",
        "ubisoft plus": "ubisoft.com",
        "apple arcade": "apple.com",
        "google stadia": "google.com", // RIP but tetap ada
        "geforce now": "nvidia.com",
        
        // ========== TRANSPORTATION ==========
        "uber one": "uber.com",
        "uber": "uber.com",
        "lyft": "lyft.com", // Lyft Pink
        "bluesharing": "bluebikes.com", // Bike sharing
        
        // ========== NEWS & MEDIA ==========
        "nytimes": "nytimes.com",
        "new york times": "nytimes.com",
        "washington post": "washingtonpost.com",
        "wsj": "wsj.com",
        "wall street journal": "wsj.com",
        "the economist": "economist.com",
        "medium": "medium.com",
        "substack": "substack.com",
        "patreon": "patreon.com",
        
        // ========== RETAIL & MEMBERSHIP ==========
        "amazon": "amazon.com", // Amazon Prime
        "amazon prime": "amazon.com",
        "walmart plus": "walmart.com",
        "walmart+": "walmart.com",
        "costco": "costco.com", // Membership
        "sams club": "samsclub.com",
        "target": "target.com", // Target Circle 360
        "shopify": "shopify.com", // Shopify subscription
        
        // ========== TOILETRIES & HOUSEHOLD ==========
        "who gives a crap": "whogivesacrap.org",
        "whogivesacrap": "whogivesacrap.org",
        "quip": "quip.com", // Toothbrush
        "harrys": "harrys.com", // Razors
        "billie": "billie.com", // Razors
        "estrid": "estrid.com", // Razors
        "native": "nativecos.com", // Deodorant
        "function of beauty": "functionofbeauty.com",
        "grove collaborative": "grove.com",
        
        // ========== PLANTS & GARDEN ==========
        "bloomsy": "bloomsy.com",
        "the sill": "thesill.com", // Plant subscription
        "leafbox": "leafbox.com",
        "cheryl's": "cheryls.com", // Cookies
        
        // ========== INTERNATIONAL ==========
        "viki": "viki.com", // Korean drama
        "iqiyi": "iqiyi.com", // Chinese streaming
        "we tv": "wetv.vip",
        "bilibili": "bilibili.com",
        "crunchyroll": "crunchyroll.com", // Anime
        "funimation": "funimation.com"
    ]
    
    
    static func domain (for brand: String) -> String? {
        let lowercased = brand.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        if let domain = mapping[lowercased] {
            return domain
        }
        return lowercased + ".com"
    }
}
