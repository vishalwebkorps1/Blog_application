# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# #   Character.create(name: "Luke", movie: movies.first)
# puts 'Seeding development database...'
Admin = User.first_or_create!(email: 'Admin@example.com',
                             password: '123456',
                             password_confirmation: '123456',
                             first_name: 'Admin',
                             last_name: 'DeHart',
                             role: User.roles[:admin])

Tilak = User.first_or_create!(email: 'Tilak@gmail.com',
                             password: '123456',
                             password_confirmation: '123456',
                             first_name: 'Tilak',
                             last_name: 'Doe')
Address.first_or_create!(street: '123 Main St',
                         city: 'Anytown',
                         state: 'CA',
                         zip: '12345',
                         country: 'USA',
                         user: Admin)
Address.first_or_create(street: '123 Main St',
                        city: 'Anytown',
                        state: 'CA',
                        zip: '12345',
                        country: 'USA',
                        user: Tilak)
elapsed = Benchmark.measure do
  posts = []
  10.times do |x|
    puts "Creating post #{x}"
    post = Post.new(tittle: "Title #{x}",
                    body: "Body #{x} Words go here Idk",
                    user: Admin)

    5.times do |y|
      puts "Creating comment #{y} for post #{x}"
      post.comments.build(body: "Comment #{y}",
                          user: Tilak)
    end
    posts.push(post)
  end
  Post.import(posts, recursive: true)

end
puts "Seeded development DB in #{elapsed.real} seconds"