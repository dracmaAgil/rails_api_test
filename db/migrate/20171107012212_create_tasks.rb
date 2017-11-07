class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.references :user, foreign_key: true
      t.text :description
      t.string :website
      t.string :header
      t.string :status
      t.date :expiration_date

      t.timestamps
    end
  end
end
