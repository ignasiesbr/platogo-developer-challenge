require 'securerandom'
class Ticket < ApplicationRecord
    after_initialize :default_values
    validates :barcode, presence: true, length: {is: 16}, format: {with: /[0-9A-Fa-f]/}, uniqueness: true

    private
    def default_values
        self.barcode = SecureRandom.hex(8)
    end

end
