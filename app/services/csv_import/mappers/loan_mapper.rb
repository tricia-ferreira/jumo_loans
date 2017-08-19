module CsvImport
  module Mappers
    class LoanMapper
      attr_reader :row

      def initialize(row)
        @row = row
      end

      def transform
        map_attributes
      end

      private

      def map_attributes
        {
          contact_number: sanitize(row['MSISDN']),
          network: sanitize(row['Network']),
          loaned_at: DateTime.parse(sanitize(row['Date'])),
          product: sanitize(row['Product']),
          amount: sanitize(row['Amount'])
        }
      end

      def sanitize(value)
        value.gsub("'", '')
      end
    end
  end
end
