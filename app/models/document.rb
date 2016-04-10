class Document < ActiveRecord::Base
	has_attached_file :add_attachment,
					styles: { medium: "300x300>", thumb: "100x100>" },
					:url => "/assets/image/:class/:basename.:extension",
					:path => ":rails_root/public/assets/image/:class/:basename.:extension"
  	validates_attachment_content_type :add_attachment, content_type: /\Aimage\/.*\Z/
end