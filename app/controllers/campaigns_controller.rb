class CampaignsController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :destroy, :update, :show]
  before_action :campaign_belongs_to_logged_in_user, only: [:show]
  skip_before_action :verify_authenticity_token

  def new
    @campaign = Campaign.new
  end

  def show
    @campaign = current_user.campaigns.find_by(id: params[:id])
  end

  def index
    @campaigns = @current_user.campaigns.paginate(page: params[:page], 
                                                  per_page: 6)
  end

   def create
    @campaign = current_user.campaigns.build(campaign_params)
    if @campaign.save
      flash[:success] = "Campaign created!"
      redirect_to campaigns_path
    else
      render 'new'
    end
  end

  def destroy
    @campaign = current_user.campaigns.find_by(id: params[:id])
    if @campaign.nil?
      redirect_to root_url
    else
      @campaign.destroy
      flash[:success] = "Campaign deleted!"
      redirect_to campaigns_path
    end
  end

  def update
    @campaign = current_user.campaigns.find_by(id: params[:id])
    if @campaign.update_attributes(campaign_params)
      flash[:success] = "Campaign updated!"
      redirect_to campaigns_path
    else
      render 'show'
    end
  end

  def start_campaign
    require 'net/smtp'
    
    @campaign = current_user.campaigns.find_by(id: params[:campaign_id])
    @template = current_user.templates.find_by(id: @campaign.template_id)
    if @template.nil?
      flash[:danger] = "Template not found!"
      redirect_to campaigns_path and return
    end

    body = @template.description
    link = body[/.*<([^>]*)/, 1]
    injected_link = link + '?uid=' + current_user.id.to_s + '&cid=' + @campaign.id.to_s + '&vid=1 '
    #injected_html_link = '<a href="' + link + '?uid=' + current_user.id.to_s + '&cid=' + @campaign.id.to_s + '&vid=1' + '">here</a>'
    body.sub! '<' + link + '>', injected_link

    #debugger

    msg = <<END_OF_MESSAGE
From: #{@campaign.from_alias} <#{@campaign.from}>
To: <#{@campaign.victims}>
Subject: #{@campaign.subject}

#{body}
END_OF_MESSAGE
    begin
      smtp = Net::SMTP.start(@campaign.smtp_server)
      #smtp = Net::SMTP.start @campaign.smtp_server, 25, 'localhost.localdomain', 'ovecheiubire@gmx.com', 'Parolade12345', :login
      sendMsg = smtp.send_message msg, @campaign.from, @campaign.victims
      if "250" == sendMsg.status
        flash[:success] = "SMTP reply code: 250 (Requested mail action okay, completed)"
        redirect_to campaigns_path and return
      else
        flash[:danger] = "SMTP reply code: " + sendMsg.status
        redirect_to campaigns_path and return
      end
    rescue Exception => e
      flash[:danger] = e.to_s
      redirect_to campaigns_path and return
    end
  end

  private

    def campaign_params
      params.require(:campaign).permit(:name, :smtp_server, :from, :from_alias,
                                        :subject, :template_id, :victims)
    end

    # Confirms that the campaign belongs to the active user
    def campaign_belongs_to_logged_in_user
      @campaign = current_user.campaigns.find_by(id: params[:id])
      redirect_to(root_url) if @campaign.nil?
    end
end
