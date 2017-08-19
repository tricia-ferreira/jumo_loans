module CsvImport
  class CsvImporter
    attr_reader :service, :path, :filename, :service, :record_types, :start_time

    def initialize(service, path, record_types)
      @service = service
      all,@path,@filename = *(path.match(/(.*\/)(\w*.csv)/))
      @service = service
      @record_types = record_types
      @start_time = Time.now
    end

    def import
      puts "Staring import"
      service.import
      puts "#{service.errors.count} Errors"
      export_errors
      puts "Done"
    end

    private
    def record_count_table
      record_types.map do |type|
        [type.titleize, count_by_type(type), count_by_type(type, @start_time)]
      end
    end

    def count_by_type(class_name, start_time=nil)
      relation = class_name.constantize
      if start_time
        strip_zeros(relation.where("created_at >= ?", start_time).count)
      else
        strip_zeros(relation.count)
      end
    end

    def strip_zeros(count)2
      count == 0 ? "-" : count
    end

    def export_errors
      if service.errors.count > 0
        CSV.open("#{path}#{filename}_import_errors.csv", "wb") do |writer|
          writer << ["Errors",service.errors[0][0].headers].flatten
          service.errors.each do |error|
            writer << [error[1],error[0].fields].flatten
          end
        end
      end
    end
  end
end
