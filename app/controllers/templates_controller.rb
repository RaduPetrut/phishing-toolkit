class TemplatesController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :destroy, :update, :show]
  before_action :template_belongs_to_logged_in_user, only: [:show]

  def new
    @template = Template.new
  end

  def show
    @template = current_user.templates.find_by(id: params[:id])
  end

  def index
    @templates = @current_user.templates.paginate(page: params[:page], 
                                                  per_page: 6)
  end

  def create
    @template = current_user.templates.build(template_params)
    if @template.save
      flash[:success] = "Template created!"
      redirect_to templates_path
    else
      render 'new'
    end
  end

  def destroy
    @template = current_user.templates.find_by(id: params[:id])
    if @template.nil?
      redirect_to root_url
    else
      @template.destroy
      flash[:success] = "Template deleted!"
      redirect_to templates_path
    end
  end

  def update
    @template = current_user.templates.find_by(id: params[:id])
    if @template.update_attributes(template_params)
      flash[:success] = "Profile updated"
      redirect_to @template
    else
      render 'show'
    end
  end

  private

    def template_params
      params.require(:template).permit(:name, :description)
    end

    # Confirms that the template belongs to the active user
    def template_belongs_to_logged_in_user
      @template = current_user.templates.find_by(id: params[:id])
      redirect_to(root_url) if @template.nil?
    end
end
