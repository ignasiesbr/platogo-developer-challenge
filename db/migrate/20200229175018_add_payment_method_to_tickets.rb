class AddPaymentMethodToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :payment_method, :string
  end
end
