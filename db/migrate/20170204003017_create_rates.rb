class CreateRates < ActiveRecord::Migration[5.0]
  def change
    create_table :rates do |t|
      t.string :currency
      t.float :value
      t.date :date

      t.timestamps
    end
  end
end
