class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      # null: true => pode criar um endereço sem ser relacionado a um contato
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end