class AwardsController < ApplicationController
  def index
    @cat_list = ApplicationHelper::CAT_LIST

    @ic_cat_list = ApplicationHelper::IC_CAT_LIST

    @isvm = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total FROM runners where entryclass = 'ISVM' and day1_score > 0 and day2_score > 0 order by total;")
    @isvf = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total FROM runners where entryclass = 'ISVF' and day1_score > 0 and day2_score > 0 order by total;")
    @isjvm = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total FROM runners where entryclass = 'ISJVM' and day1_score > 0 and day2_score > 0 order by total;")
    @isjvf = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total FROM runners where entryclass = 'ISJVF' and day1_score > 0 and day2_score > 0 order by total;")
    @isim = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total FROM runners where entryclass = 'ISIM' and day1_score > 0 and day2_score > 0 order by total;")
    @isif = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total FROM runners where entryclass = 'ISIF' and day1_score > 0 and day2_score > 0 order by total;")
    @ispm = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total FROM runners where entryclass = 'ISPM' and day1_score > 0 and day2_score > 0 order by total;")
    @ispf = Runner.find_by_sql("SELECT firstname, surname, school, day1_score, day2_score, (day1_score + day2_score) as total FROM runners where entryclass = 'ISPF' and day1_score > 0 and day2_score > 0 order by total;")
  
    @is_awards = { 'isvm'   => @isvm,
                'isvf'   => @isvf,
                'isjvm'  => @isjvm,
                'isjvf'  => @isjvf, 
                'isim'   => @isim,
                'isif'   => @isif, 
                'ispm'   => @ispm,
                'ispf'   => @ispf 
              }

    @jrotc_awards = {}

    @other_awards = {}

    @ic_awards = {}
  end
end