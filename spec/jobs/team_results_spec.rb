require 'rails_helper'
require 'sucker_punch'

RSpec.describe TeamResults, type: :job do
  describe "Should import results and calculate team results" do
    before(:all) do
      clear_all_results
      # load day 1 results
      configuration = Config.find_by(active_config: true)
      configuration = Config.create_default_config unless configuration  
      configuration.update(day: 1)

      source = file_fixture("OE0014_day_one_results.csv")
      @target = File.join(".", "tmp/OE0014_day_one_results.csv")
      FileUtils.cp(source, @target)
      TeamResults.new.perform([@target])
      # load day 2 results
      Config.last.update(day: 2)
      source = file_fixture("OE0014_day_two_results.csv")
      @target = File.join(".", "tmp/OE0014_day_two_results.csv")
      FileUtils.cp(source, @target)
      TeamResults.new.perform([@target])
    end

    it "should remove input file" do
      expect(File).not_to exist(@target)
    end

    it "should calculate the Average Waited Times- varsity" do
      isvm = Day1Awt.where(entryclass: "ISVM").order("runner1_float_time").first
      isvf = Day1Awt.where(entryclass: "ISVF").order("runner1_float_time").first
      expect(isvm.runner1_float_time).to equal(54.18333333333333)
      expect(isvm.runner2_float_time).to equal(57.65)
      expect(isvm.runner3_float_time).to equal(58.233333333333334)
      expect(isvm.awt_float_time).to equal(56.68888888888889)
      expect(isvf.runner1_float_time).to equal(68.7)
      expect(isvf.runner2_float_time).to equal(76.7)
      expect(isvf.runner3_float_time).to equal(79.4)
      expect(isvf.awt_float_time).to equal(74.93333333333334)
   end

    it "should calculate the Average Waited Times- junior varsity" do
      isjvm = Day1Awt.where(entryclass: "ISJVM").order("runner1_float_time").first
      isjvf = Day1Awt.where(entryclass: "ISJVF").order("runner1_float_time").first
      expect(isjvm.runner1_float_time).to equal(32.46666666666667)
      expect(isjvm.runner2_float_time).to equal(35.36666666666667)
      expect(isjvm.runner3_float_time).to equal(35.93333333333333)
      expect(isjvm.awt_float_time).to equal(34.588888888888896)
      expect(isjvf.runner1_float_time).to equal(67.8)
      expect(isjvf.runner2_float_time).to equal(71.28333333333333)
      expect(isjvf.runner3_float_time).to equal(80.68333333333334)
      expect(isjvf.awt_float_time).to equal(73.25555555555555)
    end

    it "should calculate the Average Waited Times- intermediate" do
      isim = Day1Awt.where(entryclass: "ISIM").order("runner1_float_time").first
      isif = Day1Awt.where(entryclass: "ISIF").order("runner1_float_time").first
      expect(isim.runner1_float_time).to equal(26.333333333333332)
      expect(isim.runner2_float_time).to equal(30.266666666666666)
      expect(isim.runner3_float_time).to equal(33.266666666666666)
      expect(isim.awt_float_time).to equal(29.955555555555552)
      expect(isif.runner1_float_time).to equal(36.233333333333334)
      expect(isif.runner2_float_time).to equal(49.96666666666667)
      expect(isif.runner3_float_time).to equal(55.0166666666666664)
      expect(isif.awt_float_time).to equal(47.07222222222222)
    end

    it "should assign teams" do
      expect(Team.count).to equal(47)
      expect(Team.where.not(JROTC_branch: nil).count).to equal(22)
      expect(Team.where(entryclass: 'ISV').count).to equal(13)
      expect(Team.where(entryclass: 'ISJV').count).to equal(18)
      expect(Team.where(entryclass: 'ISI').count).to equal(6)
      expect(Team.where(entryclass: 'ISJV').count).to equal(18)
      expect(Team.where(entryclass: 'ICC').count).to equal(3)
      expect(Team.where(entryclass: 'ICJV').count).to equal(4)
      expect(Team.where(entryclass: 'ICV').count).to equal(3)
    end

    it "should calculate the Average Waited Times- ICC" do
      iccm = Day1Awt.where(entryclass: "ICCM").order("runner1_float_time").first
      iccf = Day1Awt.where(entryclass: "ICCF").order("runner1_float_time").first
      expect(iccm.runner1_float_time).to equal(26.333333333333332)
      expect(iccm.runner2_float_time).to equal(33.266666666666666)
      expect(iccm.runner3_float_time).to equal(34.21666666666667)
      expect(iccm.awt_float_time).to equal(31.272222222222222)
      expect(iccf.runner1_float_time).to equal(36.233333333333334)
      expect(iccf.runner2_float_time).to equal(nil)
      expect(iccf.runner3_float_time).to equal(nil)
      expect(iccf.awt_float_time).to equal(36.233333333333334)
    end

    it "should calculate the Average Waited Times- ICJV" do
      iccm = Day1Awt.where(entryclass: "ICJVM").order("runner1_float_time").first
      iccf = Day1Awt.where(entryclass: "ICJVF").order("runner1_float_time").first
      expect(iccm.runner1_float_time).to equal(32.46666666666667)
      expect(iccm.awt_float_time).to equal(34.588888888888896)
      expect(iccf.runner1_float_time).to equal(71.28333333333333)
      expect(iccf.awt_float_time).to equal(91.70833333333334)
    end

    it "should calculate the Average Waited Times- ICV" do
      iccm = Day1Awt.where(entryclass: "ICVM").order("runner1_float_time").first
      iccf = Day1Awt.where(entryclass: "ICVF").order("runner1_float_time").first
      expect(iccm.runner1_float_time).to equal(54.18333333333333)
      expect(iccm.awt_float_time).to equal(57.28888888888889)
      expect(iccf.runner1_float_time).to equal(76.7)
      expect(iccf.awt_float_time).to equal(85.68888888888891)
    end

    # Validate caluclations
    # 
    # Scoring for each race will be done in accordance with OUSA Intercollegiate and Interscholastic 
    # competition rules as follows:
    #
    # * For each Individual Intercollegiate and Interscholastic class, an AWT (the average winning time) 
    #   is defined as the average of the times of the top three competitors in that class who are competing 
    #   in a team category.
    # * For each class, for each competitor with a valid result, their score is computed as 
    #   60*(competitor’s time)/ (AWT for the class).
    # * For competitors with an OT, MP, DNF or DSQ result, their score will be the larger of 
    #   10+60*(course time limit)/ (AWT for the male class) and 
    #   10+60*(course time limit)/ (AWT for the female class) for that 
    #   team category/level (i.e. Varsity, JV, Intermediate, or Primary).
    
    def calc_float_time_from_timestamp(time)
      hh = time.strftime('%k').to_i
      mm = time.strftime('%M').to_i
      ss = time.strftime('%S').to_i
      total_seconds = (hh*3600 + mm*60 + ss)
      total_seconds/60.0
    end  
    

    it "validates IS varsity" do
      isvm1 = Day1Awt.find_by(entryclass: "ISVM")
      isvf1 = Day1Awt.find_by(entryclass: "ISVF")
      isvm2 = Day2Awt.find_by(entryclass: "ISVM")
      isvf2 = Day2Awt.find_by(entryclass: "ISVF")
      top_three_male1 = Runner.where(entryclass: 'ISVM', classifier1: '0').order(:time1).limit(3)
      top_three_female1 = Runner.where(entryclass: 'ISVF', classifier1: '0').order(:time1).limit(3)
      top_three_male2 = Runner.where(entryclass: 'ISVM', classifier1: '0').order(:time2).limit(3)
      top_three_female2 = Runner.where(entryclass: 'ISVF', classifier1: '0').order(:time2).limit(3)

      # male times
      total_time_day1 = 0
      total_time_day2 = 0
      i = 0
      top_three_male1.each do |r|  
        i += 1
        calculated_float_time = calc_float_time_from_timestamp(r.time1)
        expect(calculated_float_time).to eq(r.float_time1)
        total_time_day1 += r.float_time1
        expect(eval("isvm1.runner#{i}_float_time")).to eq(r.float_time1)
      end  
      expect(total_time_day1/3).to eq(isvm1.awt_float_time)

      i = 0
      top_three_male2.each do |r|  
        i += 1
        calculated_float_time = calc_float_time_from_timestamp(r.time2)
        expect(calculated_float_time).to eq(r.float_time2)
        total_time_day2 += r.float_time2
        expect(eval("isvm2.runner#{i}_float_time")).to eq(r.float_time2)
      end  
      expect(total_time_day2/3).to eq(isvm2.awt_float_time)
  
      # female times
      total_time_day1 = 0
      total_time_day2 = 0
      i = 0
      top_three_female1.each do |r|  
        i += 1
        calculated_float_time = calc_float_time_from_timestamp(r.time1)
        expect(calculated_float_time).to eq(r.float_time1)
        total_time_day1 += r.float_time1
        expect(eval("isvf1.runner#{i}_float_time")).to eq(r.float_time1)
      end  
      expect(total_time_day1/3).to eq(isvf1.awt_float_time)

      i = 0
      top_three_female2.each do |r|  
        i += 1
        calculated_float_time = calc_float_time_from_timestamp(r.time2)
        expect(calculated_float_time).to eq(r.float_time2)
        total_time_day2 += r.float_time2
        expect(eval("isvf2.runner#{i}_float_time")).to eq(r.float_time2)
      end  
      expect(total_time_day2/3).to eq(isvf2.awt_float_time)
    end  

    it "validates OT, MP, DNF or DSQ results" do
      config ||= Config.last
      max_time = config.max_time

      runner = Runner.where(entryclass: 'ISVM', classifier1: ['2','3','4','5']).order(:time1).first
      isvm1 = Day1Awt.find_by(entryclass: "ISVM")

      runner_score = 10 + (60 * (max_time/isvm1.cat_float_time) )
      expect(runner_score).to eq(runner.day1_score)
    end   

  end
end

