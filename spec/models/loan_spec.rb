require 'rails_helper'

RSpec.describe Loan, type: :model do
  it { should respond_to(:msisdn) }
  it { should respond_to(:network) }
  it { should respond_to(:loaned_at) }
  it { should respond_to(:product) }
  it { should respond_to(:amount) }
end
