require 'rails_helper'

RSpec.describe CsvImport::Loaders::LoanLoader do
  let(:loader) { described_class.new(loan_attr) }

  describe '#load' do
    subject { loader.load }

    context 'valid attributes' do
      context 'new loan' do
        let(:loan_attr) { attributes_for(:loan) }

        it 'creates a loan' do
          expect{ subject }.to change(Loan, :count).by(1)
        end

        it 'returns a loan' do
          expect(subject).to be_a Loan
        end
      end

      context 'loan exists' do
        before :each do
          @loan = create(:loan)
        end

        let(:loan_attr) { @loan.attributes.except!(:id, :update_at, :created_at) }

        it 'updates the loan' do
          expect{ subject }.to_not change(Loan, :count)
        end

        it 'returns a loan' do
          expect(subject).to be_a Loan
        end
      end
    end
  end
end
