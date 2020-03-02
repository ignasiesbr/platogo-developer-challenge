class RemoveExitedFromTickets < ActiveRecord::Migration[6.0]
  def change

    remove_column :tickets, :exited, :boolean
  end
end
