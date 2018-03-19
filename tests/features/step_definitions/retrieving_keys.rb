When(/^I request for stored (.*)s$/) do |key_type|
  @actual_data = Teaspoon.spoonful(key: key_type)
end

Then(/^I should get all stored (.*)s$/) do |key_type|
  expect(@actual_data.sort).to eql(Keys.in_database(key_type, @branch, @epoch).sort)
end
