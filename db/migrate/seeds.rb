andrew = User.create(name: "andrew", email: "andrew@andrew.com", password: "password")
izzy = User.create(name: "izzy", email: "izzy@izzy.com", password: "password")



ProjectIdea.create(title: "Happy Tuesday!", content: "Today is Tuesday and it's great!", user_id: howard.id)



andrew.project_ideas.create(title: "My Second Entry", content: "We are building a Sinatra app!  Yaaay!")

izzy_entry = izzy.project_ideas.build(title: "Warm Weather", content: "It's super warm here in MD")
izzy_entry.save
