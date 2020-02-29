class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
    if params[:tags_name_key]
      tag = Tag.where('tags_name LIKE ?', "#{params[:tags_name_key]}")
      tag1 = tag[0]
      if tag1.nil?
        @tasks = []
      else
        task_tags = TaskTag.where(tag_id: tag1.id)
        @tasks = task_tags.map { |task_tag| Task.find(task_tag.task_id) }
      end
    else
      @tasks = @project.tasks.all
    end
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to "/projects/#{@project.id}"
    else
      redirect_to "/projects/new"
    end
  end

  def update
    if @project.update(project_params)
      redirect_to "/projects/#{@project.id}"
    else
      redirect_to "/projects/#{@project.id}/edit"
    end
  end

  def destroy
    @project.destroy
    redirect_to "/projects"
  end

  private
  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.fetch(:project, {}).permit(:name)
  end
end
