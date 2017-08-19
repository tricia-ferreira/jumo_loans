class LoansController < ApplicationController
  def index
    @loans = Loan.all
    respond_to do |format|
      format.html
      format.csv { send_data Loan.to_csv, filename: 'output.csv' }
    end
  end
end
