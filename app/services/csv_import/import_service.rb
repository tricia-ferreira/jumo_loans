module CsvImport
  class ImportService
    require 'csv'
    require 'benchmark'

    attr_reader :csv, :benchmarks, :errors
    attr_accessor :rows, :collection

    def initialize(csv, load_batch_size=10)
      @csv = csv
      @load_batch_size = load_batch_size.to_i
      @errors = []
    end

    def import
      Benchmark.bm(15) do |x|
        x.report(:extract) { extract }
        x.report(:transform) { transform }
        collection.each_slice(@load_batch_size).with_index do |batch,i|
          x.report("load #{load_progress(i)}") { load(batch) }
        end
      end
    end

    private

    def extract
      self.rows = CSV.parse(csv, :headers => true)
    end

    def transform
      raise "not implemented"
    end

    TransformedData = Struct.new(:row, :model)

    def load(batch)
      batch.each do |data|
        begin
          load_transformed_data(data)
        rescue CsvImport::ImportError => e
          errors << [data.row, e.message]
        end
      end
    end

    def load_transformed_data(data)
      raise "not implemented"
    end

    def load_progress(i)
      percentage = 100*(i+1)*([@load_batch_size.to_f/collection.length, 1].min)
      sprintf "%02d%%", [percentage, 100].min
    end
  end
end
