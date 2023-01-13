class TeamsController < ApplicationController

  def team_list
    @teams = Team.all.order(:school, :name, :entryclass)
  end

  def index
    @class_list = ApplicationHelper::CLASS_LIST
    @cat_list =  ApplicationHelper::CAT_LIST

    @ic_class_list = ApplicationHelper::IC_CLASS_LIST
    @ic_cat_list =  ApplicationHelper::IC_CAT_LIST

    awt = get_awt_with_runners

    isp = Team.where(entryclass: 'ISP', is_team_eligible: true, club: false).order(:sort_score, :day1_score, :name)
    isi = Team.where(entryclass: 'ISI', is_team_eligible: true, club: false).order(:sort_score, :day1_score, :name)
    isjv = Team.where(entryclass: 'ISJV', is_team_eligible: true, club: false).order(:sort_score, :day1_score, :name)
    isv = Team.where(entryclass: 'ISV', is_team_eligible: true, club: false).order(:sort_score, :day1_score, :name)

    @is_teams = { 'isv'   => isv,
                  'isjv'  => isjv,
                  'isi'   => isi,
                  'isp'   => isp }

    club_isp = Team.where(entryclass: 'ISP', is_team_eligible: true, club: true).order(:sort_score, :day1_score, :name)
    club_isi = Team.where(entryclass: 'ISI', is_team_eligible: true, club: true).order(:sort_score, :day1_score, :name)
    club_isjv = Team.where(entryclass: 'ISJV', is_team_eligible: true, club: true).order(:sort_score, :day1_score, :name)
    club_isv = Team.where(entryclass: 'ISV', is_team_eligible: true, club: true).order(:sort_score, :day1_score, :name)

    @club_teams = { 'isv'   => club_isv,
                    'isjv'  => club_isjv,
                    'isi'   => club_isi,
                    'isp'   => club_isp }



    jrotc_isp = Team.where(entryclass: 'ISP').where.not(JROTC_branch: nil).order(:sort_score, :day1_score, :name)
    jrotc_isi = Team.where(entryclass: 'ISI').where.not(JROTC_branch: nil).order(:sort_score, :day1_score, :name)
    jrotc_isjv = Team.where(entryclass: 'ISJV').where.not(JROTC_branch: nil).order(:sort_score, :day1_score, :name)
    jrotc_isv = Team.where(entryclass: 'ISV').where.not(JROTC_branch: nil).order(:sort_score, :day1_score, :name)
           
    @jrotc_teams = { 'isv'   => jrotc_isv,
                     'isjv'  => jrotc_isjv }
    
    config = Config.where(active_config: true).first
    if config.other_class 
      other_class = config.other_class
      other_isp = Team.where(entryclass: 'ISP').where(JROTC_branch: other_class).order(:sort_score, :day1_score, :name)
      other_isi = Team.where(entryclass: 'ISI').where(JROTC_branch: other_class).order(:sort_score, :day1_score, :name)
      other_isjv = Team.where(entryclass: 'ISJV').where(JROTC_branch: other_class).order(:sort_score, :day1_score, :name)
      other_isv = Team.where(entryclass: 'ISV').where(JROTC_branch: other_class).order(:sort_score, :day1_score, :name)
      @other_teams = { 'isv'   => other_isv,
                       'isjv'  => other_isjv,
                       'title' => config.other_class_title }
    else
      @other_teams = nil
    end  

    icc = Team.where(entryclass: 'ICC').order(:sort_score, :day1_score, :name)
    icjv = Team.where(entryclass: 'ICJV').order(:sort_score, :day1_score, :name)
    icv = Team.where(entryclass: 'ICV').order(:sort_score, :day1_score, :name)

    @ic_teams = { 'icv'  => icv,
                  'icjv' => icjv,
                  'icc'  => icc }
    

    @runners = TeamMember.joins(:runner, :team)
      .select("team_members.team_id, runners.id as runner_id,
              runners.database_id as database_id,
              runners.firstname   as firstname,
              runners.surname     as surname,
              runners.time1       as time1,
              runners.time2       as time2,
              runners.float_time1 as float_time1,
              runners.float_time2 as float_time2,
              runners.classifier1 as classifier1,
              runners.classifier2 as classifier2,
              runners.day1_score  as day1_score,
              runners.day2_score  as day2_score,
              runners.entryclass  as entryclass,
              teams.name          as team_name")
      .order("team_members.team_id, runners.surname").load
  end


  def show
    @team = Team.find(params[:id])
    @runners = TeamMember.joins(:runner)
      .select("team_members.team_id, runners.id as runner_id,
              runners.firstname   as firstname,
              runners.surname     as surname,
              runners.time1       as time1,
              runners.time2       as time2,
              runners.float_time1 as float_time1,
              runners.float_time2 as float_time2,
              runners.day1_score  as day1_score,
              runners.day2_score  as day2_score,
              runners.entryclass  as entryclass ")
      .where(team_id: params[:id]).all

    awt = get_awt_hash
    @day1_hash = awt[:day1]
    @day2_hash = awt[:day2]
  end
end