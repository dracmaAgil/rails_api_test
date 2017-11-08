class TasksController < ApplicationController

  before_action :set_task, only: [:show, :update, :destroy]

  def index
    @tasks = current_user.tasks
    json_response(@tasks)
  end

  def create
    @task = current_user.tasks.create!(task_params)
    json_response(@task, :created)
  end

  def show
    json_response(@task)
  end

  def update
    @task.update(task_params)
    head :no_content
  end

  def destroy
    @task.destroy
    head :no_content
  end

  def search
    task = current_user.tasks.where('description = ? OR website = ?', params[:description], params[:website]).first
    json_response(task)
    head :no_content
  end

  private

  def task_params
    params.permit(:description, :website, :status, :expiration_date)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

end
