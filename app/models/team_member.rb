class TeamMember < ApplicationRecord
  belongs_to :team
  belongs_to :runner
end
