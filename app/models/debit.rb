class Debit < ActiveRecord::Base
  attr_accessible :customer_id, :value

  belongs_to :customer
end
