module KnotebooksHelper
  def restore_knote_options(index)
    { :knotes => params[:knotes].reject { |k,v| k == index.to_s } }
  end
  
  def easier_knote_options(knote, index)
    { :knotes => params[:knotes].merge(index.to_s => { :id => knote.easier!(@knotebook.knotes[index]).id }) }
  end

  def harder_knote_options(knote, index)
    { :knotes => params[:knotes].merge(index.to_s => { :id => knote.harder!(@knotebook.knotes[index]).id }) }
  end
  
  def grade_message(knotebook)
    count = knotebook.reports.needs_grade.count
    case count
    when 0 then "View reports"
    when 1 then "Grade 1 report"
    else "Grade #{count} reports"
    end
  end
end
