class UserMailer < ActionMailer::Base
  default :from => "noreply@kpsu.org"
  def welcome_email(user, password)
    @from       =   "KPSU Website<noreply@kpsu.org>"
    @user = user
    @password = password
    @url = "http://www.kpsu.org/login"
    @sent_on    =   Time.zone.now
    mail(:to => user.email, :subject => "Welcome to KPSU.org!")

  end
  
  def new_comment(user, record)
    @from       =   "KPSU Website<noreply@kpsu.org>"
    @user = user
    @comment = record
    if record.recipient
      @type = ""
    elsif record.reply_id
      @type = ""
    elsif record.post_id
      @post = Post.find(record.post_id)
      @type = @post.title
    elsif record.playlist_id
      @playlist = Playlist.find(record.playlist_id)
      @type = @playlist.title
    elsif record.review_id
      @review = Review.find(record.review_id)
      @type = @review.title
    elsif record.program_id
      @program = Program.find(record.program_id)
      @type = @program.title
    end
    @sent_on    =   Time.zone.now
    mail(:to => user.email, :subject => "You received a new comment on KPSU.org!")
    
  end
  
  
end
