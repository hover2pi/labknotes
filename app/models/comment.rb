class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  def self.for_report(report)
    joins("JOIN answers ON comments.commentable_id = answers.id").where(:commentable_type => "Answer", :answers => { :report_id => report.id })
  end

  def html_content
    Markup.new(:content => body, :format => format).render
  end
end
