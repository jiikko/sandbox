class DoclerContainersController < ApplicationController
  def index
    @docker_containers = DoclerContainer.all
  end

  def new
    @docker_container = DoclerContainer.new
  end

  def create
    @docker_container = DoclerContainer.new(dc_params)
    if @docker_container.save
      redirect_to(@docker_container)
    else
      render :new
    end
  end

  def show
  end

  private

  def dc_params
    params.required(:docler_container).permit!
  end
end
