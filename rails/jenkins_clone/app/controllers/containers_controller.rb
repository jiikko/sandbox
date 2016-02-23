class ContainersController < ApplicationController
  def index
    @containers = Container.all
  end

  def new
    @container = Container.new
  end

  def create
    @container = Container.new(dc_params)
    if @container.save
      redirect_to(@container)
    else
      render :new
    end
  end

  def show
    @container = Container.find(params[:id])
  end

  def execute
    @container = Container.find(params[:id])
    queued_job = @container.executable_jobs.find_by(name: params[:job_name]).execute!
    redirect_to queued_job
  end

  private

  def dc_params
    params.required(:container).permit!
  end
end
