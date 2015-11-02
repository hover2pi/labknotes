require 'factory_girl'
Dir[Rails.root.join("spec/factories/**/*.rb")].each {|f| require f}

puts "Creating users ..."
tom = Factory.create(:admin, :email => "tom@knotebooks.com", :first => "Tom", :last => "Clark")
joe = Factory.create(:admin, :email => "joe@knotebooks.com", :first => "Joe", :last => "Filippazzo")

puts "Creating professors ..."
Factory.create(:professor, :first => "Hubert", :last => "Farnsworth", :email => "farnsworth@foo.bar")
Factory.create(:professor, :first => "Ogden", :last => "Wernstrom", :email => "wernstrom@foo.bar")

puts "Creating courses ..."
Professor.find_each do |professor|
  2.times do
    course = Factory.create(:course, :professor => professor)

    puts "Generating knotebooks ..."
    (rand(10) + 3).times do
      knotebook = Factory.create(:knotebook_with_default_questions, :professor => professor, :course => course)
    end
  end
end

puts "Creating reports ..."
Student.find_each do |student|
  student.courses.find_each do |course|
    course.knotebooks.find_each do |knotebook|
      Factory.create(:report_with_answers, :knotebook => knotebook, :student => student)
    end
  end
end

puts "Creating Jimmy James ..."
jimmy = Factory.create(:student, :first => "Jimmy", :last => "James", :email => 'jimmy@james.com')
2.times do
  begin
    course = Course.find(rand(Course.count) + 1)
    course.students << jimmy
    course.knotebooks.find_each do |knotebook|
      Factory.create(:report_with_answers, :knotebook => knotebook, :student => jimmy)
    end
  rescue
    retry
  end
end

puts "Generating comments ..."
answer_count = Answer.count
(answer_count / 2).times do
  answer = Answer.find(rand(answer_count) + 1)
  Factory.create(:answer_comment, :commentable => answer, :user => answer.report.course.professor)
end
