module CsvImport
  module Loaders
    class LoanLoader
      attr_reader :attr
      attr_accessor :loan

      def initialize(attr)
        @attr = attr
      end

      def load
        record = build
        unless record.save
          raise CsvImport::ImportError, "#{record.class.to_s}: " + record.errors.full_messages.join(", ")
        end
        record
      end

      private

      def build
        find_loan
        unless loan.present?
          build_loan
        end
        loan
      end

      def find_loan
        self.loan = Loan.where(contact_number: attr[:contact_number],
                               network: attr[:network],
                               loaned_at: attr[:loaned_at],
                               product: attr[:product],
                               amount: attr[:amount]).first
        return loan if loan.present?
      end

      def build_loan
        self.loan = Loan.new(attr)
      end
    end
  end
end
