3.times do |n|
  name = Faker::Restaurant.name
  fee = Faker::Commerce.price(range: 200..500)
  time_required = Faker::Types.rb_integer
  restaurant = Restaurant.new(
  name: name,
  fee: fee,
  time_required: time_required,
  )

  12.times do |m|
  name = Faker::Food.dish
  price = Faker::Commerce.price(range: 500..1000)
  ingredient = Faker::Food.ingredient #=> "Adzuki Beans"
  restaurant.foods.build(
  name: name,
  price: price,
  description: ingredient,
  )
  end

  restaurant.save!
end