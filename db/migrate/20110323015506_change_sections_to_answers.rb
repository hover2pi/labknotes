class ChangeSectionsToAnswers < ActiveRecord::Migration
  def self.up
    change_table :sections do |t|
      t.remove :title, :explanation
      t.references :question
    end
    rename_table :sections, :answers
  end

  def self.down
    rename_table :answers, :sections
    change_table :sections do |t|
      t.remove :question_id
      t.string :title
      t.text :explanation
    end
  end
end
