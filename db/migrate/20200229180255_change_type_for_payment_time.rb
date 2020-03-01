class ChangeTypeForPaymentTime < ActiveRecord::Migration[6.0]
  def change
    change_column(:tickets, :payment_time,:datetime )
  end
end
