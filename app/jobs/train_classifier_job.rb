class TrainClassifierJob < ApplicationJob
  def perform
    Job.deleted.reorder('RANDOM()').first(1000).each do |job|
      Classifier.train 'Spam', job
    end

    Job.published.reorder('RANDOM()').first(1000).each do |job|
      Classifier.train 'Ham', job
    end
  end
end
