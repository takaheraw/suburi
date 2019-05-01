class HelloWorker
  include Sidekiq::Worker

  def perform(arg)
    puts "Hello #{arg}"
  end

end
