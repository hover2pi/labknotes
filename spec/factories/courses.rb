Factory.define :course do |f|
  f.sequence(:name) { |n| "Physics #{n + 450}"}
  f.semester "Fall 2010"
  f.sequence(:short_name) { |n| "PHY #{n + 450}"}
  f.syllabus { Faker::Lorem.paragraphs(3).to_a.join("\n") }
  f.association :professor

  f.after_create { |c| 3.times { c.students << Factory.create(:student) } }
  # f.after_create { |c| 3.times { Factory.create(:knotebook, :professor => c.professor, :course => c) } }
end
