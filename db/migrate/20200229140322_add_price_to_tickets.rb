class AddPriceToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :price, :float
  end
end
