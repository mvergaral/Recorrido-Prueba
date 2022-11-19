class Engineer < ApplicationRecord
    has_many :turns 
    has_many :turn_availabilities,  dependent: :delete_all

    has_and_belongs_to_many :companies

    def create_turns_availabilities(date, company)
        company_turns = company.turns.where(date: date.beginning_of_week..date.end_of_week.at_end_of_day)
        
        company_turns.each do |turn|
            TurnAvailability.create(turn_id: turn.id, engineer_id: self.id, company_id: company.id, available: false, date: turn.date)
        end
    end

    def available_turns(date, company)
        self.turn_availabilities.where(company: company, date: date.beginning_of_week..date.end_of_week.at_end_of_day, available: true)
    end

    def unavailable_turns(date, company)
        self.turn_availabilities.where(company: company, date: date.beginning_of_week..date.end_of_week.at_end_of_day, available: false)
    end
end
