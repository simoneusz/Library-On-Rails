images_path = Rails.root.join('db', 'seed_images')
image_files = Dir[images_path.join('*')]

5.times do
  book = Book.new(
    name: Faker::Book.title,
    author_name: Faker::Book.author,
    description: Faker::Lorem.paragraph(sentence_count: 5)
  )

  random_image = image_files.sample
  book.image = File.open(random_image)

  if book.save
    puts "Book '#{book.name}' is saved."
  else
    puts "Cant save book: #{book.errors.full_messages.join(', ')}"
  end
end

puts 'done'
