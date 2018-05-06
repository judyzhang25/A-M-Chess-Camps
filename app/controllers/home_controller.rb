class HomeController < ApplicationController
  
  def index
    def home_bool
      true
    end
  end

  def about
    def home_bool
      false
    end
  end

  def contact
    def home_bool
      false
    end
  end

  def privacy
    def home_bool
      false
    end
  end
  
  def dash
    def home_bool
      false
    end
    @chart2 = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => "Population vs GDP For 5 Big Countries [2009]")
      f.xAxis(:categories => ["United States", "Japan", "China", "Germany", "France"])
      f.series(:name => "GDP in Billions", :yAxis => 0, :data => [14119, 5068, 4985, 3339, 2656])
      f.series(:name => "Population in Millions", :yAxis => 1, :data => [310, 127, 1340, 81, 65])

      f.yAxis [
        {:title => {:text => "GDP in Billions", :margin => 70} },
        {:title => {:text => "Population in Millions"}, :opposite => true},
      ]

      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
      f.chart({:defaultSeriesType=>"column"})
    end

    @chart3 = LazyHighCharts::HighChart.new('pie') do |f|
          f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
          series = {
                   :type=> 'pie',
                   :name=> 'Browser share',
                   :data=> [
                      ['Firefox',   45.0],
                      ['IE',       26.8],
                      {
                         :name=> 'Chrome',    
                         :y=> 12.8,
                         :sliced=> true,
                         :selected=> true
                      },
                      ['Safari',    8.5],
                      ['Opera',     6.2],
                      ['Others',   0.7]
                   ]
          }
          f.series(series)
          f.options[:title][:text] = "THA PIE"
          f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
          f.plot_options(:pie=>{
            :allowPointSelect=>true, 
            :cursor=>"pointer" , 
            :dataLabels=>{
              :enabled=>true,
              :color=>"black",
              :style=>{
                :font=>"13px Trebuchet MS, Verdana, sans-serif"
              }
            }
          })
    end

    @chart4 = LazyHighCharts::HighChart.new('column') do |f|
      f.series(:name=>'John',:data=> [3, 20, 3, 5, 4, 10, 12 ])
      f.series(:name=>'Jane',:data=>[1, 3, 4, 3, 3, 5, 4,-46] )     
      f.title({ :text=>"example test title from controller"})
      f.options[:chart][:defaultSeriesType] = "column"
      f.plot_options({:column=>{:stacking=>"percent"}})
    end
  end
  
end