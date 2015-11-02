Factory.define :question do |f|
  f.title { Faker::Lorem.words(1).first.to_s.capitalize }
  f.explanation { Faker::Lorem.paragraph }
end

Factory.define :question_with_knotebook, :parent => :question do |f|
  f.association :knotebook
end
