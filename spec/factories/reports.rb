Factory.define :report do |f|
  f.after_create do |r|
    states = Report.state_machine.states.map &:name
    state = states[rand(states.count)]
    r.grade = rand(100.0) if state == :graded
    r.state = state.to_s
    r.save
  end
end

Factory.define :report_with_answers, :parent => :report do |f|
  f.after_create do |report|
    report.knotebook.questions.each do |question|
      Factory.create(:answer, :report => report, :question => question)
    end
  end
end
