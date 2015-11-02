Factory.define :base_comment, :class => Comment do |f|
  f.sequence(:body) { |n| Faker::Lorem.paragraph + n.to_s }
end

Factory.define :knotebook_comment, :parent => :base_comment do |f|
  f.commentable { Factory.create(:knotebook_with_knotes) }
  f.sequence(:body) { |n| Faker::Lorem.paragraph + n.to_s }
  f.user { Factory.create(:student) }
end

Factory.define :answer_comment, :parent => :base_comment do |f|
  f.commentable { Factory.create(:answer_with_report) }
  f.sequence(:body) { |n| Faker::Lorem.paragraph + n.to_s }
  f.user { Factory.create(:professor) }
end
