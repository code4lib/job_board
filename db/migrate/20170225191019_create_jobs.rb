class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :origin
      t.string :url
      t.text :description
      t.string :description_markup
      t.references :user
      t.integer :job_type
      t.boolean :telecommute
      t.references :employer
      t.text :location
      t.text :contact
      t.boolean :published
      t.datetime :published_at

      t.timestamps
    end
  end
end
