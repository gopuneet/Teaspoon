Given(/^I have(| a previously populated) (\w+)$/) do |populated, database|
  ENV['TEASPOON_DATABASE_IN_USE'] = database.upcase

  if populated.eql?(' a previously populated')
    @branch = 'feat/test-teaspoon'
    @epoch = Time.now.to_i
    Teaspoon.measure_and_pour_in_time(Report.sample, @branch, @epoch)
  end
end

When('I execute some cucumber tests') do
  @branch = 'feat/test-teaspoon'
  @epoch = Time.now.to_i
  Teaspoon.measure_and_pour_in_time(Report.sample, @branch, @epoch)
end

Then(/^their results should be saved to the database$/) do
  actual_data = Teaspoon.spoonful(epoch: [@epoch], branch: [@branch])
  expected_data = Report.in_database(@epoch, @branch)
  expect(actual_data.to_set).to eql(expected_data.to_set), "ERROR: data was not saved properly to #{ENV['TEASPOON_DATABASE_IN_USE'].downcase}!"
end
