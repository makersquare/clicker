RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do |test|
    unless test.metadata[:no_database_cleaner]
      DatabaseCleaner.strategy = :transaction
    end
  end

  config.before(:each, :js => true) do |test|
    unless test.metadata[:no_database_cleaner]
      DatabaseCleaner.strategy = :truncation
    end
  end

  config.before(:each) do |test|
    unless test.metadata[:no_database_cleaner]
      DatabaseCleaner.start
    end
  end

  config.after(:each) do |test|
    if test.metadata[:no_database_cleaner]
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean      
    else
      DatabaseCleaner.clean
    end
  end

end