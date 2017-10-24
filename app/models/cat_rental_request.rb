class CatRentalRequest < ApplicationRecord
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validate :overlapping_approved_requests

  STATUS = ["PENDING","APPROVED","DENIED"]

  validates :status,  inclusion: { in: STATUS, message: 'invalid status'}

  belongs_to :cat


  def overlapping_requests
    CatRentalRequest
      .where("cat_id = #{self.cat_id}")
      .where("(start_date BETWEEN '#{self.start_date}' AND '#{self.end_date}') OR
              (end_date BETWEEN '#{self.start_date}' AND '#{self.end_date}') ")
  end

  def overlapping_approved_requests
    if self.overlapping_requests.where("status = 'APPROVED'").exists?
      errors.add(:status, "overlapping request")
    end
  end

end
