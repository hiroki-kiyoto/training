class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :notifier]
  before_action :set_project, only: [:create, :new, :edit, :destroy, :update, :show]

  def show
  end

  def new
    @task = Task.new
  end

  def edit
    @tag_list = @task.tags.pluck(:tags_name).join(",")
  end

  def create
    message = "作成"
    @task = Task.new(task_params)
    tag_list = params[:task][:tags_name].split(",")
      if @task.save
        # notifier(message)
        @task.save_tasks(tag_list)
        redirect_to "/projects/#{@project.id}"
      else
        redirect_to "/projects/#{@project.id}/tasks/new"
      end
  end

  def update
    message = "更新"
    tag_list = params[:task][:tags_name].split(",")
    if @task.update(task_params)
      # notifier(message)
      @task.save_tasks(tag_list)
      redirect_to "/projects/#{@project.id}"
    else
      redirect_to "/projects/#{@project.id}/tasks/new"
    end
  end

  def destroy
    @task.destroy
    redirect_to "/projects/#{@project.id}"
    message = "削除"
    # notifier(message)
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

  # def notifier(message)
  #   slakc_url = ENV['SLACK_WEBHOOK_KEY']
  #   notifier = Slack::Notifier.new(
  #     slakc_url,
  #     channel: '#ああああ',
  #     username: 'article notifier',
  #   )
  #   notifier.ping "#{@task.title}タスクが#{message}されました！！"
  # end
  
end
