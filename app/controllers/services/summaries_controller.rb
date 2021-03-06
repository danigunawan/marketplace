# frozen_string_literal: true

class Services::SummariesController < Services::ApplicationController
  before_action :ensure_in_session!
  before_action :ensure_valid!

  def show
    @project_item = project_item_template
  end

  def create
    authorize(project_item_template)

    @project_item = ProjectItem::Create.new(project_item_template).call

    if @project_item.persisted?
      session.delete(session_key)
      @related_services = @service.related_services.includes(:provider)
      render :confirmation
    else
      redirect_to service_configuration_path(@service),
                  alert: "Service request configuration invalid"
    end
  end

  private

    def ensure_valid!
      unless project_item_template.valid?
        redirect_to service_configuration_path(@service),
                    alert: "Please configure your service request"
      end
    end

    def project_item_template
      ProjectItem.new(session[session_key])
    end
end
