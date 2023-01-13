class ResultsController < ApplicationController

  def clear_results
    puts "====> clear all resutls <====="
    TeamMember.delete_all
    Team.delete_all
    Runner.delete_all
    Day1Awt.delete_all
    Day2Awt.delete_all

    flash[:notice] = 'Deleted all resutls'

    redirect_to controller: 'home', action: 'index'
  end

  def team_results
    @class_list = ApplicationHelper::CLASS_LIST
    @awt = get_awt_hash
    @classes = get_is_teams_by_class
    get_results_by_day(@awt)
  end

  def jrotc_team_results
    @class_list = ApplicationHelper::CLASS_LIST
    @awt = get_awt_hash
    @classes = get_jrotc_teams_by_class
    get_results_by_day(@awt)
  end

  def other_team_results
    @class_list = ApplicationHelper::CLASS_LIST
    @jrotc_class_list = ApplicationHelper::CAT_LIST_JROTC
    @awt = get_awt_hash
    @classes = get_other_teams_by_class
    get_results_by_day(@awt)
  end

  def club_team_results
    @class_list = ApplicationHelper::CLASS_LIST
    @awt = get_awt_hash
    @classes = get_club_teams_by_class
    get_results_by_day(@awt)
  end

  def ic_team_results
    @ic_class_list = ApplicationHelper::IC_CLASS_LIST
    @awt = get_awt_hash
    @classes = get_ic_teams_by_class
    get_results_by_day(@awt)
  end

  def awt
    @awt = get_awt_with_runners
    @class_list = ApplicationHelper::CLASS_LIST
  end

  def ic_awt
    @awt = get_awt_with_runners
    @class_list = ApplicationHelper::IC_CLASS_LIST
  end


private

  def get_is_teams_by_class
      isp = Team.where(entryclass: 'ISP', is_team_eligible: true, club: false).order(:sort_score, :day1_score, :name)
      isi = Team.where(entryclass: 'ISI', is_team_eligible: true, club: false).order(:sort_score, :day1_score, :name)
      isjv = Team.where(entryclass: 'ISJV', is_team_eligible: true, club: false).order(:sort_score, :day1_score, :name)
      isv = Team.where(entryclass: 'ISV', is_team_eligible: true, club: false).order(:sort_score, :day1_score, :name)

      classes = { 'isv'   => isv,
                  'isjv'  => isjv,
                  'isi'   => isi,
                  'isp'   => isp }
                  # 'jrotc' => jrotc }
  end

  def get_jrotc_teams_by_class
      isp = Team.where(entryclass: 'ISP', club: false).where.not(JROTC_branch: nil).order(:sort_score, :day1_score, :name)
      isi = Team.where(entryclass: 'ISI', club: false).where.not(JROTC_branch: nil).order(:sort_score, :day1_score, :name)
      isjv = Team.where(entryclass: 'ISJV', club: false).where.not(JROTC_branch: nil).order(:sort_score, :day1_score, :name)
      isv = Team.where(entryclass: 'ISV', club: false).where.not(JROTC_branch: nil).order(:sort_score, :day1_score, :name)
   
      classes = { 'isv'   => isv,
                  'isjv'  => isjv }
  end

  def get_club_teams_by_class
      isp = Team.where(entryclass: 'ISP', club: true).order(:sort_score, :day1_score, :name)
      isi = Team.where(entryclass: 'ISI', club: true).order(:sort_score, :day1_score, :name)
      isjv = Team.where(entryclass: 'ISJV', club: true).order(:sort_score, :day1_score, :name)
      isv = Team.where(entryclass: 'ISV', club: true).order(:sort_score, :day1_score, :name)
   
      classes = { 'isv'   => isv,
                  'isjv'  => isjv,
                  'isi'   => isi,
                  'isp'   => isp }
  end


  def get_other_teams_by_class
      config = Config.where(active_config: true).first
      other_class = config.other_class
      @other_class_title = config.other_class_title
      isp = Team.where(entryclass: 'ISP', JROTC_branch: other_class).order(:sort_score, :day1_score, :name)
      isi = Team.where(entryclass: 'ISI', JROTC_branch: other_class).order(:sort_score, :day1_score, :name)
      isjv = Team.where(entryclass: 'ISJV', JROTC_branch: other_class).order(:sort_score, :day1_score, :name)
      isv = Team.where(entryclass: 'ISV', JROTC_branch: other_class).order(:sort_score, :day1_score, :name)
   
      classes = { 'isv'   => isv,
                  'isjv'  => isjv }
  end

  def get_ic_teams_by_class
      icc = Team.where(entryclass: 'ICC').order(:sort_score, :day1_score, :name)
      icjv = Team.where(entryclass: 'ICJV').order(:sort_score, :day1_score, :name)
      icv = Team.where(entryclass: 'ICV').order(:sort_score, :day1_score, :name)
   
      classes = { 'icv'   => icv,
                  'icjv'  => icjv,
                  'icc'   => icc }
  end

  def get_results_by_day(awt)
    ["1", "2"].each do |day|
      awt_day = "day#{day}".to_sym
      isday = get_runner_results(day)
      process_is_day_results(isday, awt[awt_day], day)
    end
  end

  def get_runner_results(day)
    isday = TeamMember.joins(:runner)
      .select("team_members.team_id,runners.id as runner_id,
                runners.day#{day}_score as day#{day}_score,
                runners.surname")
      .order("team_members.team_id, runners.day#{day}_score")
      .load
  end

  def  process_is_day_results(isday, day_hash, day)
    team_id = 0
    team_name = nil
    results_str = nil
    isday.each do |d|
      if team_id != d.team_id
        if team_id != 0
          day_hash[team_name] = {"results": results_str, "id": team_id} if team_id !=0
        end
        team_id = d.team_id
        team_name = Team.find(team_id).name
        results_str = nil
      end
      day_score = d.send("day#{day}_score")
      if  day_score
        if results_str != nil
          results_str.concat(", #{d.surname} (#{sprintf "%.4f", day_score.round(4)})")
        else
          results_str = "#{d.surname} (#{sprintf "%.4f", day_score.round(4)})"
        end
      end
    end
    results_str = '' if results_str.nil? 
    day_hash[team_name] = {"results": results_str, "id": team_id} if results_str
  end

end