Factory.define :answer do |f|
  f.content { Faker::Lorem.paragraphs.join("\n") }
end

Factory.define :answer_with_report, :parent => :answer do |f|
  f.association :report
end