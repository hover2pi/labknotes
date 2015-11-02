class Knotebook < ActiveRecord::Base
  attr_accessible :title, :abstract, :due_at

  belongs_to :professor
  belongs_to :course
  has_many :questions
  has_many :knotings, :dependent => :destroy
  has_many :knotes, :through => :knotings, :order => 'y ASC, x ASC' do
    def grouped
      proxy_owner.knotings.select([:y, :knote_id]).includes(:knote).group_by(&:y).values.map {|a|a.map &:knote}
    end
  end
  has_many :comments, :as => :commentable
  has_many :reports

  acts_as_list :scope => :course

  validates_uniqueness_of :title
  validates_presence_of :title
  validates_presence_of :abstract

  scope :due, lambda { where("due_at > ?", Time.now).order('due_at ASC') }

  state_machine :initial => :unpublished do
    state :unpublished
    state :published do
      validates_presence_of :due_at
    end

    event :publish do
      transition :unpublished => :published
    end

    after_transition :unpublished => :published do |knotebook|
      knotebook.course.student_ids.each do |id|
        knotebook.reports.create(:student_id => id)
      end
    end
  end

  def tags
    Tag.joins(:knotes => :knotings).where(:knotings => { :knotebook_id => id })
  end

  def position_of(knote)
    knote = knote.id if knote.is_a? Knote
    knotings.where(:knote_id => knote).first.y
  end
  
  def is_due?
    Time.now > knotebook.due_at
  end

  def publishable?
    knotes.count > 0 && questions.count > 0
  end
end
