FactoryGirl.define do
  factory :loan do
    contact_number '0215550000'
    network 'Network 1'
    loaned_at Date.today
    product 'Product 1'
    amount 1000
  end
end
