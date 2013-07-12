class Scenario < ActiveRecord::Base
  has_many :transactions
end
class Transaction < ActiveRecord::Base
  belongs_to :scenario
  has_many :records
end
class Record < ActiveRecord::Base
  belongs_to :transaction
end