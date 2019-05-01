class Scheduler::HelloScheduler
  include Sidekiq::Worker

  def perform
    HelloWorker.perform_async("Wolrd!")
  end

end
