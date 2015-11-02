Factory.define :knote do |f|
  f.sequence(:title) { |n| Faker::Lorem.sentence + n.to_s }
  f.sequence(:content) { |n| Faker::Lorem.paragraphs.join("\n") + n.to_s }
  f.difficulty { rand(100) }
end

Factory.define :knote_with_tags, :parent => :knote do |f|
  f.after_create do |f|
    3.times { f.tags << Factory.create(:tag) }
  end
end
