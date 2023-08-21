# Generate some users
5.times do |n|
    email = "user-#{n+1}@mail.com"
    first_name = Faker::Name.first_name
    last_name  = Faker::Name.last_name
    password   = "lozinka"
    User.create!( email: email, 
                  first_name: first_name,
                  last_name: last_name,
                  password: password,
                  password_confirmation: password)
    end              
  
    # Generate posts for these random users
    users = User.order(:created_at).take(5)
    50.times do
      title       = Faker::Lorem.sentence(word_count: 3)
      description = Faker::Lorem.paragraph(sentence_count: 30)
      users.each { |user| 
        user.posts.create!(title: title, 
                           description: description)}
    end
  
    # Generate comments for some posts
    posts = Post.order(:created_at).take(10)
    5.times do 
      content = Faker::Lorem.sentence(word_count: 5)
      posts.each { |post| post.comments.create!(user_id: rand(1..5),
                                                post_id: post,
                                                comment: content) }
    end