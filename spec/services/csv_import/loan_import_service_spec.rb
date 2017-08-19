require 'rails_helper'

RSpec.describe CsvImport::LoanImportService do
  before :each do
    allow($stdout).to receive(:write).and_return(nil)
    create(:loan,
           contact_number: 27729554427,
           network: 'Network 1',
           loaned_at: '12-Mar-2016',
           product: 'Loan Product 1',
           amount: 1000.00)
  end

  let(:csv) { File.read(Rails.root + 'spec/fixtures/data_import/loans.csv') }
  let(:importer) { described_class.new(csv) }

  describe '#import' do
    subject { importer.import }

    it 'creates a loan' do
      expect { subject }.to change(Loan, :count).by(2)
    end
  end
end
