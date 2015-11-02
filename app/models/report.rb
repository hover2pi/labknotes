class Report < ActiveRecord::Base
  belongs_to :student
  belongs_to :knotebook
  has_many :answers
  has_one :course, :through => :knotebook
  
  accepts_nested_attributes_for :answers

  validates_numericality_of :grade, :allow_nil => true

  state_machine :initial => :draft do
    state :draft
    state :submitted do
      validates_presence_of :submitted_at
    end
    state :late do
      validates_presence_of :submitted_at
    end
    state :graded do
      validates_presence_of :submitted_at
      validates_presence_of :grade
      validates_inclusion_of :grade, :in => 0..100
    end

    event :submit do
      transition :draft => :late, :if => :is_due?
      transition :draft => :submitted
    end

    event :return do
      transition [:submitted, :late] => :draft
    end

    event :score do
      transition all => :graded
    end

    before_transition any => [:submitted, :late] do |report|
      report.submitted_at = Time.now
    end
  
  end

  state_machine.states.each {|s| scope s.name, with_state(s.name) }

  scope :needs_grade, where(:state => [:submitted, :late])
  scope :overdue, draft.joins(:knotebook).where("knotebooks.due_at < ?", Time.now)
  scope :for, lambda {|student| where(:student_id => student.is_a?(Student) ? student.id : student)}
  scope :due_at_asc, joins(:knotebook).order("knotebooks.due_at ASC")
  scope :due_at_desc, joins(:knotebook).order("knotebooks.due_at DESC")

  def title
    knotebook.title
  end

  def is_due?
    Time.now >= knotebook.due_at
  end

  def due_date
    knotebook.due_at.strftime("%D")
  end

  def needs_grade?
    submitted? || late?
  end    
end
