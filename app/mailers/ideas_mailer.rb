class IdeasMailer < ApplicationMailer

  def notify_owner_of_like(like)
    @like = like
    @idea = like.idea
    @owner = @idea.user
    mail(to: @owner.email, subject: "idea liked!")
  end

end
