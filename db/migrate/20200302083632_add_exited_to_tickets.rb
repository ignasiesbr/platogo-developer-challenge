class AddExitedToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :exited, :boolean
  end
end
