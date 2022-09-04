class RunnersController < ApplicationController
  def index
    @runners = Runner.all.order(:school, :entryclass, :lastname, :firstname)
  end
end
