# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

COLORS = ['blue', 'red', 'green', 'grey',
          'brown', 'black', 'white', 'vocanic orange',
          'winestain', 'charcoal', 'shiny']

Cat.delete_all
5.times do
  Cat.new(
    birth_date: Faker::Date.backward(100),
    color: COLORS.sample,
    name: Faker::Cat.name,
    sex: ['M', 'F'].sample,
    description: Faker::Cat.breed
  ).save
end
