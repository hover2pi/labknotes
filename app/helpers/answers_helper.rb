module AnswersHelper
  def spreadsheet_for(answer)
    "#{answer.content}&widget=true".html_safe
  end
end
