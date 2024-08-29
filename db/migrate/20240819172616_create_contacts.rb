class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.date :birthdate
      # t.references :kind, foreign_key: true

      t.timestamps
    end
  end
end
