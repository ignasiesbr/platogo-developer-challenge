class AddPaymentTimeToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :payment_time, :date
  end
end
