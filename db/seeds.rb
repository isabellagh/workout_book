User.destroy_all

captain_america = User.create(name: "captain america", email: "captain_america@usa.com", password: "shield", bio: "Strength and conditioning coach", image_url: "https://i.pinimg.com/originals/65/07/ec/6507ec851738e3949b61a12bdf8c2eb9.jpg")

goku = User.create(name: "Goku", email: "goku@usa.com", password: "food", bio: "Strength and conditioning coach", image_url: "https://www.fightersgeneration.com/nf8/char6/ultra-instinct-goku-dragonballfighterz-art.jpg")

red_skull = User.create(name: "Red Skull", email: "red_skull@usa.com", password: "shield", bio: "working on strength and conditioning to fight Captain America", image_url: "https://b1.pngbarn.com/png/379/542/red-skull-png-clip-art.png")

Post.create(title: "Chest day!!", image_url:"https://i.stack.imgur.com/WNsYr.jpg", description: "I am getting stronger for you, Red Skull!", user_id: captain_america.id)

Post.create(title: "I am always very hungry!", image_url:"https://media.tenor.com/images/8180a32d0235dd080529f84a5b121324/raw", description: "Thats me in off-season!", user_id: goku.id)

Post.create(title: "I am a bad guy", image_url:"https://i.pinimg.com/originals/e3/1a/af/e31aaf49023df5dde546b7c951530085.jpg", description: "Trash day!", user_id: red_skull.id)
