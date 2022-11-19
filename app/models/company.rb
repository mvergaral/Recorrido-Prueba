class Company < ApplicationRecord
    has_many :turns,  dependent: :destroy
    has_many :turn_availabilities,  dependent: :destroy

    has_and_belongs_to_many :engineers

    accepts_nested_attributes_for :turn_availabilities



    store_accessor :schedule, 
                    :monday, 
                    :tuesday, 
                    :wednesday, 
                    :thursday, 
                    :friday, 
                    :saturday, 
                    :sunday


    def create_turns(date)
        days = date.all_week
        days.each do |day|
            week_day_start_time = self.schedule[day.strftime("%A").downcase]
            duration = ((Time.parse('24:00')-Time.parse(week_day_start_time ))/3600).to_i
            duration.times do |i|
                Turn.create(date: day.to_datetime + (Time.parse(week_day_start_time )+(i*3600)).seconds_since_midnight.seconds, company_id: self.id)
                #create turn availabilities for each engineer in the company
            end 
        end
        self.engineers.each do |engineer|
            engineer.create_turns_availabilities(date, self)
        end
    end

    def count_turns_per_engineer(date)
        turns_per_engineer = {}
        self.engineers.each do |engineer|
            turns_per_engineer[engineer.name] = engineer.turns.where(company: self, date: date.beginning_of_week..date.end_of_week.at_end_of_day).count
        end
        turns_per_engineer
    end

    def count_available_turns_per_engineer(date)
        turns_per_engineer = {}
        self.engineers.each do |engineer|
            turns_per_engineer[engineer.name] = engineer.available_turns(date, self).count
        end
        turns_per_engineer
    end


    def assign_best_turns(date)
        self.turns.where(date: date.beginning_of_week..date.end_of_week.at_end_of_day).update_all(engineer_id: nil)
        turns_per_engineer = self.count_available_turns_per_engineer(date)
        turns_per_engineer = turns_per_engineer.sort_by {|k,v| v}.to_h
        turns_per_engineer.each do |engineer, turns|
            engineer = Engineer.find_by(name: engineer)
            engineer.available_turns(date, self).each do |available_turn|
                if available_turn.turn.engineer.nil?
                    available_turn.turn.update(engineer_id: engineer.id)
                end
            end
        end
    end
end
