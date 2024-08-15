List<String> parentCategories = [
  "Vegetables",
  "Fruits",
  "Grains",
  "Herbs and Spices",
  "Nuts and Seeds",
  "Legumes",
  "Flowers and Ornamentals",
  "Organic and Specialty Crops",
  "Livestock",
  "Poultry",
  "Aquaculture",
  "Dairy Products",
  "Eggs",
  "Beekeeping",
  "Fibers",
  "Meat Products",
  "Pets and Companion Animals",
  "Processed Foods",
  "Plant-Based Products",
  "Animal-Based Products"
];
List<Map<String, dynamic>> products = [
   {
    "productName": "Fresh Yam Tubers",
    "description":
        "Our fresh yam tubers are harvested from the rich soils of Ghana, ensuring a hearty and nutritious addition to your meals. These yams are perfect for boiling, frying, or making traditional dishes like yam pottage. Enjoy the starchy goodness and rich flavor that is a staple in Ghanaian cuisine.",
    "parentCategory": "Roots and Tubers",
    "images": [
      "https://www.researchgate.net/profile/Olugbenga-Adeoluwa/publication/312231378/figure/fig4/AS:668653368385542@1536430794387/Yam-tubers-Picture-Olugbenga-AdeOluwa_Q320.jpg",
      "https://housefood.africa/wp-content/uploads/2022/05/yams.jpeg",
      "https://www.africasflavour.com/wp-content/uploads/2020/08/Tubers-of-Yam.jpg"
    ]
  },
  {
    "productName": "Organic Cocoa Beans",
    "description":
        "Experience the rich, aromatic flavor of our organic cocoa beans. Grown in the lush regions of Ghana, these beans are perfect for making high-quality chocolate and other cocoa products. Rich in antioxidants and natural goodness, they are a true taste of Ghana's agricultural heritage.",
    "parentCategory": "Fruits",
    "images": [
      "https://images-cdn.ubuy.co.in/64b5db9afad81322ff10493f-organic-cacao-nibs-raw-whole-sweet.jpg",
      "https://d2akgcowytz7ek.cloudfront.net/cacao_beans_biologikoi_raw.jpg?mtime=20200110105217&focal=none",
      "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Cocoa_Pods.JPG/200px-Cocoa_Pods.JPG"
    ]
  },
  {
    "productName": "Juicy Pineapple Slices",
    "description":
        "Our juicy pineapple slices are handpicked from the finest pineapple farms in Ghana. Sweet, tangy, and bursting with tropical flavor, these pineapples are perfect for snacking, desserts, or adding a refreshing touch to your dishes. Enjoy the natural sweetness and health benefits of this tropical delight.",
    "parentCategory": "Fruits",
    "images": [
      "https://www.proagrimedia.com/content/uploads/2023/03/vecteezy_pile-of-fresh-pineapples-for-sale-in-the-market_7061481_194-scaled.jpg",
      "https://thumbs.dreamstime.com/b/fresh-pineapple-tree-farm-69434201.jpg",
      "https://cdn2.veltra.com/ptr/20161020024645_1019550214_10433_0.png?imwidth=550&impolicy=custom"
    ]
  },
  {
    "productName": "Smoked Tilapia Fish",
    "description":
        "Our smoked tilapia fish is a delicacy that brings the authentic taste of Ghanaian cuisine to your table. Carefully smoked to perfection, this fish is rich in flavor and ideal for various traditional dishes like soups and stews. Enjoy the unique, smoky taste that is a favorite in many households.",
    "parentCategory": "Aquaculture",
    "images": [
      "https://i.ytimg.com/vi/haz6wfs31TM/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBkbg8UV90JNO419nrg_QI5-84MOg",
      "https://www.theblackpeppercorn.com/wp-content/uploads/2018/06/Teriyaki-Smoked-Tilapia-overhead.jpg",
      "https://www.thespruceeats.com/thmb/UseUXnvRNzrzCb7VXxNggpzf0HU=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/smoked-tilapia-recipe-336138-Step_05-64f587ec250f4386af9175745c52a83a.jpg"
    ]
  },
  {
    "productName": "Fresh Plantain Bunch",
    "description":
        "Enjoy the versatile and delicious taste of our fresh plantain bunch. Perfect for frying, boiling, or grilling, plantains are a staple in many Ghanaian dishes. Rich in vitamins and minerals, they offer a healthy and satisfying addition to your meals.",
    "parentCategory": "Fruits",
    "images": [
      "https://gingerandseasalt.com/wp-content/uploads/2023/07/bunch-plantain.jpg",
      "https://www.iyalojadirect.com/wp-content/uploads/2021/02/Plantain.jpg",
      "https://miro.medium.com/v2/resize:fit:528/1*v4PwwsYMeY12AoBycwEKKw.jpeg"
    ]
  },
  {
    "productName": "Organic Shea Butter",
    "description":
        "Our organic shea butter is a natural moisturizer made from the nuts of the shea tree. Rich in vitamins A and E, it provides deep hydration and nourishment for the skin. Ideal for skincare routines and DIY beauty products, this shea butter is a must-have for natural beauty enthusiasts.",
    "parentCategory": "Plant-Based Products",
    "images": [
      "https://neogric.com/wp-content/uploads/2021/03/Neogric-Shea-Butter-Redefining-The-Agric-Supply-Chain-In-Africa-2.jpg",
      "https://media.springernature.com/lw685/springer-static/image/chp%3A10.1007%2F978-3-030-30314-3_107/MediaObjects/417043_1_En_107_Figa_HTML.jpg",

    ]
  },
  {
    "productName": "Rich Palm Oil",
    "description":
        "Our rich palm oil is extracted from the finest palm fruits, offering a vibrant red color and rich flavor. This oil is a staple in many traditional dishes, providing a unique taste and numerous health benefits. Perfect for cooking, frying, and adding depth to your favorite recipes.",
    "parentCategory": "Plant-Based Products",
    "images": [
      "https://media.post.rvohealth.io/wp-content/uploads/2020/08/AN405-palm-oil-fruit-732x549-Thumb-1-732x549.jpg",
      "https://craftiviti.com/cdn/shop/products/f42fb39642f56489a4596522c6e01667.jpg?v=1625641207",
      "https://i0.wp.com/www.globaltrademag.com/wp-content/uploads/2020/01/shutterstock_276184139.jpg?fit=699%2C393&ssl=1"
    ]
  },
  {
    "productName": "Fresh Okra Pods",
    "description":
        "Our fresh okra pods are a nutritious and versatile vegetable perfect for various dishes. Known for their unique texture and health benefits, okra pods are ideal for making soups, stews, and stir-fries. Enjoy the fresh, crisp taste and numerous nutritional benefits of this popular vegetable.",
    "parentCategory": "Vegetables",
    "images": [
      "https://victorygardeners.com/wp-content/uploads/2019/03/clemson-spineless-green-okra-e1616727779169.jpg",
      "https://harvesttotable.com/wp-content/uploads/2016/08/Okra-pods-on-plant-1.jpg",
    ]
  },
  {
    "productName": "Sweet Cassava Tubers",
    "description":
        "Our sweet cassava tubers are harvested from fertile soils, ensuring a delicious and versatile root vegetable. Cassava is perfect for making fufu, a traditional Ghanaian dish, or for frying and baking. Enjoy the sweet, starchy taste and nutritional benefits of this popular tuber.",
    "parentCategory": "Roots and Tubers",
    "images": [
      "https://flyingdragonnursery.co.nz/cdn/shop/files/1509792178-178860260.jpg?v=1698903550&width=165",
      "https://m.media-amazon.com/images/I/71oLiDBDZ9L._AC_UF894,1000_QL80_.jpg",
      "https://storage.googleapis.com/cgiarorg/2020/01/07f368c0-dsc_6389.jpg"
    ]
  },
  
  {
    "productName": "Organic Farm-Fresh Spinach Leaves",
    "description":
        "Our organic farm-fresh spinach leaves are harvested at the peak of their flavor and nutritional value. These vibrant green leaves are perfect for salads, smoothies, and cooking, offering a rich source of vitamins and minerals that support a healthy lifestyle. Enjoy the crisp, clean taste of nature's bounty with every bite.",
    "parentCategory": "Vegetables",
    "images": [

      "https://orgboxthailand.com/wp-content/uploads/2018/02/spinach-2-247x300.png",
      "https://www.melissas.com/cdn/shop/products/image-of-organic-spinach-organics-14763694293036_600x600.jpg?v=1617050882",
      "https://www.highmowingseeds.com/media/catalog/product/cache/6cbdb003cf4aae33b9be8e6a6cf3d7ad/2/8/2887.jpg"
    ]
  },
  {
    "productName": "Juicy Sweet Blueberry Bites",
    "description":
        "Experience the burst of sweetness with our juicy sweet blueberry bites. Handpicked from the finest bushes, these blueberries are packed with antioxidants and vitamins, making them a delightful and healthy snack. Perfect for adding to cereals, yogurts, or enjoying straight from the box, these berries are a treat you can't resist.",
    "parentCategory": "Fruits",
    "images": [
      "https://img.freepik.com/free-vector/fresh-blueberries-with-water-drops-green-leaves-white-background-realistic-vector-illustration_1284-77363.jpg",
      "https://www.bhg.com/thmb/N1BSxAzrCnHJxZ7VlA5v5_9iPYw=/1244x0/filters:no_upscale():strip_icc()/assorted-berries-table-b58e8eb0-fe2e4a0b8f064fb79ae935231007dc99.jpg",
      "https://static.independent.co.uk/s3fs-public/thumbnails/image/2013/07/27/20/30-blueberries-JA.jpg?width=1200&height=1200&fit=crop"
    ]
  },
  {
    "productName": "Premium Golden Harvest Wheat",
    "description":
        "Our premium golden harvest wheat is grown with care and harvested at its prime to ensure maximum quality and flavor. Ideal for baking bread, making pasta, or as a nutritious addition to any meal, this wheat offers a wholesome, hearty taste that's rich in fiber and essential nutrients.",
    "parentCategory": "Grains",
    "images": [
      "https://img.lazcdn.com/g/p/90536e9980990fbfc5c16105235e5a1d.png_720x720q80.png",
      "https://standishmilling.com/cdn/shop/files/50lbwheatgrain_1024x1024.jpg?v=1686928987",
      "https://morningchores.com/wp-content/uploads/2020/05/Growing-Wheat-Varieties-Planting-Guide-Care-Problems-and-Harvest-FB.jpg"
    ]
  },
  {
    "productName": "Aromatic Fresh Basil Herb Bouquet",
    "description":
        "Indulge in the fragrant aroma and vibrant flavor of our aromatic fresh basil herb bouquet. Perfect for enhancing your culinary creations, these basil leaves are freshly picked and packed to preserve their natural oils and freshness. Ideal for making pesto, garnishing pizzas, or adding a fresh touch to salads and pasta dishes.",
    "parentCategory": "Herbs and Spices",
    "images": [
      "https://www.themediterraneandish.com/wp-content/uploads/2021/08/Basil-1.jpg",
      "https://www.bluebananadirect.co.uk/cdn/shop/products/31260B81-056B-466A-A2BA-6813F0857E30_1_201_a_2048x.jpg?v=1596457131",
      "https://www.diggers.com.au/cdn/shop/products/organic-basil-sweet-s303_bcac4ae8-9324-42f1-8a08-8526b7866834_2048x.jpg?v=1637121545",
     
    ]
  },
  {
    "productName": "Nutrient-Rich Raw Almond Delight",
    "description":
        "Our nutrient-rich raw almond delight offers a perfect balance of taste and health. These almonds are sourced from the best orchards and are rich in protein, healthy fats, and essential vitamins. Enjoy them as a snack, in your baking, or as a nutritious addition to your salads and dishes.",
    "parentCategory": "Nuts and Seeds",
    "images": [
      "https://www.terrasoul.com/cdn/shop/products/Almonds_1200x1200.jpg?v=1542647911",
      "https://www.ohnuts.com/noapp/showImage.cfm/zoom/Raw%20Almond%20NEW1.jpg",
      "https://dreenaburton.com/wp-content/uploads/2018/04/4191-1-e1524796447842.png",
    ]
  },
  // {
  //   "productName": "Versatile Organic Chickpeas",
  //   "description":
  //       "Discover the versatility of our organic chickpeas, a staple for any kitchen. These protein-packed legumes are perfect for creating a variety of dishes, from creamy hummus to hearty stews and salads. Naturally grown and carefully processed, our chickpeas are a nutritious and delicious addition to your diet.",
  //   "parentCategory": "Legumes",
  //   "images": [
  //     "organic chickpeas",
  //     "protein legumes",
  //     "cooking chickpeas",
  //     "versatile chickpeas"
  //   ]
  // },
  // {
  //   "productName": "Fragrant Fresh Rose Blossoms",
  //   "description":
  //       "Add a touch of elegance and fragrance to your space with our fragrant fresh rose blossoms. These beautiful roses are carefully cultivated and picked at their peak to ensure long-lasting beauty and scent. Perfect for special occasions, gifts, or simply brightening up your home.",
  //   "parentCategory": "Flowers and Ornamentals",
  //   "images": [
  //     "fresh roses",
  //     "rose blossoms",
  //     "fragrant flowers",
  //     "elegant roses"
  //   ]
  // },
  // {
  //   "productName": "Colorful Heirloom Tomato Medley",
  //   "description":
  //       "Our colorful heirloom tomato medley brings a burst of flavor and vibrant hues to your table. These tomatoes are grown from heritage seeds, ensuring a rich, authentic taste. Perfect for salads, salsas, or roasting, they add a unique and delicious twist to your culinary creations.",
  //   "parentCategory": "Organic and Specialty Crops",
  //   "keywords": [
  //     "heirloom tomatoes",
  //     "colorful tomatoes",
  //     "heritage tomatoes",
  //     "fresh tomatoes"
  //   ]
  // },
  // {
  //   "productName": "Grass-Fed Premium Beef Cuts",
  //   "description":
  //       "Enjoy the rich, succulent taste of our grass-fed premium beef cuts. Raised on open pastures and fed a natural diet, our beef is tender, flavorful, and packed with nutrients. Perfect for grilling, roasting, or slow-cooking, each cut promises a gourmet dining experience.",
  //   "parentCategory": "Livestock",
  //   "keywords": [
  //     "grass-fed beef",
  //     "premium beef cuts",
  //     "gourmet beef",
  //     "succulent beef"
  //   ]
  // },
  // {
  //   "productName": "Free-Range Organic Chicken",
  //   "description":
  //       "Savor the wholesome goodness of our free-range organic chicken. Raised without antibiotics or hormones, our chickens are free to roam and graze, resulting in meat that's tender, juicy, and full of natural flavor. Ideal for a variety of dishes, from roasted dinners to hearty soups.",
  //   "parentCategory": "Poultry",
  //   "keywords": [
  //     "organic chicken",
  //     "free-range chicken",
  //     "tender chicken",
  //     "juicy chicken"
  //   ]
  // },
  // {
  //   "productName": "Freshly Caught Tilapia Fillets",
  //   "description":
  //       "Delight in the fresh, clean taste of our freshly caught tilapia fillets. Sustainably sourced and carefully processed, these fillets are perfect for grilling, baking, or frying. Enjoy a nutritious and delicious meal that's rich in protein and omega-3 fatty acids.",
  //   "parentCategory": "Aquaculture",
  //   "keywords": [
  //     "tilapia fillets",
  //     "fresh tilapia",
  //     "sustainable fish",
  //     "grilled tilapia"
  //   ]
  // },
  // {
  //   "productName": "Creamy Grass-Fed Dairy Milk",
  //   "description":
  //       "Our creamy grass-fed dairy milk is a nutritious and delicious choice for your family. Sourced from cows that graze on lush pastures, this milk is rich in flavor and packed with essential nutrients. Perfect for drinking, cooking, or adding to your favorite recipes.",
  //   "parentCategory": "Dairy Products",
  //   "keywords": [
  //     "grass-fed milk",
  //     "dairy milk",
  //     "creamy milk",
  //     "nutritious milk"
  //   ]
  // },
  // {
  //   "productName": "Rich and Flavorful Duck Eggs",
  //   "description":
  //       "Discover the rich and flavorful taste of our duck eggs. Larger and more nutrient-dense than chicken eggs, they offer a unique and delicious option for your cooking and baking needs. Perfect for gourmet dishes, baking, or simply enjoying scrambled or boiled.",
  //   "parentCategory": "Eggs",
  //   "keywords": [
  //     "duck eggs",
  //     "rich eggs",
  //     "gourmet eggs",
  //     "nutrient-dense eggs"
  //   ]
  // },
  // {
  //   "productName": "Pure Wildflower Honey Gold",
  //   "description":
  //       "Our pure wildflower honey gold is a natural sweetener that's perfect for your kitchen. Collected from bees that forage on diverse wildflowers, this honey offers a complex and rich flavor profile. Ideal for sweetening tea, drizzling on toast, or adding to recipes for a touch of natural sweetness.",
  //   "parentCategory": "Beekeeping",
  //   "keywords": [
  //     "wildflower honey",
  //     "pure honey",
  //     "natural sweetener",
  //     "rich honey"
  //   ]
  // },
  // {
  //   "productName": "Soft and Cozy Sheep Wool Yarn",
  //   "description":
  //       "Crafted from the finest sheep wool, our soft and cozy yarn is perfect for all your knitting and crocheting projects. Naturally warm and breathable, this wool yarn is ideal for creating comfortable garments and accessories that you can cherish for years to come.",
  //   "parentCategory": "Fibers",
  //   "keywords": [
  //     "sheep wool yarn",
  //     "cozy yarn",
  //     "knitting wool",
  //     "soft wool yarn"
  //   ]
  // },
  // {
  //   "productName": "Handcrafted Gourmet Sausages",
  //   "description":
  //       "Treat yourself to the rich, savory taste of our handcrafted gourmet sausages. Made from premium cuts of meat and seasoned to perfection, these sausages are perfect for grilling, sautéing, or adding to your favorite recipes. Experience a burst of flavor in every bite.",
  //   "parentCategory": "Meat Products",
  //   "keywords": [
  //     "gourmet sausages",
  //     "handcrafted sausages",
  //     "savory sausages",
  //     "premium sausages"
  //   ]
  // },
  // {
  //   "productName": "Friendly and Adorable Pet Rabbits",
  //   "description":
  //       "Our friendly and adorable pet rabbits make the perfect companions. Raised with care, these rabbits are healthy, social, and ready to bring joy to your home. Ideal for families, they are easy to care for and love to interact with their human friends.",
  //   "parentCategory": "Pets and Companion Animals",
  //   "keywords": [
  //     "pet rabbits",
  //     "adorable rabbits",
  //     "friendly pets",
  //     "companion rabbits"
  //   ]
  // },
  // {
  //   "productName": "Homemade Strawberry Jam Delight",
  //   "description":
  //       "Indulge in the sweet, fruity goodness of our homemade strawberry jam delight. Made with the freshest strawberries and a touch of love, this jam is perfect for spreading on toast, adding to desserts, or enjoying straight from the jar. Experience the taste of summer all year round.",
  //   "parentCategory": "Processed Foods",
  //   "keywords": ["strawberry jam", "homemade jam", "fruit spread", "sweet jam"]
  // },
  // {
  //   "productName": "Extra Virgin Olive Oil Elixir",
  //   "description":
  //       "Our extra virgin olive oil elixir is a kitchen essential. Cold-pressed from the finest olives, this oil boasts a rich, robust flavor that's perfect for dressings, marinades, and cooking. Elevate your culinary creations with a touch of Mediterranean magic.",
  //   "parentCategory": "Plant-Based Products",
  //   "keywords": [
  //     "olive oil",
  //     "extra virgin oil",
  //     "cold-pressed oil",
  //     "kitchen essential"
  //   ]
  // },
  // {
  //   "productName": "Ethically Sourced Leather Treasures",
  //   "description":
  //       "Discover the quality and craftsmanship of our ethically sourced leather treasures. From belts to bags, each piece is made from premium leather that is responsibly sourced and beautifully crafted. Perfect for adding a touch of elegance and durability to your wardrobe.",
  //   "parentCategory": "Animal-Based Products",
  //   "keywords": [
  //     "leather goods",
  //     "ethically sourced leather",
  //     "quality leather",
  //     "crafted leather"
  //   ]
  // }
];

List<String> regionsList = [
  'Greater Accra Region',
  'Ashanti Region',
  'Western Region',
  'Central Region',
  'Eastern Region',
  'Volta Region',
  'Northern Region',
  'Upper East Region',
  'Upper West Region',
  'Bono Region',
  'Bono East Region',
  'Ahafo Region',
  'Western North Region',
  'Oti Region',
  'North East Region',
  'Savannah Region'
];
