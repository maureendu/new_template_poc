class ProjectsController < ApplicationController
  def create
    @project = Project.new(project_attributes)
    if @project.valid?
      # TODO - project validations
      @project.save
      render status: :created, json: { project_id: @project.id }
    end
  rescue => e
    # TODO - realistic error handling
    render status: :unprocessable_entity, json: { reason: e.message }
  end

  def index
    render status: :ok, json: {count: Project.all.count, projects: Project.all }
  end

  def project_params
    params.permit(
      :bill_method,
      :budgeted_hours,
      :close_reason,
      :description,
      :external_id,
      :employer_id,
      :title,
      :full_time,
      :markup,
      :number_of_roles,
      :preferred_experience_level,
      :project_based,
      :rate,
      :remote_ok,
      :remote_percentage,
      :request_payload,
      :start_date,
      :status,
      :travel_required,
      locations: [:zip]
    )
  end


  def project_attributes
    {
      # ats_employer_id: ats_employer.id,
      # ats_project_status: ats_project_status,
      bill_method: project_params[:bill_method],
      budgeted_hours: project_params[:budgeted_hours],
      close_reason: project_params[:close_reason],
      description: project_params[:description],
      external_id: project_params[:external_id],
      employer_id: project_params[:employer_id],
      full_time: project_params[:full_time],
      locations: project_params[:locations],
      markup: project_params[:markup],
      number_of_roles: project_params[:number_of_roles],
      preferred_experience_level: project_params[:preferred_experience_level],
      project_based: project_params[:project_based],
      rate: project_params[:rate],
      remote_ok: project_params[:remote_ok],
      remote_percentage: project_params[:remote_percentage],
      request_payload: request.filtered_parameters[:project],
      start_date: project_params[:start_date],
      title: project_params[:title],
      travel_required: project_params[:travel_required]
    }
  end
end
