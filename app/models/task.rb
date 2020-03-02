class Task < ApplicationRecord
    belongs_to :project
    has_many :task_tags, dependent: :destroy
    has_many :tags, through: :task_tags, dependent: :destroy

    def save_tasks(tags)
        current_tags = self.tags.pluck(:tags_name) unless self.tags.nil?
        old_tags = current_tags - tags
        new_tags = tags - current_tags

        # Destroy
        old_tags.each do |old_name|
            self.tags.delete Tag.find_by(tags_name:old_name)
        end

        # Create
        new_tags.each do |new_name|
            task_tag = Tag.find_or_create_by(tags_name:new_name)
            self.tags << task_tag
        end
    end
end
