module CsvImport
  class LoanImportService < ImportService

    private

    def transform
      self.collection = rows.map do |row|
        TransformedData.new(row,CsvImport::Mappers::LoanMapper.new(row).transform)
      end
    end

    TransformedData = Struct.new(:row, :driver)

    def load_transformed_data(data)
      driver = CsvImport::Loaders::LoanLoader.new(data.driver).load
    end

  end
end
