class AwardsController < ApplicationController
  def index
    config = Config.where(active_config: true).first

    @cat_list = ApplicationHelper::CAT_LIST

    @ic_cat_list = ApplicationHelper::IC_CAT_LIST

    @isvm = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where is_individual_eligible = true and entryclass = 'ISVM' and day1_score > 0 and day2_score > 0 order by total;")
    @isvf = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where is_individual_eligible = true and entryclass = 'ISVF' and day1_score > 0 and day2_score > 0 order by total;")
    @isjvm = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where is_individual_eligible = true and entryclass = 'ISJVM' and day1_score > 0 and day2_score > 0 order by total;")
    @isjvf = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where is_individual_eligible = true and entryclass = 'ISJVF' and day1_score > 0 and day2_score > 0 order by total;")
    @isim = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where is_individual_eligible = true and entryclass = 'ISIM' and day1_score > 0 and day2_score > 0 order by total;")
    @isif = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where is_individual_eligible = true and entryclass = 'ISIF' and day1_score > 0 and day2_score > 0 order by total;")
    @ispm = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where is_individual_eligible = true and entryclass = 'ISPM' and day1_score > 0 and day2_score > 0 order by total;")
    @ispf = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where is_individual_eligible = true and entryclass = 'ISPF' and day1_score > 0 and day2_score > 0 order by total;")
  
    @is_awards = { 
      'isvm'   => @isvm,
      'isvf'   => @isvf,
      'isjvm'  => @isjvm,
      'isjvf'  => @isjvf, 
      'isim'   => @isim,
      'isif'   => @isif, 
      'ispm'   => @ispm,
      'ispf'   => @ispf 
    }

    @isvm = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where jrotc IS NOT NULL and entryclass = 'ISVM' and day1_score > 0 and day2_score > 0 order by total;")
    @isvf = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where jrotc IS NOT NULL and entryclass = 'ISVF' and day1_score > 0 and day2_score > 0 order by total;")
    @isjvm = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where jrotc IS NOT NULL and entryclass = 'ISJVM' and day1_score > 0 and day2_score > 0 order by total;")
    @isjvf = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where jrotc IS NOT NULL and entryclass = 'ISJVF' and day1_score > 0 and day2_score > 0 order by total;")
    @isim = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where jrotc IS NOT NULL and entryclass = 'ISIM' and day1_score > 0 and day2_score > 0 order by total;")
    @isif = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where jrotc IS NOT NULL and entryclass = 'ISIF' and day1_score > 0 and day2_score > 0 order by total;")
    @ispm = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where jrotc IS NOT NULL and entryclass = 'ISPM' and day1_score > 0 and day2_score > 0 order by total;")
    @ispf = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where jrotc IS NOT NULL and entryclass = 'ISPF' and day1_score > 0 and day2_score > 0 order by total;")
 
    
    @jrotc_awards = { 
      'isvm'   => @isvm,
      'isvf'   => @isvf,
      'isjvm'  => @isjvm,
      'isjvf'  => @isjvf, 
      'isim'   => @isim,
      'isif'   => @isif, 
      'ispm'   => @ispm,
      'ispf'   => @ispf 
    }

    @other_class = config.other_class

    @isvm = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where jrotc = '#{@other_class}' and entryclass = 'ISVM' and day1_score > 0 and day2_score > 0 order by total;")
    @isvf = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where jrotc IS NOT NULL and entryclass = 'ISVF' and day1_score > 0 and day2_score > 0 order by total;")
    @isjvm = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where jrotc IS NOT NULL and entryclass = 'ISJVM' and day1_score > 0 and day2_score > 0 order by total;")
    @isjvf = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where jrotc IS NOT NULL and entryclass = 'ISJVF' and day1_score > 0 and day2_score > 0 order by total;")
    @isim = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where jrotc IS NOT NULL and entryclass = 'ISIM' and day1_score > 0 and day2_score > 0 order by total;")
    @isif = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where jrotc IS NOT NULL and entryclass = 'ISIF' and day1_score > 0 and day2_score > 0 order by total;")
    @ispm = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where jrotc IS NOT NULL and entryclass = 'ISPM' and day1_score > 0 and day2_score > 0 order by total;")
    @ispf = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where jrotc IS NOT NULL and entryclass = 'ISPF' and day1_score > 0 and day2_score > 0 order by total;")


    @other_awards = { 
      'isvm'   => @isvm,
      'isvf'   => @isvf,
      'isjvm'  => @isjvm,
      'isjvf'  => @isjvf, 
      'isim'   => @isim,
      'isif'   => @isif, 
      'ispm'   => @ispm,
      'ispf'   => @ispf 
    }

    @icvm = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where is_individual_eligible = true and entryclass = 'ICVM' and day1_score > 0 and day2_score > 0 order by total;")
    @icvf = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where is_individual_eligible = true and entryclass = 'ICVF' and day1_score > 0 and day2_score > 0 order by total;")
    @icjvm = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where is_individual_eligible = true and entryclass = 'ICJVM' and day1_score > 0 and day2_score > 0 order by total;")
    @icjvf = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where is_individual_eligible = true and entryclass = 'ICJVF' and day1_score > 0 and day2_score > 0 order by total;")
    @iccm = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where is_individual_eligible = true and entryclass = 'ICCM' and day1_score > 0 and day2_score > 0 order by total;")
    @iccf = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total " +
      "FROM runners where is_individual_eligible = true and entryclass = 'ICCF' and day1_score > 0 and day2_score > 0 order by total;")

    @ic_awards = { 
      'icvm'   => @icvm,
      'icvf'   => @icvf,
      'icjvm'  => @icjvm,
      'icjvf'  => @icjvf, 
      'iccm'   => @iccm,
      'iccf'   => @iccf 
    }
  end
end