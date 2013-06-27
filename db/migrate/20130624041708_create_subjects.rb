class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :title
      t.string :slug
      t.string :wiki_slug
      t.text :text

      t.timestamps
    end
  end
end
