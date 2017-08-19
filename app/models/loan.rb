require 'csv'

class Loan < ApplicationRecord
  scope :aggregate_by_product, -> { all.group_by(&:product) }
  scope :aggregate_by_network, -> { all.group_by(&:network) }
  scope :aggregate_by_month, -> { all.group_by { |r| r.loaned_at.beginning_of_month } }

  HEADERS = ['Type', 'Amount', 'Count']

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << HEADERS
      map_products(csv)
      map_networks(csv)
      map_months(csv)
    end
  end

  private

  def self.map_products(csv)
    aggregate_by_product.each do |records|
      csv << [records[0], records[1].count, records[1].collect(&:amount).sum]
    end
  end

  def self.map_networks(csv)
    aggregate_by_network.each do |records|
      csv << [records[0], records[1].count, records[1].collect(&:amount).sum]
    end
  end

  def self.map_months(csv)
    aggregate_by_month.each do |records|
      csv << [Date::MONTHNAMES[records[0].month], records[1].count, records[1].collect(&:amount).sum]
    end
  end
end
