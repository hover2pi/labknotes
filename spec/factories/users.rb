require 'faker'
# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
  f.first { |u| Faker::Name.first_name }
  f.last { |u| Faker::Name.last_name }
  f.email { |u| Faker::Internet.email }
  f.password "foobar"
  f.password_confirmation "foobar"
end

Factory.define :student do |f|
  f.first { |u| Faker::Name.first_name }
  f.last { |u| Faker::Name.last_name }
  f.email { |u| Faker::Internet.email }
  f.password "foobar"
  f.password_confirmation "foobar"
  f.student_id { |u| rand(900000000) + 100000000 }
  
  f.type "Student"
end

Factory.define :admin, :parent => :user do |f|
  f.roles [:admin]
end

Factory.define :professor do |f|
  f.first { |u| Faker::Name.first_name }
  f.last { |u| Faker::Name.last_name }
  f.email { |u| Faker::Internet.email }
  f.password "foobar"
  f.password_confirmation "foobar"

  f.roles [:professor]
  f.type "Professor"
end
