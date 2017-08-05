class Admin::ResumesController < ApplicationController
before_action :authenticate_user!
before_action :authenticate_is_admin!

def inex
  @job = Job.find(params[:job_id])
  @resumes = @job.resumes.order('created_at DESC')
end

end
