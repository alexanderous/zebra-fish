class CommentSubjectNotificationsWorker
	include Sidekiq::Worker
	sidekiq_options queue: "default"
	sidekiq_options :retry => 5

	def perform(comment_id)
	  perspective = Comment.find(comment_id)
	  anthology_item = perspective.micropost
	  deliveree = anthology_item.subject
	  deliveree.send_comment_subject_notify(comment_id)
	end
end