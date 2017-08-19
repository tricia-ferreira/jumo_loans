class CreateLoans < ActiveRecord::Migration[5.1]
  def change
    create_table :loans do |t|
      t.string :contact_number
      t.string :network
      t.datetime :loaned_at
      t.string :product
      t.float :amount

      t.timestamps
    end
  end
end
