RSpec.configure do |config|
  # Because this gem uses singletons, and the tests run in a single process,
  #   the state of the Singletons needs to be reset between tests.
  UndriveGoogle::Options.instance.send(:load_yaml, true)
end