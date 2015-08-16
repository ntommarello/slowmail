class LettersController < ApplicationController

  before_filter :authenticate



  def index

    if params[:username]

      @user = User.find_by_username(params[:username])

      if @user
        @letters = Letter.received_or_sent(current_user.id,@user).order_by_date
        @page_title = "#{@user.first_name} #{@user.last_name}"
      else
        @letters = Letter.matching_tag(params[:username]).order_by_date
        if @letters and @letters.length > 0 and current_user
          @page_title = @letters[0].writing_partner_names(current_user)
        end
      end

      if @letters and @letters.length > 0 and current_user
        for letter in @letters
          #can't be good performance on long threads.  n+1
          @subscribed = SubscribedLetter.find(:first, :conditions=>["letter_id = ? and user_id = ?",letter.id,current_user.id])
          if @subscribed and @subscribed.read != true
            @subscribed.read = true
            @subscribed.read_on = Time.now
            @subscribed.save!
          end
        end

      end

    end

  end




  def create


  end

  def draft

    User.algolia_reindex!

    @search = User.search("cindy")


    @draft_in_progress = true

    @receiver_id = []

    @user = User.find_by_username(params[:username])


      if @user
        @names = "#{@user.first_name}"
        @receiver_id.push(@user.id)
      else
        @letters = Letter.matching_tag(params[:username]).order_by_date
        if @letters and @letters.length > 0 and current_user
            @names = @letters[0].writing_partner_names(current_user)
            @receiver_id = @letters[0].writing_partner_ids(current_user).dup
        end
      end

    
    @letters = Letter.draft_for(current_user,request.path.gsub(".json",""))
    @letter = @letters .first

    respond_to do |format|
      format.html {
        @page_title = "Draft Letter: #{@names}"

        unless @letter
          @letter = Letter.new
          @letter.author_id = current_user.id
          @letter.salutation = "Hi, #{@names}!"
          for reciever in @receiver_id
            @letter.subscribed_letters.new(letter_id: @letter.id, user_id: reciever)
          end
          #replace with geocode
          @letter.city = "San Francisco"
          #tag re-purposed when draft.  renamed when mailed
          @letter.mailed = false
          @letter.tag = request.path
          @letter.save!
        end
      }
      format.json {

      }
    end
  end


  def save_draft
    @letter = Letter.draft_for(current_user,params[:tag]).first
    @letter.content = params[:draft]
    @letter.save!
    render :text=>"1"
  end

  def mail_letter
    @letter = Letter.find(params[:letter][:id])
     @letter.update_attributes(params[:letter])

    @delivery_date = Time.now + 2.days
    if params[:letter][:delivery_method]
      if params[:letter][:delivery_method] == "Pony Express"
        @delivery_date = Time.now + 3.days
      elsif params[:letter][:delivery_method] == "Stagecoach"
        @delivery_date = Time.now + 5.days
      else
        @delivery_date = Time.now + 10.days
      end
    end

    @letter.participant_ids = @letter.get_participant_ids
    @letter.delivery_date = @delivery_date
    @letter.mailed = true
    @letter.mailed_at = Time.now
    @letter.to_count = @letter.recipients.count

    #should be in model, but had problems saving
    if @letter.recipients.count > 1
      past_letter = Letter.find(:first, :conditions=>["participant_ids = ?",@letter.get_participant_ids])
      if past_letter
        @letter.tag = past_letter.tag
      else
        tag = ""
        for user in @letter.recipients
          tag = "#{tag}#{user.first_name}."
        end
        tag = "#{tag}#{@letter.author.first_name}"
        i = 0;
        @letter.tag = loop do
          if i == 0
            temp_tag = "#{tag}".downcase
          else
            temp_tag = "#{tag}.#{i}".downcase
          end
          i = i + 1
          break temp_tag unless Letter.exists?(tag: temp_tag)
        end
      end
    else
       @letter.tag = @letter.recipients[0].username
    end

    @letter.save!
    @letter.update_sidebar_for_author  
    redirect_to @letter.letter_url_for(current_user)
  end


  def deliver_now

    @letter = Letter.find(params[:id])

    if current_user and current_user.admin and @letter

      @letter.deliver_letter

    end

    render :text=>"Sent"

  end



  def destroy
    @letter = Letter.find(params[:id])
    @letter.destroy
    redirect_to :back
  end

end
