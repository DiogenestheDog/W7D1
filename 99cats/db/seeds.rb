# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def find_color
  options = ["brown", "yellow", "black", "orange", "white"]
  return options.sample 
end

def find_sex
  options = ["M", "F"]
  return options.sample
end

def find_date
  return "#{rand(2001..2017)}-#{rand(1..12)}-#{rand(1..28)}"
end

# more future dates are > than more past dates
def find_date_range
  date1 = find_date
  date2 = find_date
  return (date1 > date2) ? [date2, date1] : [date1, date2]
end

Cat.destroy_all

99.times do
  Cat.create(name: Faker::Name.unique.first_name, birth_date: find_date, color: find_color, sex: find_sex, description: Faker::ChuckNorris.fact)
end