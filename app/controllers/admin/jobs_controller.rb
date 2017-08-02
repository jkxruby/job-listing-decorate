class Admin::JobsController < ApplicationController
before_action :authenticate_user!, only: [:new, :index, :edit, :update, :create, :destroy]
before_action :require_is_admin

def new
  @job = Job.new
end

def create
  @job = Job.new(job_params)
  @job.user = current_user
  if @job.save
    redirect_to admin_jobs_path
  else
    render :new
  end
end

def index
  @jobs = Job.all
end

def show
  @job = Job.find(params[:id])
end

def edit
  @job = Job.find(params[:id])
end

def update
  @job = Job.find(params[:id])
  if @job.update(job_params)
    redirect_to admin_jobs_path,notice: "update success"
  else
    render :edit
  end
end

def destroy
  @job = Job.find(params[:id])
  @job.destroy
  redirect_to admin_jobs_path,alert: "delete success"
end

def require_is_admin
  if !current_user.admin?
    flash[:alert] = 'you are not admin'
    redirect_to root_path
  end
end


private

def job_params
  params.require(:job).permit(:title, :description)
end

end
