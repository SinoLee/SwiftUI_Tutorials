//
//  RecipeModel.swift
//  RecipeBook
//
//  Created by Taeyoun Lee on 2022/03/29.
//

import Foundation
import SwiftUI

enum Category: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case breakfast = "Breakfast"
    case soup = "Soup"
    case salad = "Salad"
    case appetizer = "Appetizer"
    case main = "Main"
    case side = "Side"
    case desert = "Dessert"
    case snack = "Snack"
    case drink = "Drink"
}

struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let description: String
    let ingredients: String
    let directions: String
    let category: Category.RawValue
    let detePublished: String
    let url: String
}

extension Recipe {
    static let all: [Recipe] = [
        // 0
        Recipe(name: "Creamy Carrot Soup",
               image: "https://www.forksoverknives.com/wp-content/uploads/fly-images/98892/Creamy-Carrot-Soup-for-Wordpress-360x270-c.jpg",
               description: "This bold-hued soup is perfectly sweet and seriously comforting. Peeling the red bell pepper helps make this carrot soup extra silky. Dress it up with a drizzle of rich cashew cream, pomegranate seeds, and chopped fresh parsley for a festive fall presentation.",
               ingredients: """
               ¼ cup cashews
               1 medium onion, cut into ½-inch dice (2 cups)
               1½ pounds carrots, cut into ½-inch dice (3½ cups)
               1 red bell pepper, peeled and cut into ½-inch dice (1 cup)
               1 sprig fresh rosemary
               1 sprig fresh thyme
               1 large fresh sage leaf
               4 cloves garlic, minced
               1 tablespoon lemon juice
               Sea salt and freshly ground black pepper or cayenne pepper, to taste
               ½ cup fresh pomegranate seeds
               2 tablespoons finely chopped fresh parsley
               """,
               directions: """
               1.In a small bowl, cover the cashews with ½ cup hot water; let soak 20 minutes. Transfer cashews and remaining liquid to a blender; blend until smooth and creamy. Set aside.
               2.In a saucepan, combine onion, carrots, bell pepper, rosemary, thyme, sage, and garlic. Add ½ cup water and sauté over medium heat for 15 to 20 minutes, or until carrots are tender.
               3.Remove pan from heat. Let vegetables cool for 10 minutes; then remove rosemary sprigs and thyme leaf.
               4.Transfer sauteed vegetables to a blender, and puree to a smooth paste. Return pureed vegetables to saucepan and add 3 cups water and 1 tablespoon lemon juice. Season with salt and pepper. Bring soup to boiling.
               5.To serve, place soup in individual bowls, drizzle with cashew cream, and garnish with pomegranate seeds and parsley.
               """,
               category: "Soup",
               detePublished: "2019-11-11",
               url: "https://www.forksoverknives.com/recipes/vegan-soups-stews/creamy-carrot-soup/"),
        // 1
        Recipe(name: "Kale, Apple, and Quinoa Salad",
               image: "https://www.forksoverknives.com/wp-content/uploads/fly-images/98341/Kale-Apple-Quinoa-Salad-wordpress-360x270-c.jpg",
               description: """
               Each bite of this colorful salad is filled with the flavors of favorite fall ingredients such as apples, butternut squash, and pumpkin seeds. For optimum freshness and texture, wait to add the dressing until just before serving.

               Note that this recipe calls for cooked quinoa, so have that ready to go: For 1½ cups cooked quinoa, rinse and drain ½ cup quinoa; cook according to package directions; and drain if needed. Check out our Grains Cooking Guide for more tips on prepping grains like a pro.
               """,
               ingredients: """
               2 cups ¾-inch pieces peeled butternut squash
               ¼ cup pumpkin seeds
               ¼ teaspoon ground cinnamon
               1 lemon
               2 tablespoons pure maple syrup
               1 tablespoon Dijon mustard
               3 cups stemmed and chopped kale
               1½ cups cooked quinoa
               1 cup chopped apple
               ½ cup sliced green onions
               Sea salt and freshly ground black pepper, to taste
               """,
               directions: """
               1.Preheat oven to 400°F. Line a 15×10-inch baking pan with parchment paper or a silicone baking mat. Arrange squash in the prepared baking pan. Roast 20 to 25 minutes or until squash is tender, brushing lightly with water if squash starts to look dry. Cool slightly on a wire rack.
               2.Meanwhile, in a small bowl toss together pumpkin seeds and ½ teaspoon water; sprinkle with cinnamon. Place pumpkin seeds in a small, shallow baking pan. Roast 5 minutes or until lightly toasted; cool.
               3.For dressing, remove 1 teaspoon zest and squeeze 2 tablespoons juice from lemon. In a small bowl whisk together lemon zest and juice, maple syrup, and mustard.
               4.In a large bowl combine kale, quinoa, apple, green onions, and roasted squash. Add dressing; toss to coat. Season with salt and pepper. Top with pumpkin seeds.
               """,
               category: "Salad",
               detePublished: "2019-10-22",
               url: "https://www.forksoverknives.com/recipes/vegan-salads-sides/kale-apple-and-quinoa-salad/"),
        // 2
        Recipe(name: "Kale Bruschetta",
               image: "https://www.forksoverknives.com/wp-content/uploads/fly-images/25202/Kale-Bruschetta-WP-360x270-c.jpg",
               description: """
               We adore this as an appetizer, and so does everyone else. It is always the first empty platter at our holiday party. No one knows it is plant-based; they just know it is so yummy.

               From The Prevent and Reverse Heart Disease Cookbook
               """,
               ingredients: """
               1 bunch kale
               1 loaf fresh 100% whole-grain bread, sliced
               ½ cup Cannellini Bean Sauce
               1 cup grape tomatoes, halved
               balsamic glaze
               """,
               directions: """
               1.Place the kale leaves in a large pot of boiling water. Cover and cook until tender, about 5 minutes. Drain in a colander, then squeeze out any extra liquid with your hands (you don’t want soggy bread).
               2.Toast 8 pieces of bread, and place them on a handsome serving platter.
               3.Spread a tablespoon of the Cannellini Bean Sauce on the toasted bread, then cover with a layer of kale and top with a scattering of grape tomatoes. Drizzle generously with the balsamic glaze, and grab one for yourself before they all disappear.
               """,
               category: "Appetizer",
               detePublished: "2015-06.28",
               url: "https://www.forksoverknives.com/recipes/vegan-snacks-appetizers/kale-bruschetta/"),
        // 3
        Recipe(name: "Vegetable Potpie",
               image: "https://www.forksoverknives.com/wp-content/uploads/fly-images/98816/Vegetable-pot-pie-for-wordpress-360x270-c.jpg",
               description: """
               This eye-popping potpie makes a hearty addition to a holiday menu or an impressive entree any time of year. Note that this recipe calls for whole wheat pizza dough: Make some using our 10-minute recipe or look for oil-free options at the store (Trader Joe’s makes a good one).
               """,
               ingredients: """
               3 cups sliced fresh cremini mushrooms
               1 cup sliced carrots
               ½ cup sliced celery
               3¼ cups low-sodium vegetable broth
               2 cups ½-inch pieces peeled butternut squash
               1½ cups frozen whole pearl onions
               1 teaspoon chopped fresh thyme
               1 bay leaf
               1 15-oz. can no-salt-added chickpeas, rinsed and drained
               1 cup frozen peas
               1 cup frozen corn
               3 tablespoons all-purpose flour
               Sea salt and freshly ground black pepper, to taste
               1 recipe Homemade Oil-Free Pizza Dough or 1 lb. refrigerated whole wheat pizza dough
               1 tablespoon unsweetened plant milk, such as almond, soy, cashew, or rice
               """,
               directions: """
               1.Preheat oven to 425°F. For filling, in a 4-qt. saucepan cook mushrooms, carrots, and celery over medium 3 to 4 minutes, stirring occasionally and adding water, 1 to 2 Tbsp. at a time, as needed to prevent sticking. Add 3 cups of the broth, the squash, onions, thyme, and bay leaf. Bring to boiling; reduce heat. Simmer, covered, 5 minutes or until vegetables are nearly tender. Stir in chickpeas, peas, and corn.
               2.Whisk together flour and the remaining ¼ cup broth; stir into vegetables. Cook until thick and bubbly, stirring occasionally. Remove from heat. Remove and discard bay leaf. Season filling with salt and pepper. Spread into a 2½- to 3-qt. round or oval baking dish.
               3.On a lightly floured surface, roll Homemade Oil-Free Pizza Dough into a circle or oval slightly larger than the dish. Cut several slits in dough; place on filling and seal. Brush with milk. Bake 15 minutes or until crust is browned and filling is bubbly.
               """,
               category: "Main",
               detePublished: "2019-11-05",
               url: "https://www.forksoverknives.com/recipes/vegan-baked-stuffed/vegetable-pot-pie/"),
        // 4
        Recipe(name: "Red Lentil Loaf with Smoky Tomato Sauce Recipe",
               image: "https://www.forksoverknives.com/wp-content/uploads/fly-images/85949/Red-Lentil-Loaf-360x270-c.jpg",
               description: """
               Infinitely healthier than meat-based meatloaf and just as delicious, this savory vegan meatloaf recipe makes a welcome meal on a chilly night. Try it in next-day sandwiches, too. The smoky-sweet sauce, made with taco seasoning, smoked paprika, mustard, and Date Paste, comes together in just 10 minutes.
               """,
               ingredients: """
               2 medium onions, chopped (2 cups)
               1 cup red lentils, rinsed and drained
               2 fresh poblano chile peppers, seeded and chopped (1 cup)
               3 cloves garlic, minced
               1½ teaspoons chopped fresh Mexican oregano
               2 cups cooked short grain brown rice
               ¼ cup cornmeal
               ¼ cup finely chopped fresh cilantro
               2 tablespoons lime juice
               1 teaspoon sea salt
               1 14.5-oz. can fire-roasted tomatoes, undrained
               ¼ cup Date Paste
               1 tablespoon smoked paprika
               1 teaspoon taco seasoning
               ½ teaspoon yellow mustard
               """,
               directions: """
               1.Preheat oven to 375°F. Line a 9×5-inch loaf pan with parchment paper.
               2.In a skillet combine onions, lentils, poblanos, garlic, and oregano. Stir in 1½ cups water. Bring to boiling; reduce heat. Simmer, covered, 20 minutes or until lentils are tender and water is absorbed, stirring occasionally. Stir in rice, cornmeal, cilantro, lime juice, and salt. Lightly pat mixture into the prepared loaf pan; flatten top.
               3.For sauce, in a blender combine tomatoes, date paste, paprika, taco seasoning, mustard, and ½ cup water. Cover and blend until smooth. Transfer to a saucepan. Bring to boiling; reduce heat. Simmer, uncovered, 10 minutes or until slightly thick.
               4.Spoon ¾ cup of the sauce over loaf. Bake 30 to 40 minutes or until sauce looks dark and dry. Cool on a wire rack 15 minutes. Slice loaf and serve with the remaining sauce.
               """,
               category: "Main",
               detePublished: "2019.03.19",
               url: "https://www.forksoverknives.com/recipes/vegan-baked-stuffed/red-lentil-loaf-recipe-smoky-tomato-sauce/"),
        // 5
        Recipe(name: "Roasted Root Vegetable Medley",
               image: "https://www.forksoverknives.com/wp-content/uploads/fly-images/158614/Roasted-Root-Vegetable-Medley-wordpress-360x270-c.jpg",
               description: """
               This simple side dish celebrates root vegetables in all their colorful, flavorful glory. The key to evenly roasting firmer veggies, such as carrots and potatoes, without adding fat is to steam them first before mixing them with the soft vegetables. Serve this vibrant recipe at your Thanksgiving feast, or enjoy it as a side with a warm bowl of soup.
               """,
               ingredients: """
               4 assorted-color carrots, peeled and cut into 3-inch pieces
               6 fingerling potatoes, halved if large
               2 small parsnips, peeled, halved crosswise, and quartered lengthwise
               1 turnip, peeled and cut into sixths
               1 rutabaga, peeled and cut into thick wedges
               1 medium beet, peeled and cut into 1-inch wedges
               3 tablespoons balsamic vinegar
               2 tablespoons lemon juice
               2 tablespoons pure maple syrup
               2 tablespoons arrowroot powder
               1 teaspoon dried rosemary
               10 cloves garlic, minced
               1 fennel bulb, fronds reserved for garnish and bulb cut into 1-inch-thick wedges
               1 cup pearl onions or 2 small yellow onions cut into 1-inch-thick wedges
               1 small head celeriac, peeled and cut into large wedges
               6 large white or cremini mushrooms, quartered
               ¼ teaspoon sea salt
               ¼ teaspoon freshly ground black pepper
               """,
               directions: """
               1.Preheat oven to 375°F. Working in batches if necessary, place the first six ingredients (through beet) in a steamer basket in a large saucepan. Add water to saucepan to just below basket. Bring to boiling. Steam, covered, 5 to 7 minutes or until vegetables are just tender.
               2.In a large bowl whisk together the next six ingredients (through garlic). Add steamed vegetables, fennel, onions, celeriac, and mushrooms. Toss to coat.
               3.In a large rimmed baking sheet spread vegetables in a single layer. Roast 15 minutes. Remove from oven and carefully stir. Roast 10 to 15 minutes more or until vegetables are tender and lightly browned.
               4.Season with salt and pepper. Sprinkle with chopped reserved fennel fronds. Serve warm.
               """,
               category: "Side",
               detePublished: "2021-10-05",
               url: "https://www.forksoverknives.com/recipes/vegan-salads-sides/roasted-root-vegetable-medley/"),
        // 6
        Recipe(name: "Raspberry Truffle Brownies",
               image: "https://www.forksoverknives.com/wp-content/uploads/fly-images/22720/Raspberry-Brownies-300kb-360x270-c.jpg",
               description: """
               These dense, fudgy, vegan brownies have loads of melt-in-your-mouth raspberry yumminess. Frozen berries actually will work better here because the dough is very stiff, and frozen berries are easier to fold in.
               """,
               ingredients: """
               4 ounces unsweetened chocolate, chopped
               ½ cup raspberry jam
               ½ cup evaporated cane juice or cane sugar
               ½ cup unsweetened applesauce
               2 teaspoons pure vanilla extract
               ½ teaspoon almond extract
               1½ cups whole wheat pastry flour
               ¼ cup unsweetened cocoa powder
               ¼ teaspoon baking powder
               ½ teaspoon baking soda
               ¼ teaspoon salt
               1 cup raspberries, frozen or fresh
               """,
               directions: """
               1.Preheat the oven to 350ºF. Line an 8 x 8-inch pan with a 10-inch square of parchment paper or have ready an 8 x 8-inch nonstick or silicone baking pan.
               2.Melt the chocolate in either a double boiler or the microwave. Set aside.
               3.In a large mixing bowl, vigorously mix together the jam, sweetener, and applesauce. Stir in the vanilla, almond extract, and the melted chocolate.
               4.Sift in the flour, cocoa powder, baking powder, baking soda, and salt. Mix very well until a stiff dough forms. Fold in the raspberries.
               5.Spread the mixture into the prepared pan. It will be very thick; you’ll need to use your hands to even the batter out in the pan.
               6.Bake the brownies for 16 to 18 minutes. Remove them from the oven and let cool completely. These taste especially good and fudgy after being refrigerated for a few hours.

               Note: The brownies are still very gooey after the baking time is complete, but don’t worry—that’s what you want with brownies! Gooey out of the oven means that they will be nice and fudgy when they cool. Allow them to cool completely and chill in the fridge for a few hours for best results.
               """,
               category: "Dessert",
               detePublished: "2014-02-10",
               url: "https://www.forksoverknives.com/recipes/vegan-desserts/raspberry-truffle-brownies/"),
    ]
}
