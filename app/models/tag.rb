class Tag < ApplicationRecord
    has_many :task_tags, dependent: :destroy
    has_many :tasks, through: :task_tags
    # def self.search(search)
    #     if search 
    #         Tag.where(['tags_name LIKE ?', "%#{search}%"])
    #     else
            
    #     end
    # end
end
