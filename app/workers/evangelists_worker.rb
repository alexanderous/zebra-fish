class EvangelistsWorker
	include Sidekiq::Worker
	sidekiq_options queue: "default"
	sidekiq_options :retry => 5

	def perform(evangelist_id)
	  evangelist = Evangelist.find(evangelist_id)
	  #deliveree = 'alex@antho.co'
	  evangelist.send_evangelist_notify(evangelist_id)
	end
end