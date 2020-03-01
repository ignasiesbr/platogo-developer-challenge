class AddIsPaidToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :is_paid, :boolean
  end
end
