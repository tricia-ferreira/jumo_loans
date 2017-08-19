require 'rails_helper'

RSpec.describe Loan, type: :model do
  it { should respond_to(:contact_number) }
  it { should respond_to(:network) }
  it { should respond_to(:loaned_at) }
  it { should respond_to(:product) }
  it { should respond_to(:amount) }

  context 'scopes' do
    before :each do
      create_list(:loan, 2, product: 'Product 1', network: 'Network 2', loaned_at: (Date.today - 2.month))
      create_list(:loan, 3, product: 'Product 2', network: 'Network 1', loaned_at: (Date.today - 3.month))
    end

    describe '#aggregate_by_product' do
      subject { Loan.aggregate_by_product }

      it 'returns records grouped by product' do
        expect(subject.count).to eq 2
      end

      it 'returns loans for first product' do
        @loans = subject.first
        expect(@loans[1].count).to eq 2
      end
    end

    describe '#aggregate_by_network' do
      subject { Loan.aggregate_by_network }

      it 'returns records grouped by network' do
        expect(subject.count).to eq 2
      end

      it 'returns loans for first network' do
        @loans = subject.first
        expect(@loans[1].count).to eq 2
      end
    end

    describe '#aggregate_by_month' do
      subject { Loan.aggregate_by_month }

      it 'returns records grouped by month' do
        expect(subject.count).to eq 2
      end

      it 'returns loans for first month' do
        @loans = subject.first
        expect(@loans[1].count).to eq 2
      end
    end
  end
end
