class Knote < ActiveRecord::Base
  attr_accessible :title, :content
  
  belongs_to :professor
  has_many :taggings
  has_many :tags, :through => :taggings, :order => 'id DESC'
  has_many :knotings, :dependent => :destroy
  has_many :knotebooks, :through => :knotings

  validates_uniqueness_of :title
  validates_presence_of :title, :content, :nil => false

  searchable do
    text :title
    text :content
    integer :id
    integer :difficulty
    integer :tag_ids, :multiple => true, :references => Tag
  end

  def similar_knotes
    # Solr blows up if tag_ids == []
    return [] if tag_ids.empty?

    Knote.search do
      with(:tag_ids).all_of(tag_ids)
      without :id, id
      order_by :difficulty, :asc
      order_by :id, :asc
      facet :tag_ids
    end.results
  end

  def easier(original = self)
    return [] if original.tag_ids.blank?

    Knote.search do
      with(:tag_ids).all_of(original.tag_ids)
      order_by :difficulty, :asc
      order_by :id, :asc
    end.results.take_while { |i| i != self }.reverse
  end

  def harder(original = self)
    return [] if original.tag_ids.blank?

    Knote.search do
      with(:tag_ids).all_of(original.tag_ids)
      order_by :difficulty, :desc
      order_by :id, :desc
    end.results.take_while { |k| k != self }.reverse
  end

  def easier!(original = self)
    easier(original).first
  end

  def harder!(original = self)
    harder(original).first
  end

  def html_content
    Markup.new(:format => format, :content => content).render
  end
end
