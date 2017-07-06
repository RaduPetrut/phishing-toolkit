class ReportsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @report = current_user.reports.find_by(id: params[:id])
  end

  def index
    @reports = current_user.reports.paginate(page: params[:page], per_page: 6)
    #debugger
  end

  def destroy
    #debugger
    @report = current_user.reports.find_by(id: params[:id])
    if @report.nil?
      redirect_to root_url
    else
      @report.destroy
      flash[:success] = "Report deleted!"
      redirect_to reports_path
    end
  end

  def create_report
    associated_user = User.find_by(id: params[:uid])
    associated_campaign = associated_user.campaigns.find_by(id: params[:cid])
    #debugger
    @report = associated_user.reports.create!(campaign: associated_campaign.name,
                                         victim: associated_campaign.victims,
                                         username: params[:username],
                                         password: params[:password])
  end

  private

    def report_params
      #params.require(:password).permit(:victim, :username, :password)
      params.require(:password)
    end
end
