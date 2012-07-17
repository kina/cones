class Credit < ActiveRecord::Base
  attr_accessible :customer_id, :value, :used

  belongs_to :customer

  scope :unused,  where(used: false)
  scope :used,    where(used: true)
end
