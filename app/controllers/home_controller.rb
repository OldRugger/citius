class HomeController < ApplicationController
  def index
  end

  def clear_results
    puts '====> clear all resutls <====='
    TeamMember.delete_all
    Team.delete_all
    Runner.delete_all
    Day1Awt.delete_all
    Day2Awt.delete_all
  
    flash[:notice] = 'Deleted all resutls'

    redirect_to controller: 'home', action: 'index'

  end  

end
