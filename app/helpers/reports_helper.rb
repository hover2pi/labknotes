module ReportsHelper
  def due_message(report)
    if report.draft?
      if report.knotebook.due_at > Time.now
        if report.knotebook.due_at - Time.now > 24.hours
          "Due in #{distance_of_time_in_words(report.knotebook.due_at - Time.now)}"
        else
          "Due at #{report.knotebook.due_at.strftime("%l:%M %P")}"
        end
      else
        "#{distance_of_time_in_words(Time.now - report.knotebook.due_at).capitalize} overdue"
      end
    end
  end
end

