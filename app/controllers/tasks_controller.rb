class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:create, :new, :edit, :destroy, :update]

  def show
  end

  def new
    @task = Task.new
  end

  def edit
    @tag_list = @task.tags.pluck(:tags_name).join(",")
  end

  def create
    @task = Task.new(task_params)
    tag_list = params[:task][:tags_name].split(",")
      if @task.save
        @task.save_tasks(tag_list)
        redirect_to "/projects/#{@project.id}"
      else
        redirect_to "/projects/#{@project.id}/tasks/new"
      end
  end

  def update
    tag_list = params[:task][:tags_name].split(",")
    if @task.update(task_params)
      @task.save_tasks(tag_list)
      redirect_to "/projects/#{@project.id}"
    else
      redirect_to "/projects/#{@project.id}/tasks/new"
    end
  end

  def destroy
    @task.destroy
    redirect_to "/projects/#{@project.id}"
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.fetch(:task, {}).permit(:title, :deadline, :comment, :project_id)
  end
end
