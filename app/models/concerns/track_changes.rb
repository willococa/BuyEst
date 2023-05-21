# app/models/concerns/track_changes.rb
module TrackChanges
    extend ActiveSupport::Concern
    included do
        has_paper_trail
  
        def admin_creator
            @admin_creator ||= begin
            creator_id = versions.order(:created_at).pluck(:whodunnit).first
            Admin.find_by(id: creator_id)
            end
        end
  
        def admin_updaters
            @admin_updaters ||= begin
            creator_id = versions.order(:created_at).pluck(:whodunnit).first
            updated_user_ids = versions.where.not(whodunnit: creator_id).pluck(:whodunnit)
            Admin.where(id: updated_user_ids)
            end
        end
    end
end
  