# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

tony = User.create(username: "Tony", species: "Tiger", password: "frosted")
sammy = User.create(username: "Sammy", species: "Snake", password: "parseltongue")
periwinkle = User.create(username: "Periwinkle", species: "Penguin", password: "northpole")


User.all.each do |user| 
  p "ran once"
  Profile.create(user_id: user.id)
end

prompts = ["My self summary",
   "What I'm doing with my life",
    "Six things I couldn't live without",
     "On a typical Friday night I'm..." ]

content = [
  ["I'm a terrific tiger! I'm lookin' for love, or a sporting partner, or a frosting enthusiast!", 
  "Other than my job, I love soccer, hunting prey, and sunbathing.", 
  "Stripes, champagne, flakes, frosting, lingering on the letter 'R', salsa dancing.",
  "Up in the club."], 
  ["I'm a snazzy snake!", 
    "Simply searching. Strangely, some suspect snakes.", 
    "Sympathy, Sarcasm, Sriracha, Syrup, Sleep, Snape",
    "Snacking"],
    ["I'm a pretty penguin!",
       "I'm a freelance graphic designer by trade, and a blues dancer by night.",
       "Art, Internet, Tumblr, my Cintiq tablet, friends, fish.",
       "Hanging out with other penguins, avoiding predators"]
     ]


posts = Profile.all.each do |profile|
  Post.create(profile_id: profile.id, prompt: prompts[0], content: content[profile.user_id - 1][0])
  Post.create(profile_id: profile.id, prompt: prompts[1], content: content[profile.user_id - 1][1])
  Post.create(profile_id: profile.id, prompt: prompts[2], content: content[profile.user_id - 1][2])
  Post.create(profile_id: profile.id, prompt: prompts[3], content: content[profile.user_id - 1][3])
end
