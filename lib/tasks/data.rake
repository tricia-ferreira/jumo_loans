namespace :data do
  desc "import loans from a csv file - absolute path to the file is specified as an argument"
  task :import_loans, [:path_to_csv, :batch_size] => :environment do |t, args|
    csv = File.read(args[:path_to_csv])
    batch_size = (args[:batch_size] || 25).to_i

    service = CsvImport::LoanImportService.new(csv, batch_size)
    CsvImport::CsvImporter.new(service, args[:path_to_csv], ["Loan"]).import
  end
end
