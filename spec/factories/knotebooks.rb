Factory.define :knotebook do |f|
  f.sequence(:title) { |n| Faker::Lorem.sentence(5) + n.to_s }
  f.sequence(:abstract) { |n| Faker::Lorem.paragraph + n.to_s }
  f.association :professor
  f.association :course
  f.due_at { (1.week.ago.to_date..1.week.from_now.to_date).to_a[rand(14)].beginning_of_day + (rand(6) * 4).hours }
  f.state "unublished"
end

Factory.define :knotebook_with_knotes, :parent => :knotebook do |f|
  f.after_create do |knotebook|
    3.times { knotebook.knotes << Factory.create(:knote_with_tags) }
  end
end

Factory.define :knotebook_with_default_questions, :parent => :knotebook_with_knotes do |f|
  f.after_create do |knotebook|
    %w[Introduction Procedure Data Analysis Conclusion].each do |title|
      knotebook.questions << Factory.create(:question, :title => title, :knotebook => knotebook)
    end
  end
  f.state "published"
end
