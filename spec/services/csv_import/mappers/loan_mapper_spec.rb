require 'rails_helper'

RSpec.describe CsvImport::Mappers::LoanMapper do
  let(:row) do
    {
      'MSISDN' => '27729554427',
      'Network' => 'Network 1',
      'Date' => '12-Mar-2016',
      'Product' => 'Loan Product 1',
      'Amount' => '1000.00'
    }
  end

  let(:mapper) { described_class.new(row) }

  describe '#transform' do
    subject { mapper.transform }

    it 'transforms data into valid loan attributes' do
      expect(Loan.new(subject)).to be_valid
    end

    it 'extracts the contact_number' do
      expect(subject[:contact_number]).to eq '27729554427'
    end

    it 'extracts the network' do
      expect(subject[:network]).to eq 'Network 1'
    end

    it 'extracts the loaned_at' do
      expect(subject[:loaned_at]).to eq Date.parse('12-Mar-2016')
    end

    it 'extracts the product' do
      expect(subject[:product]).to eq 'Loan Product 1'
    end

    it 'extracts the amount' do
      expect(subject[:amount]).to eq '1000.00'
    end
  end
end
